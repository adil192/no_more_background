import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/components/archive_color_filter.dart';

import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/app_stores.dart';
import 'package:no_more_background/data/reviewed_app.dart';
import 'package:no_more_background/data/stows.dart';

import 'package:yaru/yaru.dart';

class AppTile extends StatefulHookWidget {
  const AppTile({
    super.key,
    required this.app,
    required this.deviceSerial,
    required this.permissions,
    this.altBackground = false,
  });

  final AdbApp app;
  final String deviceSerial;
  final AdbAppPermissions? permissions;
  final bool altBackground;

  @override
  State<AppTile> createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> {
  late var reviewedApp = stows.reviewedAppsBySerial.value[widget.deviceSerial]
      ?.firstWhereOrNull(
        (reviewedApp) => reviewedApp.packageName == widget.app.packageName,
      );
  bool get isReviewed => reviewedApp?.permissions == widget.permissions;
  set isReviewed(bool isReviewed) {
    if (!isReviewed) {
      reviewedApp = null;
      stows.reviewedAppsBySerial.value[widget.deviceSerial]?.removeWhere(
        (reviewedApp) => reviewedApp.packageName == widget.app.packageName,
      );
    } else if (widget.permissions != null) {
      (stows.reviewedAppsBySerial.value[widget.deviceSerial] ??= [])
        ..removeWhere(
          (reviewedApp) => reviewedApp.packageName == widget.app.packageName,
        )
        ..add(
          reviewedApp = ReviewedApp(
            packageName: widget.app.packageName,
            permissions: widget.permissions!,
          ),
        );
    }
    stows.reviewedAppsBySerial.notifyListeners();
  }

  Future<void> _setRunAnyInBackground(bool value) async {
    final permissions = widget.permissions;
    if (permissions == null) return;

    // Optimistically update UI
    permissions.runAnyInBackground = value;
    if (mounted) setState(() {});

    await Adb.setRunAnyInBackground(widget.deviceSerial, widget.app, value);

    permissions.runAnyInBackground = await Adb.getRunAnyInBackground(
      widget.deviceSerial,
      widget.app,
    );
    if (mounted) setState(() {});
  }

  Future<void> _setUnrestrictBackgroundData(bool unrestricted) async {
    final permissions = widget.permissions;
    if (permissions == null) return;

    // Optimistically update UI
    permissions.restrictBackgroundData = !unrestricted;
    if (mounted) setState(() {});

    await Adb.setRestrictBackgroundData(
      widget.deviceSerial,
      widget.app,
      !unrestricted,
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final showReviewedApps = useValueListenable(stows.showReviewedApps);
    if (isReviewed && !showReviewedApps) return SizedBox.shrink();

    final theme = Theme.of(context);
    return ColoredBox(
      color: widget.app.isSystemApp
          ? theme.colorScheme.warning.withValues(alpha: 0.05)
          : Colors.transparent,
      child: ColoredBox(
        color: widget.altBackground
            ? theme.colorScheme.tertiary.withValues(alpha: 0.02)
            : Colors.transparent,
        child: Column(
          children: [
            YaruTile(
              title: SelectableText(widget.app.bestAvailableName),
              subtitle: widget.app.displayName != null
                  ? SelectableText(widget.app.packageName)
                  : null,
              padding: const .symmetric(vertical: 8, horizontal: 16),
              leading: Row(
                mainAxisSize: .min,
                spacing: 2,
                children: [
                  _LabelledWidget(
                    title: 'Reviewed',
                    child: Padding(
                      padding: const .symmetric(vertical: 2),
                      child: YaruCheckbox(
                        value: isReviewed,
                        onChanged: widget.permissions == null
                            ? null
                            : (value) => setState(() => isReviewed = value!),
                      ),
                    ),
                  ),
                  widget.app.icon != null
                      ? ArchiveColorFilter(
                          archived: widget.app.isUninstalled,
                          child: Image(
                            image: widget.app.icon!,
                            width: 40,
                            height: 40,
                          ),
                        )
                      : SizedBox(
                          width: 40,
                          height: 40,
                          child: Opacity(
                            opacity: 0.5,
                            child: Icon(Icons.android, size: 24),
                          ),
                        ),
                ],
              ),
              trailing: Row(
                mainAxisSize: .min,
                spacing: 2,
                children: [
                  if (widget.app.installer == 'com.android.vending')
                    _ArchiveIconButton(app: widget.app),
                  _AppStoreIconButton(app: widget.app, title: ''),
                  _LabelledSwitch(
                    title: 'Run in bg',
                    value: widget.permissions?.runAnyInBackground ?? false,
                    onChanged:
                        widget.permissions != null && !widget.app.isUninstalled
                        ? _setRunAnyInBackground
                        : null,
                  ),
                  _LabelledSwitch(
                    title: 'Bg data',
                    value:
                        !(widget.permissions?.restrictBackgroundData ?? false),
                    onChanged:
                        widget.permissions != null && !widget.app.isUninstalled
                        // Note: This is inverted from restrictBackgroundData
                        ? _setUnrestrictBackgroundData
                        : null,
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class _ArchiveIconButton extends StatelessWidget {
  const _ArchiveIconButton({required this.app});

  final AdbApp app;

  @override
  Widget build(BuildContext context) {
    // Needs a better UI, for now just hide button for non-archived apps
    if (!app.isUninstalled) return const SizedBox.shrink();

    return _LabelledWidget(
      title: app.isUninstalled ? 'Archived' : 'Archive',
      child: Padding(
        padding: const .symmetric(vertical: 2),
        child: IconButton(
          onPressed: null,
          icon: Icon(
            app.isUninstalled ? Icons.cloud_download : Icons.cloud_upload,
          ),
        ),
      ),
    );
  }
}

class _AppStoreIconButton extends StatelessWidget {
  const _AppStoreIconButton({required this.app, required this.title});

  final AdbApp app;
  final String title;

  @override
  Widget build(BuildContext context) {
    final appStore = AppStore.stores[app.installer];
    if (appStore == null) return const SizedBox.shrink();

    final action = appStore.showAppListing != null
        ? () => appStore.showAppListing!(app.packageName)
        : null;

    return _LabelledWidget(
      title: title,
      child: Padding(
        padding: const .symmetric(vertical: 2),
        child: IconButton(
          tooltip: action != null
              ? 'Show on ${appStore.displayName}'
              : appStore.displayName,
          icon: switch (appStore) {
            AppStore(:AssetImage iconImage) => Image(
              image: iconImage,
              width: 24,
              height: 24,
            ),
            _ => Icon(appStore.iconData, size: 24),
          },
          onPressed: action,
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
    final theme = Theme.of(context);
    return _LabelledWidget(
      title: title,
      child: (theme.platform == .iOS || theme.platform == .macOS)
          ? CupertinoSwitch(value: value, onChanged: onChanged)
          : YaruSwitch(value: value, onChanged: onChanged),
    );
  }
}

class _LabelledWidget extends StatelessWidget {
  const _LabelledWidget({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(title, style: theme.textTheme.labelMedium!.copyWith(height: 0.5)),
        child,
      ],
    );
  }
}
