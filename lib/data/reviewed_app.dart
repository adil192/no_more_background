import 'package:no_more_background/data/adb_permissions.dart';

class ReviewedApp {
  const ReviewedApp({required this.packageName, required this.permissions});

  final String packageName;

  /// The user has reviewed these permissions to be correct.
  /// If they don't match, the app will be marked as needing review again.
  final AdbAppPermissions permissions;

  factory ReviewedApp.fromJson(Map<String, dynamic> json) {
    return ReviewedApp(
      packageName: json['packageName'],
      permissions: AdbAppPermissions.fromJson(json['permissions']),
    );
  }
  Map<String, dynamic> toJson() {
    return {'packageName': packageName, 'permissions': permissions.toJson()};
  }
}
