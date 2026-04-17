import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:jni/jni.dart';
import 'package:no_more_background/compute/root_shell_util.g.dart';
import 'package:no_more_background/compute/test_adb_impl.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:shizuku_api/shizuku_api.dart';

abstract class Adb {
  static AdbImpl? impl;
  static Future<AdbImpl?> findAdb() async {
    if (!kReleaseMode) {
      await stows.useFakeAdb.waitUntilRead();
      if (stows.useFakeAdb.value) {
        debugPrint('Using fake adb implementation');
        return FakeAdbImpl();
      }
    }

    if (Platform.isAndroid) {
      if (stows.useRoot.value && RootShellUtil.isRooted) return RootAdbImpl();

      final shizukuApi = ShizukuAdbImpl.shizuku;
      final isBinderRunning = await shizukuApi.pingBinder() ?? false;
      if (!isBinderRunning) {
        debugPrint(
          'Shizuku binder is not running, is Shizuku installed and running?',
        );
        return null;
      }

      final hasPermission = await shizukuApi.checkPermission() ?? false;
      if (!hasPermission) {
        final granted = await shizukuApi.requestPermission() ?? false;
        if (!granted) {
          debugPrint('Shizuku permission is not granted, cannot continue.');
          return null;
        }
      }

      return ShizukuAdbImpl();
    }

    // Flatpak mounts the host-os at /run/host, so try there.
    if (Platform.isLinux) {
      final file = File('/run/host/usr/bin/adb');
      if (file.existsSync()) {
        debugPrint('Using adb at ${file.path}');
        return AdbImpl(file.path);
      }
    }

    // Otherwise, try to find adb in PATH.
    final result = Platform.isWindows
        ? await Process.run('where', ['adb'], runInShell: true)
        : await Process.run('which', ['adb'], runInShell: true);
    final stdout = (result.stdout as String).trim();
    if (result.exitCode == 0) {
      debugPrint('Using adb at $stdout');
      return AdbImpl(stdout);
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
        debugPrint('Using adb at $path');
        return AdbImpl(path);
      }
    }

