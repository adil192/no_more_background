import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Adb {
  static RawAdb? impl;
  static Future<void> _findAdb() async {
    if (impl != null) return;

    final result = Platform.isWindows
        ? await Process.run('where', ['adb'])
        : await Process.run('which', ['adb']);
    if (result.exitCode != 0) return;
    final exe = (result.stdout as String).trim();
    impl = RawAdb(exe);
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
      devices.add(AdbDevice(parts[0], parts[1]));
    }
    return devices;
  }
}

class RawAdb {
  const RawAdb(this.exe);

  final String exe;

  Future<String> getDevices() => _runAdb(['devices']);

  Future<String> _runAdb(List<String> args) async {
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

@immutable
class AdbDevice {
  const AdbDevice(this.id, this.state);

  final String id;
  final String state;
}
