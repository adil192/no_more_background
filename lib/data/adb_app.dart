import 'package:flutter/material.dart';

@immutable
class AdbApp {
  const AdbApp(
    this.packageName, {
    required this.installer,
    this.uid,
    required this.isSystemApp,
  });

  factory AdbApp.fromAdbOutput(String line, {required bool isSystemApp}) {
    line = line.trim();
    final regex = RegExp(
      r'package:([^\s]+)(\s+installer=(\S+))?(\s+uid:(\d+))?',
    );
    final match = regex.firstMatch(line);
    if (match == null) {
      throw ArgumentError('Invalid adb app line: $line');
    }
    final packageName = match.group(1)!;
    final installer = match.group(3) ?? 'null';
    final uid = match.group(5);
    return AdbApp(
      packageName,
      installer: installer,
      uid: uid,
      isSystemApp: isSystemApp,
    );
  }

  final String packageName;

  /// May be 'null'
  final String installer;

  final String? uid;

  final bool isSystemApp;

  @override
  String toString() =>
      'AdbApp($packageName, installer: $installer, uid: $uid, isSystemApp: $isSystemApp)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdbApp && packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;
}
