import 'package:app_manager/data/adb_permissions.dart';

class ReviewedApp {
  const ReviewedApp({required this.packageName, required this.permissions});

  final String packageName;

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
