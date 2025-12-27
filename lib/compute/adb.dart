import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

abstract class Adb {
  static AdbImpl? impl;
  static Future<void> _findAdb() async {
    if (impl != null) return;

    if (!kReleaseMode && const bool.fromEnvironment('FAKE_ADB')) {
      impl = TestAdbImpl();
      debugPrint('Using fake adb implementation');
      return;
    }

    // Flatpak mounts the host-os at /run/host, so try there.
    if (Platform.isLinux) {
      final file = File('/run/host/usr/bin/adb');
      if (file.existsSync()) {
        impl = AdbImpl(file.path);
        debugPrint('Using adb at ${impl!.exe}');
        return;
      }
    }

    // Otherwise, try to find adb in PATH.
    final result = Platform.isWindows
        ? await Process.run('where', ['adb'], runInShell: true)
        : await Process.run('which', ['adb'], runInShell: true);
    final stdout = (result.stdout as String).trim();
    if (result.exitCode == 0) {
      impl = AdbImpl(stdout);
      debugPrint('Using adb at ${impl!.exe}');
      return;
    }

    // Otherwise, check common locations.
    final commonPaths = [
      if (Platform.isLinux)
        '${Platform.environment['HOME']}/Android/Sdk/platform-tools/adb',
      if (Platform.isWindows)
        '${Platform.environment['LOCALAPPDATA']}\\Android\\Sdk\\platform-tools\\adb.exe',
      if (Platform.isMacOS)
        '${Platform.environment['HOME']}/Library/Android/sdk/platform-tools/adb',
    ];
    for (final path in commonPaths) {
      final file = File(path);
      if (file.existsSync()) {
        impl = AdbImpl(file.path);
        debugPrint('Using adb at ${impl!.exe}');
        return;
      }
    }

    debugPrint('Unable to find adb, PATH=${Platform.environment['PATH']}');
  }

  static Future<void> ensureInitialized() async {
    await _findAdb();
  }

  static Future<List<AdbDevice>> getDevices() async {
    final devicesString = await impl?.getDevices();
    if (devicesString == null) return const [];

    final lines = devicesString.split('\n');
    assert(lines[0] == 'List of devices attached');

    final devices = <AdbDevice>[];
    for (int i = 1; i < lines.length; ++i) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;
      devices.add(AdbDevice.fromAdbOutput(line));
    }
    return devices;
  }

  static Future<List<AdbApp>> getApps(AdbDevice device) async {
    final (systemApps, userApps) = await impl?.getApps(device) ?? (null, null);
    if (systemApps == null || userApps == null) return const [];
    final apps = <AdbApp>[
      for (final line in systemApps.split('\n'))
        if (line.isNotEmpty) AdbApp.fromAdbOutput(line, isSystemApp: true),
      for (final line in userApps.split('\n'))
        if (line.isNotEmpty) AdbApp.fromAdbOutput(line, isSystemApp: false),
    ];
    apps.sort((a, b) => a.packageName.compareTo(b.packageName));
    return apps;
  }

  static Future<bool> getRunAnyInBackground(
    AdbDevice device,
    AdbApp app,
  ) async {
    final output = await impl?.getRunAnyInBackground(app, device);
    if (output == null) return false;
    assert(
      output.trim() == 'RUN_ANY_IN_BACKGROUND: ignore' ||
          output.trim() == 'RUN_ANY_IN_BACKGROUND: allow' ||
          output.startsWith('No operations.\nDefault mode:'),
      'Unexpected output from adb: $output',
    );
    // `RUN_ANY_IN_BACKGROUND: ignore` or `RUN_ANY_IN_BACKGROUND: allow`
    return output.contains('allow');
  }

  static Future<void> setRunAnyInBackground(
    AdbDevice device,
    AdbApp app,
    bool allow,
  ) async {
    await impl?.setRunAnyInBackground(app, device, allow);
  }

  static Future<List<String>> getAppsWithRestrictedBackgroundData(
    AdbDevice device,
  ) async {
    final output = await impl?.getAppsWithRestrictedBackgroundData(device);
    if (output == null || output.isEmpty) return const [];
    // E.g. "Restrict background blacklisted UIDs: 10321 10344 10353 10396"
    final parts = output.trim().split(': ');
    assert(parts.length == 2, 'Unexpected output from adb: $output');
    if (parts.length != 2) return const [];
    final uids = parts[1].trim().split(' ');
    return uids;
  }

  static Future<void> setRestrictBackgroundData(
    AdbDevice device,
    AdbApp app,
    bool restrict,
  ) async {
    await impl?.setRestrictBackgroundData(device, app, restrict);
  }
}

class AdbImpl {
  const AdbImpl(this.exe);

  final String exe;

  Future<String> getDevices() => _runAdb(['devices', '-l']);

  Future<(String system, String user)> getApps(AdbDevice device) async => (
    // System packages
    await _runAdb([
      '-s',
      device.serial,
      'shell',
      'cmd',
      'package',
      'list',
      'packages',
      '-i',
      '-s',
      '-U',
    ]),
    // Third party (user) packages
    await _runAdb([
      '-s',
      device.serial,
      'shell',
      'cmd',
      'package',
      'list',
      'packages',
      '-i',
      '-3',
      '-U',
    ]),
  );

