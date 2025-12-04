import 'package:flutter/material.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:yaru/yaru.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key, required this.device});

  final AdbDevice device;

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
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
    print('Filtered apps: $apps');
  }

  @override
  void initState() {
    super.initState();
    _loadApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return _AppTile(app: app);
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

class _AppTile extends StatelessWidget {
  const _AppTile({required this.app});

  final AdbApp app;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: YaruTile(
        title: Text(app.packageName),
        leading: Icon(YaruIcons.application),
        trailing: Row(
          mainAxisSize: .min,
          children: [
            // TODO: Add functionality
            _LabelledSwitch(title: 'Bg', value: true, onChanged: null),
            _LabelledSwitch(title: 'Data', value: true, onChanged: null),
          ],
        ),
      ),
    );
  }
}

class _LabelledSwitch extends StatelessWidget {
  const _LabelledSwitch({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextTheme.of(context).labelMedium!.copyWith(height: 0.5),
        ),
        YaruSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}
