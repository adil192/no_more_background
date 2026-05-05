import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app_manager/compute/adb.dart';
import 'package:app_manager/data/adb_app.dart';
import 'package:app_manager/data/adb_permissions.dart';
import 'package:app_manager/data/is_this_a_test.dart';

typedef PermissionMap = Map<AdbApp, AdbAppPermissions>;
final _caches = <String, PermissionMap>{};

@visibleForTesting
Completer? permissionsCompleter;

PermissionMap useAppPermissions(String deviceSerial, List<AdbApp> apps) {
  final permissions = _caches.putIfAbsent(deviceSerial, () => {});

  final restrictedDataAppUidsFuture = useMemoized(
    () => Adb.getAppsWithRestrictedBackgroundData(deviceSerial),
  );
  final restrictedDataAppUids = useFuture(restrictedDataAppUidsFuture);

  final restrictedBgAppsFuture = useMemoized(
    () => Adb.getAppsWithRestrictedBackground(deviceSerial),
  );
  final restrictedBgApps = useFuture(restrictedBgAppsFuture);

  useMemoized(() {
    if (!restrictedDataAppUids.hasData) return;
    if (!restrictedBgApps.hasData) return;

    for (final app in apps) {
      permissions[app] ??= AdbAppPermissions(
        runAnyInBackground: !restrictedBgApps.data!.contains(app.packageName),
        restrictBackgroundData: restrictedDataAppUids.data!.contains(app.uid),
      );
    }

    if (isThisATest &&
        permissionsCompleter != null &&
        !permissionsCompleter!.isCompleted) {
      permissionsCompleter!.complete();
    }
  }, [apps, restrictedDataAppUids.hasData, restrictedBgApps.hasData]);

  return permissions;
}
