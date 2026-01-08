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
}