    debugPrint('Unable to find adb, PATH=${Platform.environment['PATH']}');
    return null;
  }

  static Future<void> ensureInitialized() async {
    impl ??= await findAdb();
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

  static Future<String?> getDeviceName(String deviceSerial) async {
    final impl = Adb.impl;
    if (impl == null) return null;
    final manufacturer = await impl.getProp(
      deviceSerial,
      'ro.product.manufacturer',
    );
    final model = await impl.getProp(deviceSerial, 'ro.product.model');
    if (model.isEmpty) return null;
    return [if (manufacturer.isNotEmpty) manufacturer, model].join(' ');
  }

  static Future<List<AdbApp>> getApps(
    String deviceSerial, {
    required bool includeSystemApps,
  }) async {
    final appLists = await impl?.getApps(
      deviceSerial,
      includeSystemApps: includeSystemApps,
    );
    if (appLists == null) return const [];

    /// This includes both installed apps, and installed/uninstalled apps.
    final appsWithDuplicates = [
      ..._parseAppList(
        appLists.systemApps.split('\n'),
        isSystemApp: true,
        isUninstalled: false,
      ),
      ..._parseAppList(
        appLists.systemAppsWithUninstalled.split('\n'),
        isSystemApp: true,
        isUninstalled: true,
      ),
      ..._parseAppList(
        appLists.userApps.split('\n'),
        isSystemApp: false,
        isUninstalled: false,
      ),
      ..._parseAppList(
        appLists.userAppsWithUninstalled.split('\n'),
        isSystemApp: false,
        isUninstalled: true,
      ),
    ];

    final discoveredPackageNames = <String>{};
    final apps = <AdbApp>[];

    for (final app in appsWithDuplicates) {
      if (discoveredPackageNames.contains(app.packageName)) continue;
      discoveredPackageNames.add(app.packageName);
      apps.add(app);
    }

    apps.sort(
      (a, b) =>
          a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()),
    );

    return apps;
  }

  static Iterable<AdbApp> _parseAppList(
    List<String> appList, {
    required bool isSystemApp,
    required bool isUninstalled,
  }) sync* {
    for (final line in appList) {
      if (line.isEmpty) continue;
      if (line.startsWith('Error: java.lang.SecurityException')) {
        // Adb without root can't access other users (i.e. a work profile).
        // Stop iterating since the next lines are just stacktraces.
        break;
      }
      yield AdbApp.fromAdbOutput(
        line,
        isSystemApp: isSystemApp,
        isUninstalled: isUninstalled,
      );
    }
  }

  static Future<List<String>> getAppsWithRestrictedBackground(
    String deviceSerial,
  ) async {
    final output = await impl?.getAppsWithRestrictedBackground(deviceSerial);
    if (output == null || output.isEmpty) return const [];
    if (output.startsWith('Error')) {
      throw PlatformException(code: '500', message: output);
    }
    return output.trim().split('\n');
  }

  static Future<void> setRestrictedBackground(
    String deviceSerial,
    AdbApp app,
    bool restricted,
  ) async {
    await impl?.setRestrictedBackground(app, deviceSerial, restricted);
  }

  static Future<List<String>> getAppsWithRestrictedBackgroundData(
    String deviceSerial,
  ) async {
    final output = await impl?.getAppsWithRestrictedBackgroundData(
      deviceSerial,
    );
    if (output == null || output.isEmpty) return const [];
    // E.g. "Restrict background blacklisted UIDs: 10321 10344 10353 10396"
    final parts = output.trim().split(': ');
    assert(parts.length == 2, 'Unexpected output from adb: $output');
    if (parts.length != 2) return const [];
    final uids = parts[1].trim().split(' ');
    return uids;
  }

  static Future<void> setRestrictBackgroundData(
    String deviceSerial,
    AdbApp app,
    bool restrict,
  ) async {
    await impl?.setRestrictBackgroundData(deviceSerial, app, restrict);
  }

  /// Archives the app.
  ///
  /// The app's APKs and cache are deleted while the user data is kept.
  static Future<void> archiveApp(String deviceSerial, AdbApp app) async {
    await impl?.archiveApp(deviceSerial, app);
  }

  /// Requests to unarchive a currently archived app.
  ///
  /// The app will be redownloaded from the responsible installer,
  /// e.g. the Google Play Store.
  static Future<void> requestUnarchiveApp(
    String deviceSerial,
    AdbApp app,
  ) async {
    await impl?.requestUnarchiveApp(deviceSerial, app);
  }
}

class AdbImpl {
  const AdbImpl(this.exe);

  final String exe;

  FutureOr<String> getDevices() => runAdb(['devices', '-l'], silent: true);

  Future<AppLists> getApps(
    String deviceSerial, {
    required bool includeSystemApps,
  }) async {
    final args = [
      // -i: see the installer for the packages
      // -U: also show the package UID
      '-s', deviceSerial, 'shell', 'pm', 'list', 'packages', '-i', '-U',
    ];
    return (
      // -s: filter to only show system packages
      // -3: filter to only show third party packages
      // -u: also include uninstalled packages
      systemApps: includeSystemApps ? await runAdb([...args, '-s']) : '',
      systemAppsWithUninstalled: includeSystemApps
          ? await runAdb([...args, '-s', '-u'])
          : '',
      userApps: await runAdb([...args, '-3']),
      userAppsWithUninstalled: await runAdb([...args, '-3', '-u']),
    );
  }

  Future<String> getAppsWithRestrictedBackground(String deviceSerial) async {
    return await runAdb([
      '-s',
      deviceSerial,
      'shell',
      'cmd',
      'appops',
      'query-op',
      'RUN_ANY_IN_BACKGROUND',
      'ignore',
    ], silent: true);
  }

