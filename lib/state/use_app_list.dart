import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app_manager/compute/adb.dart';
import 'package:app_manager/data/adb_app.dart';
import 'package:app_manager/data/stows.dart';

List<AdbApp> useAppList(String deviceSerial) {
  useListenable(stows.showSystemApps);
  return use(_AppList(deviceSerial));
}

class _AppList extends Hook<List<AdbApp>> {
  const _AppList(this.deviceSerial);

  final String deviceSerial;

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends HookState<List<AdbApp>, _AppList> {
  var _apps = <AdbApp>[];

  var _hasLoadedSystemApps = false;

  @override
  void initHook() {
    _load(stows.showSystemApps.value);
  }

  Future<void> _load(bool showSystemApps) async {
    _hasLoadedSystemApps |= showSystemApps;
    _apps = await Adb.getApps(
      hook.deviceSerial,
      includeSystemApps: showSystemApps,
    );
    if (context.mounted) setState(() {});
  }

  @override
  List<AdbApp> build(BuildContext context) {
    final showSystemApps = stows.showSystemApps.value;
    if (showSystemApps && !_hasLoadedSystemApps) _load(showSystemApps);
    return _apps;
  }

  @override
  void dispose() {
    _apps = const [];
  }
}
