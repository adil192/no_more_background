import 'package:flutter/material.dart';

@immutable
class AdbApp {
  const AdbApp(this.packageName, {required this.isSystemApp});

  factory AdbApp.fromAdbOutput(String line, {required bool isSystemApp}) {
    // TODO: Handle `installer=com.android.vending`
    line = line.trim();
    assert(line.startsWith('package:'), 'Invalid adb app line: $line');
    final packageName = line.substring('package:'.length);
    return AdbApp(packageName, isSystemApp: isSystemApp);
  }

  final String packageName;
  final bool isSystemApp;

  @override
  String toString() => 'AdbApp($packageName, isSystemApp: $isSystemApp)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdbApp &&
          packageName == other.packageName &&
          isSystemApp == other.isSystemApp;

  @override
  int get hashCode => Object.hash(packageName, isSystemApp);
}