  Future<void> setRestrictedBackground(
    AdbApp app,
    String deviceSerial,
    bool restricted,
  ) async {
    await runAdb([
      '-s',
      deviceSerial,
      'shell',
      'cmd',
      'appops',
      'set',
      app.packageName,
      'RUN_ANY_IN_BACKGROUND',
      restricted ? 'ignore' : 'allow',
    ]);
  }

  Future<String> getAppsWithRestrictedBackgroundData(
    String deviceSerial,
  ) async {
    return await runAdb([
      '-s',
      deviceSerial,
      'shell',
      'cmd',
      'netpolicy',
      'list',
      'restrict-background-blacklist',
    ]);
  }

  Future<void> setRestrictBackgroundData(
    String deviceSerial,
    AdbApp app,
    bool restrict,
  ) async {
    await runAdb([
      '-s',
      deviceSerial,
      'shell',
      'cmd',
      'netpolicy',
      restrict ? 'add' : 'remove',
      'restrict-background-blacklist',
      app.uid,
    ]);
  }

  /// Archives the app.
  ///
  /// The app's APKs and cache are deleted while the user data is kept.
  Future<void> archiveApp(String deviceSerial, AdbApp app) async {
    await runAdb([
      '-s',
      deviceSerial,
      'shell',
      'pm',
      'archive',
      app.packageName,
    ]);
  }

  /// Requests to unarchive a currently archived app.
  ///
  /// The app will be redownloaded from the responsible installer,
  /// e.g. the Google Play Store.
  Future<void> requestUnarchiveApp(String deviceSerial, AdbApp app) async {
    await runAdb([
      '-s',
      deviceSerial,
      'shell',
      'pm',
      'request-unarchive',
      app.packageName,
    ]);
  }

  @protected
  @visibleForOverriding
  Future<String> getProp(String deviceSerial, String key) async {
    return (await runAdb(['-s', deviceSerial, 'shell', 'getprop', key])).trim();
  }

  @protected
  @visibleForOverriding
  Future<String> runAdb(List<String> args, {bool silent = false}) async {
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

class RootAdbImpl extends AdbImpl {
  const RootAdbImpl([super.exe = 'adb']);

  @override
  String getDevices() => '''
List of devices attached
localhost           device extra:root
''';

  @override
  Future<String> runAdb(List<String> args, {bool silent = false}) async {
    if (args[0] == '-s') args = args.sublist(2);
    assert(
      args[0] == 'shell',
      'Only shell commands are supported on-device: ${args.join(' ')}',
    );
    if (args[0] != 'shell') return '';
    args = args.sublist(1);
    if (!silent) debugPrint('\$ ${args.join(' ')}');

    final (exitCode, message) = await runCommand(args);
    if (exitCode != 0) {
      throw PlatformException(code: exitCode.toString(), message: message);
    }
    return message;
  }

  @protected
  FutureOr<(int exitCode, String message)> runCommand(List<String> args) {
    final result = RootShellUtil.run(args.join(' ').toJString());
    try {
      final exitCode = result.first!.intValue();
      final message = result.second!.toDartString();
      return (exitCode, message);
    } finally {
      result.release();
    }
  }
}

class ShizukuAdbImpl extends RootAdbImpl {
  static final shizuku = ShizukuApi();

  ShizukuAdbImpl() : super('shizuku_adb');

  @override
  String getDevices() => '''
List of devices attached
localhost           device extra:shizuku
''';

  @override
  @protected
  Future<(int exitCode, String message)> runCommand(List<String> args) async {
    final result = await shizuku.runCommand(args.join(' '));
    if (result == null) return (1, 'Shizuku command failed');
    return (0, result);
  }
}

typedef AppLists = ({
  String systemApps,
  String systemAppsWithUninstalled,
  String userApps,
  String userAppsWithUninstalled,
});
