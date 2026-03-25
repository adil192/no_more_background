import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/components/app_tile.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/constants.dart';
import 'package:no_more_background/data/is_this_a_test.dart';
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

  /// System apps take longer to load,
  /// so we only load them if [stows.showSystemApps] is true.
  var _hasLoadedSystemApps = false;

  var apps = <AdbApp>[];
  Future<void> _loadApps() async {
    _hasLoadedSystemApps |= stows.showSystemApps.value;
    apps = await Adb.getApps(
      widget.deviceSerial,
      includeSystemApps: stows.showSystemApps.value,
    );
    if (mounted) setState(() {});
  }

  @visibleForTesting
  bool loadAbsentPermissionsLock = false;
  Future<void> _loadAbsentPermissions() async {
    if (loadAbsentPermissionsLock) return;
    loadAbsentPermissionsLock = true;
    final apps = this.apps
        // filter out apps that won't be shown
        .where((app) => stows.showSystemApps.value || !app.isSystemApp)
        .toList(growable: false);
    try {
      var batchStart = 0;
      const batchSize = 10;
      while (batchStart < apps.length) {
        final batchEnd = batchStart + batchSize;
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
    } finally {
      loadAbsentPermissionsLock = false;
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
    useMemoized(_loadAbsentPermissions, [showSystemApps, apps]);
    if (showSystemApps && !_hasLoadedSystemApps) _loadApps();

    final isAndroid = Theme.of(context).platform == .android;
    final isScreenSmall = MediaQuery.sizeOf(context).width < kMaxContentWidth;

    return Scaffold(
      appBar: isAndroid
          ? AppBar(toolbarHeight: 0)
          : AppBar(
              toolbarHeight: 64,
              leading: isThisATest ? const BackButton() : null,
              title: DeviceTile(
                widget.deviceSerial,
                imageSize: 48,
                padding: .zero,
              ),
            ),
      body: isScreenSmall
          ? Column(
              children: [
                _Headline(),
                Expanded(
                  child: _AppsList(
                    apps: apps,
                    deviceSerial: widget.deviceSerial,
                    permissionMap: permissionMap,
                  ),
                ),
              ],
            )
          : Center(
              child: YaruSection(
                width: kMaxContentWidth,
                margin: const .all(kYaruPagePadding),
                padding: .zero,
                headlinePadding: .zero,
                headline: _Headline(),
                child: _AppsList(
                  apps: apps,
                  deviceSerial: widget.deviceSerial,
                  permissionMap: permissionMap,
                ),
              ),
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
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 16);

    return Column(
      spacing: 16,
      crossAxisAlignment: .stretch,
      children: [
        const SizedBox.shrink(), // to add padding
        Padding(
          padding: horizontalPadding,
          child: Text(
            stows.showSystemApps.value ? 'All apps' : 'User apps',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: horizontalPadding,
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: _CheckButton(
                  value: stows.showSystemApps.value,
                  onChanged: (value) => stows.showSystemApps.value = value!,
                  label: 'Show system apps',
                ),
              ),
              Expanded(
                child: _CheckButton(
                  value: stows.showReviewedApps.value,
                  onChanged: (value) => stows.showReviewedApps.value = value!,
                  label: 'Show reviewed apps',
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
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
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final softWrap = MediaQuery.sizeOf(context).width < 360;
    return MergeSemantics(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.tertiary.withValues(
            alpha: value ? 0.3 : 0.01,
          ),
          foregroundColor: colorScheme.onSurface,
          overlayColor: colorScheme.tertiary,
          side: BorderSide(
            color: value ? Colors.transparent : colorScheme.outline,
          ),
          padding: const .all(2),
          tapTargetSize: theme.platform == .android ? null : .shrinkWrap,
        ),

        onPressed: onChanged == null ? null : () => onChanged!(!value),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            YaruCheckbox(value: value, onChanged: onChanged),
            Flexible(
              child: Padding(
                padding: .all(4),
                child: FittedBox(
                  fit: softWrap ? .none : .scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(height: 1.2),
                    softWrap: softWrap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppsList extends StatelessWidget {
  const _AppsList({
    required this.apps,
    required this.deviceSerial,
    required this.permissionMap,
  });

  final List<AdbApp> apps;
  final String deviceSerial;
  final PermissionMap permissionMap;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    return ListView.builder(
      padding: viewPadding.copyWith(top: 0),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return Stack(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuad,
              child: AppTile(
                key: ValueKey(app.packageName),
                deviceSerial: deviceSerial,
                app: app,
                permissions: permissionMap[app],
              ),
            ),
            const Positioned(bottom: 0, left: 0, right: 0, child: Divider()),
          ],
        );
      },
    );
  }
}
