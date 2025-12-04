import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

typedef PermissionMap = Map<AdbApp, AdbAppPermissions>;

class AdbAppPermissions {
  static final _caches = <AdbDevice, PermissionMap>{};
  static PermissionMap of(AdbDevice device) =>
      _caches.putIfAbsent(device, () => {});

  AdbAppPermissions({
    required this.runAnyInBackground,
    required this.restrictBackgroundData,
  });

  bool runAnyInBackground;
  bool restrictBackgroundData;
}
