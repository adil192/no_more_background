import 'package:flutter/material.dart';
import 'package:no_more_background/components/app_tile.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:yaru/yaru.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key, required this.device});

  final AdbDevice device;

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  late final permissionMap = AdbAppPermissions.of(widget.device);

  List<AdbApp>? _unfilteredApps;
  List<AdbApp> apps = const [];

  bool get showSystemApps => _showSystemApps;
  bool _showSystemApps = false;
  set showSystemApps(bool value) {
    _showSystemApps = value;
    _filterApps();
  }

  Future<void> _loadApps() async {
    _unfilteredApps = await Adb.getApps(widget.device);
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
    for (final app in apps)
      if (!permissionMap.containsKey(app)) _loadPermissionsForApp(app),
  ]);

  Future<void> _loadPermissionsForApp(AdbApp app) async {
    final canRunAnyInBackground = await Adb.getRunAnyInBackground(
      widget.device,
      app,
    );
    permissionMap[app] = AdbAppPermissions(
      runAnyInBackground: canRunAnyInBackground,
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
      appBar: AppBar(title: Text('Apps')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return AppTile(
                  key: ValueKey(app.packageName),
                  device: widget.device,
                  app: app,
                  permissions: permissionMap[app],
                );
              },
            ),
          ),
          Divider(),
          DeviceTile(device: widget.device),
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
