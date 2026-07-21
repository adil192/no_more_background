import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/stows.dart';

List<AdbApp> useAppList(String deviceSerial) {
  useListenable(stows.showSystemApps);
  final unfilteredApps = use(_AppList(deviceSerial));

  final appFilter = useValueListenable(stows.appFilter);
  final filteredApps = useMemoized(() {
    if (appFilter.isEmpty) return unfilteredApps;
    return unfilteredApps
        .where((app) {
          return app.displayName.contains(appFilter) ||
              app.packageName.contains(appFilter);
        })
        .toList(growable: false);
  }, [unfilteredApps, appFilter]);
  return filteredApps;
}

class _AppList extends Hook<List<AdbApp>> {
  const _AppList(this.deviceSerial);

  final String deviceSerial;

  @override
  _AppListState createState() => _AppListState();
}

class _AppListState extends HookState<List<AdbApp>, _AppList> {
  /// The full list of apps obtained from the device.
  ///
  /// This may or may not yet include system apps.
  var _apps = <AdbApp>[];

  /// System apps take longer to load,
  /// so we only load them if [stows.showSystemApps] is true.
  var _hasLoadedSystemApps = false;

  @override
  void initHook() {
    _load(stows.showSystemApps.value);
  }

  Future<void> _load(bool showSystemApps) async {
    _hasLoadedSystemApps |= showSystemApps;
    // TODO(adil192): Check if this needs a mutex
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
