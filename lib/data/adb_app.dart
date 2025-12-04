import 'package:flutter/material.dart';

@immutable
class AdbApp {
  const AdbApp(
    this.packageName, {
    required this.installer,
    required this.isSystemApp,
  });

  factory AdbApp.fromAdbOutput(String line, {required bool isSystemApp}) {
    line = line.trim();
    final regex = RegExp(r'package:([^\s]+)(\s+installer=(\S+))?');
    final match = regex.firstMatch(line);
    if (match == null) {
      throw ArgumentError('Invalid adb app line: $line');
    }
    final packageName = match.group(1)!;
    final installer = match.group(3) ?? 'null';
    return AdbApp(packageName, installer: installer, isSystemApp: isSystemApp);
  }

  final String packageName;

  /// May be 'null'
  final String installer;
  final bool isSystemApp;

  @override
  String toString() =>
      'AdbApp($packageName, installer: $installer, isSystemApp: $isSystemApp)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdbApp && packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;
}
