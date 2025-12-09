import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

abstract class Adb {
  static AdbImpl? impl;
  static Future<void> _findAdb() async {
    if (impl != null) return;

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
      final line = lines[i];
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