  Future<String> getRunAnyInBackground(AdbApp app, AdbDevice device) async {
    return await _runAdb([
      '-s',
      device.serial,
      'shell',
      'cmd',
      'appops',
      'get',
      app.packageName,
      'RUN_ANY_IN_BACKGROUND',
    ], silent: true);
  }

  Future<void> setRunAnyInBackground(
    AdbApp app,
    AdbDevice device,
    bool allow,
  ) async {
    await _runAdb([
      '-s',
      device.serial,
      'shell',
      'cmd',
      'appops',
      'set',
      app.packageName,
      'RUN_ANY_IN_BACKGROUND',
      allow ? 'allow' : 'ignore',
    ]);
  }

  Future<String> getAppsWithRestrictedBackgroundData(AdbDevice device) async {
    return await _runAdb([
      '-s',
      device.serial,
      'shell',
      'cmd',
      'netpolicy',
      'list',
      'restrict-background-blacklist',
    ]);
  }

  Future<void> setRestrictBackgroundData(
    AdbDevice device,
    AdbApp app,
    bool restrict,
  ) async {
    await _runAdb([
      '-s',
      device.serial,
      'shell',
      'cmd',
      'netpolicy',
      restrict ? 'add' : 'remove',
      'restrict-background-blacklist',
      app.uid,
    ]);
  }

  @protected
  Future<String> _runAdb(List<String> args, {bool silent = false}) async {
    if (!silent) debugPrint('\$ adb ${args.join(' ')}');
    final result = await Process.run(exe, args);
    final stdout = result.stdout as String;
    if (result.exitCode != 0) {
      throw PlatformException(
        code: result.exitCode.toString(),
        message: stdout,
      );
    }
    return stdout;
  }
}

@visibleForTesting
class TestAdbImpl implements AdbImpl {
  TestAdbImpl();
  final outputs = TestAdbImplOutputs();

  @override
  final String exe = '/tmp/test/adb';

  @override
  Future<String> _runAdb(List<String> args, {bool silent = false}) =>
      Future.error(
        UnimplementedError('adb binary is not available in TestAdbImpl'),
      );

  @override
  Future<(String, String)> getApps(AdbDevice device) async => outputs.getApps;

  @override
  Future<String> getAppsWithRestrictedBackgroundData(AdbDevice device) async =>
      outputs.getAppsWithRestrictedBackgroundData;

  @override
  Future<String> getDevices() async => outputs.getDevices;

  @override
  Future<String> getRunAnyInBackground(AdbApp app, AdbDevice device) async =>
      outputs.getRunAnyInBackgroundMap[app.packageName] ?? true
      ? 'RUN_ANY_IN_BACKGROUND: allow'
      : 'RUN_ANY_IN_BACKGROUND: ignore';

  @override
  Future<void> setRestrictBackgroundData(
    AdbDevice device,
    AdbApp app,
    bool restrict,
  ) async {}

  @override
  Future<void> setRunAnyInBackground(
    AdbApp app,
    AdbDevice device,
    bool allow,
  ) async {
    outputs.getRunAnyInBackgroundMap[app.packageName] = allow;
  }
}

@visibleForTesting
class TestAdbImplOutputs {
  var getDevices = '''
List of devices attached
0a388e93           device usb:1-1 product:razor model:Nexus_7 device:flo
B05699QHA000B3     unauthorized usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:9
192.168.0.18:5555  device product:sabrina_prod_stable model:Chromecast device:sabrina transport_id:1

''';
  var getApps = (
    '''
package:android  installer=null uid:1000
package:android.auto_generated_rro_product__  installer=null uid:1001
package:android.auto_generated_rro_vendor__  installer=null uid:1002
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
package:com.google.android.youtube  installer=com.android.vending uid:10021
''',
    '''
package:app.revanced.android.youtube  installer=null uid:10045
package:app.revanced.manager.flutter  installer=null uid:10050
package:cn.com.aftershokz.app  installer=com.android.vending uid:10060
package:com.abdurazaaqmohammed.AntiSplit  installer=com.google.android.packageinstaller uid:10065
package:com.adilhanney.ricochlime  installer=com.android.vending uid:10075
package:com.adilhanney.saber  installer=com.google.android.packageinstaller uid:10080
package:com.amazon.mShop.android.shopping  installer=com.android.vending uid:10090
package:com.celzero.bravedns  installer=com.android.vending uid:10095
package:com.discord  installer=com.android.vending uid:10100
package:com.ebay.mobile  installer=com.android.vending uid:10105
package:com.fitbit.FitbitMobile  installer=com.android.vending uid:10110
package:com.google.android.apps.adm  installer=com.android.vending uid:10115
''',
  );
  var getRunAnyInBackgroundMap = {
    'app.revanced.android.youtube': false,
    'app.revanced.manager.flutter': false,
  };
  var getAppsWithRestrictedBackgroundData =
      'Restrict background blacklisted UIDs: 10045 10050 10065 10075 10090 10100';
}
