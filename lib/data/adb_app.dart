import 'package:no_more_background/data/lawn_icons.dart';

class AdbApp {
  AdbApp(
    this.packageName, {
    required this.installer,
    required this.uid,
    required this.isSystemApp,
    required this.isUninstalled,
    required this.displayName,
  });

  factory AdbApp.fromAdbOutput(
    String line, {
    required bool isSystemApp,
    required bool isUninstalled,
  }) {
    line = line.trim();
    final regex = RegExp(r'package:([^\s]+)\s+installer=(\S+)\s+uid:(\d+)');
    final match = regex.firstMatch(line);
    if (match == null) {
      throw ArgumentError('Invalid adb app line: $line');
    }
    final packageName = match.group(1)!;
    final installer = match.group(2)!;
    final uid = match.group(3)!;
    final displayName =
        LawnIcons.getDisplayName(packageName) ??
        // Fallback to last segment of package name
        packageName.split('.').last;
    return AdbApp(
      packageName,
      installer: installer == 'null' ? '' : installer,
      uid: uid,
      isSystemApp: isSystemApp,
      isUninstalled: isUninstalled,
      displayName: displayName,
    );
  }

  final String packageName;

  final String installer;

  final String uid;

  final bool isSystemApp;

  /// E.g. if the app has been archived
  bool isUninstalled;

  final String displayName;

  @override
  String toString() {
    final buffer = StringBuffer('AdbApp($uid){ ');
    buffer.write('$displayName ($packageName)');
    if (installer.isNotEmpty) buffer.write(' from $installer');
    if (isSystemApp) buffer.write(', system app');
    if (isUninstalled) buffer.write(', uninstalled');
    buffer.write(' }');
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdbApp && packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;
}
