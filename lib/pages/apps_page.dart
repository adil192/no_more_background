import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/components/app_tile.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/constants.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:yaru/yaru.dart';

class AppsPage extends StatefulHookWidget {
  const AppsPage({super.key, required this.deviceSerial});

  final String deviceSerial;

  @override
  State<AppsPage> createState() => AppsPageState();
}

@visibleForTesting
class AppsPageState extends State<AppsPage> {
  @visibleForTesting
  late final permissionMap = AdbAppPermissions.of(widget.deviceSerial);
  @visibleForTesting
  late final Future<List<String>> restrictedDataAppUids =
      Adb.getAppsWithRestrictedBackgroundData(widget.deviceSerial);

  List<AdbApp>? _unfilteredApps;
  List<AdbApp> apps = const [];

  Future<void> _loadApps() async {
    _unfilteredApps = await Adb.getApps(widget.deviceSerial);
    if (mounted) setState(() {});
  }

  void _filterApps() {
    apps =
        _unfilteredApps
            ?.where((app) => stows.showSystemApps.value || !app.isSystemApp)
            .toList() ??
        const [];
    _loadAbsentPermissions();
  }

  Future<void> _loadAbsentPermissions() async {
    var batchStart = 0;
    while (batchStart < apps.length) {
      final batchEnd = batchStart + 10;
      await Future.wait([
        for (var i = batchStart; i < batchEnd && i < apps.length; ++i)
          _loadAbsentPermissionsForApp(apps[i]),
      ]);
      batchStart = batchEnd;
      if (!mounted) return;
      setState(() {});

      await null;
      if (!mounted) return;
    }
  }

  Future<void> _loadAbsentPermissionsForApp(AdbApp app) async {
    if (permissionMap.containsKey(app)) return;

    final runAnyInBackground = await Adb.getRunAnyInBackground(
      widget.deviceSerial,
      app,
    );
    final restrictBackgroundData = (await restrictedDataAppUids).contains(
      app.uid,
    );

    permissionMap[app] = AdbAppPermissions(
      runAnyInBackground: runAnyInBackground,
      restrictBackgroundData: restrictBackgroundData,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  @override
  Widget build(BuildContext context) {
    final showSystemApps = useValueListenable(stows.showSystemApps);
    useMemoized(_filterApps, [showSystemApps, _unfilteredApps]);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        leading: const BackButton(),
        title: DeviceTile(widget.deviceSerial, imageSize: 48, padding: .zero),
      ),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const .all(kYaruPagePadding),
                child: YaruSection(
                  width: kMaxContentWidth,
                  padding: .zero,
                  headlinePadding: .zero,
                  headline: Column(
                    crossAxisAlignment: .stretch,
                    children: [_HeadlineRow(), const Divider()],
                  ),
                  child: ListView.separated(
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      final app = apps[index];
                      return AppTile(
                        key: ValueKey(app.packageName),
                        deviceSerial: widget.deviceSerial,
                        app: app,
                        permissions: permissionMap[app],
                        altBackground: index.isEven,
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadlineRow extends HookWidget {
  const _HeadlineRow();

  @override
  Widget build(BuildContext context) {
    useListenable(stows.showSystemApps);
    return Row(
      children: [
        Padding(
          padding: const .all(16),
          child: stows.showSystemApps.value
              ? Text('All apps')
              : Text('User apps'),
        ),
        YaruCheckbox(
          value: stows.showSystemApps.value,
          onChanged: (value) => stows.showSystemApps.value = value!,
        ),
      ],
    );
  }
}
