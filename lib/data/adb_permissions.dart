import 'package:no_more_background/data/adb_app.dart';

typedef PermissionMap = Map<AdbApp, AdbAppPermissions>;

class AdbAppPermissions {
  static final _caches = <String, PermissionMap>{};
  static PermissionMap of(String deviceSerial) =>
      _caches.putIfAbsent(deviceSerial, () => {});

  AdbAppPermissions({
    required this.runAnyInBackground,
    required this.restrictBackgroundData,
  });

  bool runAnyInBackground;
  bool restrictBackgroundData;

  @override
  bool operator ==(Object other) =>
      other is AdbAppPermissions &&
      runAnyInBackground == other.runAnyInBackground &&
      restrictBackgroundData == other.restrictBackgroundData;

  @override
  int get hashCode => Object.hash(runAnyInBackground, restrictBackgroundData);

  factory AdbAppPermissions.fromJson(Map<String, dynamic> json) {
    return AdbAppPermissions(
      runAnyInBackground: json['runAnyInBackground'],
      restrictBackgroundData: json['restrictBackgroundData'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'runAnyInBackground': runAnyInBackground,
      'restrictBackgroundData': restrictBackgroundData,
    };
  }

  AdbAppPermissions copy() => AdbAppPermissions(
    runAnyInBackground: runAnyInBackground,
    restrictBackgroundData: restrictBackgroundData,
  );
}
