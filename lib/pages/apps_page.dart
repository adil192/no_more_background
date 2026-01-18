import 'package:flutter/material.dart';
import 'package:no_more_background/components/app_tile.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/constants.dart';
import 'package:yaru/yaru.dart';

class AppsPage extends StatefulWidget {
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

  bool get showSystemApps => _showSystemApps;
  bool _showSystemApps = false;
  set showSystemApps(bool value) {
    _showSystemApps = value;
    _filterApps();
  }

  Future<void> _loadApps() async {
    _unfilteredApps = await Adb.getApps(widget.deviceSerial);
    _filterApps();
    if (mounted) setState(() {});
  }

  void _filterApps() {
    apps =
        _unfilteredApps
            ?.where((app) => showSystemApps ? true : !app.isSystemApp)
            .toList() ??
        const [];
    _loadAbsentPermissions();
  }

  Future<void> _loadAbsentPermissions() => Future.wait([
    for (final app in apps) _loadAbstractPermissionsForApp(app),
  ]);
  Future<void> _loadAbstractPermissionsForApp(AdbApp app) async {
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
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  @override
  Widget build(BuildContext context) {
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
                  headline: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      Padding(
                        padding: const .all(16),
                        child: showSystemApps
                            ? Text('All apps')
                            : Text('User apps'),
                      ),
                      const Divider(),
                    ],
                  ),
                  padding: .zero,
                  headlinePadding: .zero,
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
          if (showSystemApps)
            Padding(
              padding: const .symmetric(horizontal: kYaruPagePadding),
              child: Text(
                'Changing system app permissions could break or destabilize your device!\n'
                'Only change them if you know what you are doing.',
                style: TextStyle(color: ColorScheme.of(context).warning),
              ),
            ),
          YaruCheckboxListTile(
            value: showSystemApps,
            onChanged: (value) {
              showSystemApps = value!;
              if (mounted) setState(() {});
            },
            title: const Text('Show system apps'),
            controlAffinity: .leading,
          ),
        ],
      ),
    );
  }
}
