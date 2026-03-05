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
            // showReviewedApps is handled inside [AppTile]
            .where((app) => stows.showArchivedApps.value || !app.isUninstalled)
            .toList() ??
        const [];
    _loadAbsentPermissions();
  }

  Future<void> _loadAbsentPermissions() async {
    var batchStart = 0;
    const batchSize = 10;
    while (batchStart < apps.length) {
      final batchEnd = batchStart + batchSize;
      print(
        'Loading permissions for apps $batchStart-$batchEnd out of ${apps.length}',
      );
      await Future.wait([
        for (var i = batchStart; i < batchEnd && i < apps.length; ++i)
          _loadAbsentPermissionsForApp(apps[i]),
      ]);
      if (!mounted) return;

      if (batchStart == 0) setState(() {});
      batchStart = batchEnd;

      await null;
      if (!mounted) return;
    }
    if (batchStart > batchSize) setState(() {});
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
    final showArchivedApps = useValueListenable(stows.showArchivedApps);
    useMemoized(_filterApps, [
      showSystemApps,
      showArchivedApps,
      _unfilteredApps,
    ]);

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
                  headline: _Headline(),
                  child: ListView.builder(
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      final app = apps[index];
                      return Column(
                        children: [
                          AppTile(
                            key: ValueKey(app.packageName),
                            deviceSerial: widget.deviceSerial,
                            app: app,
                            permissions: permissionMap[app],
                            altBackground: index.isEven,
                          ),
                          const Divider(),
                        ],
                      );
                    },
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

class _Headline extends HookWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    useListenable(stows.showSystemApps);
    useListenable(stows.showReviewedApps);
    useListenable(stows.showArchivedApps);

    return Padding(
      padding: const .only(top: 16, left: 16, right: 16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: .stretch,
        children: [
          stows.showSystemApps.value ? Text('All apps') : Text('User apps'),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: _CheckButton(
                  value: stows.showSystemApps.value,
                  onChanged: (value) => stows.showSystemApps.value = value!,
                  label: Text('Show system apps'),
                ),
              ),
              Expanded(
                child: _CheckButton(
                  value: stows.showReviewedApps.value,
                  onChanged: (value) => stows.showReviewedApps.value = value!,
                  label: Text('Show reviewed apps'),
                ),
              ),
              Expanded(
                child: _CheckButton(
                  value: stows.showArchivedApps.value,
                  onChanged: (value) => stows.showArchivedApps.value = value!,
                  label: Text('Show archived apps'),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return MergeSemantics(
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.tertiary.withValues(
            alpha: value ? 0.3 : 0.01,
          ),
          foregroundColor: colorScheme.onSurface,
          overlayColor: colorScheme.tertiary,
          side: BorderSide(
            color: value ? Colors.transparent : colorScheme.outline,
          ),
          padding: .all(2),
          tapTargetSize: .shrinkWrap,
        ),

        onPressed: onChanged == null ? null : () => onChanged!(!value),
        icon: YaruCheckbox(value: value, onChanged: onChanged),
        label: label,
      ),
    );
  }
}
