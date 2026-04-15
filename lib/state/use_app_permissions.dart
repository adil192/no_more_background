import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:pool/pool.dart';

typedef PermissionMap = Map<AdbApp, AdbAppPermissions>;
final _caches = <String, PermissionMap>{};

PermissionMap useAppPermissions(String deviceSerial, List<AdbApp> apps) {
  final permissions = _caches.putIfAbsent(deviceSerial, () => {});
  final state = use(_AppPermissions(deviceSerial, apps, permissions));
  useMemoized(state._queueAll, [apps]);
  return permissions;
}

class _AppPermissions extends Hook<_AppPermissionsState> {
  const _AppPermissions(this.deviceSerial, this.apps, this.permissions);

  final String deviceSerial;
  final List<AdbApp> apps;
  final PermissionMap permissions;

  @override
  _AppPermissionsState createState() => _AppPermissionsState();
}

class _AppPermissionsState
    extends HookState<_AppPermissionsState, _AppPermissions> {
  static const _poolSize = 4;
  final _pool = Pool(_poolSize);

  late final Future<List<String>> restrictedDataAppUids =
      Adb.getAppsWithRestrictedBackgroundData(hook.deviceSerial);

  @override
  _AppPermissionsState build(BuildContext context) {
    return this;
  }

  void _queueAll() {
    if (_pool.isClosed) return;

    final apps = hook.apps;
    var submitted = 0;
    for (var i = 0; i < apps.length; ++i) {
      final app = apps[i];
      if (hook.permissions.containsKey(app)) continue;

      final future = _pool.withResource(() => _loadSingle(app));
      ++submitted;

      if (submitted % _poolSize == 0) {
        future.then((_) {
          if (!_pool.isClosed) setState(() {});
        });
      }
    }
  }

  Future<void> _loadSingle(AdbApp app) async {
    if (_pool.isClosed) return;
    hook.permissions[app] = AdbAppPermissions(
      runAnyInBackground: await Adb.getRunAnyInBackground(
        hook.deviceSerial,
        app,
      ),
      restrictBackgroundData: (await restrictedDataAppUids).contains(app.uid),
    );
  }

  @override
  void dispose() {
    _pool.close();
    super.dispose();
  }
}
