import 'package:flutter/material.dart';
import 'package:no_more_background/data/delta_icons.dart';
import 'package:no_more_background/data/lawn_icons.dart';

@immutable
class AdbApp {
  const AdbApp(
    this.packageName, {
    required this.installer,
    required this.uid,
    required this.isSystemApp,
    this.displayName,
    this.icon,
  });

  factory AdbApp.fromAdbOutput(String line, {required bool isSystemApp}) {
    line = line.trim();
    final regex = RegExp(r'package:([^\s]+)\s+installer=(\S+)\s+uid:(\d+)');
    final match = regex.firstMatch(line);
    if (match == null) {
      throw ArgumentError('Invalid adb app line: $line');
    }
    final packageName = match.group(1)!;
    final installer = match.group(2)!;
    final uid = match.group(3)!;
    final displayName = LawnIcons.getDisplayName(packageName);
    final icon = DeltaIcons.getIcon(packageName);
    return AdbApp(
      packageName,
      installer: installer,
      uid: uid,
      isSystemApp: isSystemApp,
      displayName: displayName,
      icon: icon,
    );
  }

  final String packageName;

  /// May be 'null'
  final String installer;

  final String uid;

  final bool isSystemApp;

  final String? displayName;

  final AssetImage? icon;

  String get bestAvailableName => displayName ?? packageName;

  @override
  String toString() =>
      'AdbApp($displayName ($packageName), installer: $installer, uid: $uid, isSystemApp: $isSystemApp, icon: $icon)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdbApp && packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;
}
