import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

abstract class Adb {
  static AdbImpl? impl;
  static Future<void> _findAdb() async {
    if (impl != null) return;

    final result = Platform.isWindows
        ? await Process.run('where', ['adb'], runInShell: true)
        : await Process.run('which', ['adb'], runInShell: true);
    final stdout = (result.stdout as String).trim();
    if (result.exitCode != 0) {
      final stderr = (result.stderr as String).trim();
      debugPrint('Unable to find adb: $stderr, $stdout');
      return;
    }
    impl = AdbImpl(stdout);
    debugPrint('Using adb at ${impl!.exe}');
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
      final parts = line.split(RegExp(r'\s+'));
      devices.add(AdbDevice.fromAdbOutput(parts));
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
