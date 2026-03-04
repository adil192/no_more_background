import 'package:collection/collection.dart';
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

    final showAppListing =
        AppStore.stores[widget.app.installer]?.showAppListing;

    final theme = Theme.of(context);
    return ColoredBox(
      color: widget.app.isSystemApp
          ? theme.colorScheme.warning.withValues(alpha: 0.05)
          : Colors.transparent,
      child: ColoredBox(
        color: widget.altBackground
            ? theme.colorScheme.tertiary.withValues(alpha: 0.02)
            : Colors.transparent,
        child: _HoverHighlight(
          child: _AppTileScaffold(
            title: widget.app.displayName ?? '',
            subtitle: widget.app.packageName,
            icon: widget.app.icon != null
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
            reviewedCheckbox: YaruCheckbox(
              value: isReviewed,
              onChanged: widget.permissions == null
                  ? null
                  : (value) => setState(() => isReviewed = value!),
            ),
            archiveIconButton: widget.app.installer == 'com.android.vending'
                ? _ArchiveIconButton(app: widget.app)
                : null,
            showAppListing: showAppListing != null
                ? () => showAppListing(widget.app.packageName)
                : null,
            controls: [
              _LabelledSwitch(
                title: 'Run in bg',
                value: widget.permissions?.runAnyInBackground ?? false,
                onChanged:
                    widget.permissions != null && !widget.app.isUninstalled
                    ? _setRunAnyInBackground
                    : null,
                thumbIcon: Icons.update,
              ),
              _LabelledSwitch(
                title: 'Bg data',
                value: !(widget.permissions?.restrictBackgroundData ?? false),
                onChanged:
                    widget.permissions != null && !widget.app.isUninstalled
                    // Note: This is inverted from restrictBackgroundData
                    ? _setUnrestrictBackgroundData
                    : null,
                thumbIcon: Icons.cell_tower,
              ),
            ],
          ),
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
      child: IconButton(
        onPressed: null,
        icon: Icon(
          app.isUninstalled ? Icons.cloud_download : Icons.cloud_upload,
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
    required this.thumbIcon,
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final IconData thumbIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _LabelledWidget(
      title: title,
      child: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        thumbIcon: .all(
          Icon(thumbIcon, color: theme.colorScheme.surfaceContainerHighest),
        ),
      ),
    );
  }
}

class _LabelledWidget extends StatelessWidget {
  const _LabelledWidget({required this.title, required this.child});

  final String title;
  final Widget child;

  static TextStyle textStyleOf(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.copyWith(height: 0.5);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: textStyleOf(context)),
        SizedBox(height: 40, child: Center(child: child)),
      ],
    );
  }
}

class _HoverHighlight extends HookWidget {
  const _HoverHighlight({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: ColoredBox(
        color: hovered.value
            ? theme.colorScheme.onSurface.withValues(alpha: 0.1)
            : Colors.transparent,
        child: child,
      ),
    );
  }
}

class _AppTileScaffold extends StatelessWidget {
  const _AppTileScaffold({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.reviewedCheckbox,
    this.archiveIconButton,
    this.showAppListing,
    required this.controls,
  });

  final String title;
  final String subtitle;
  final Widget icon;
  final Widget reviewedCheckbox;
  final Widget? archiveIconButton;
  final VoidCallback? showAppListing;
  final List<Widget> controls;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 8),
      child: Row(
        spacing: 4,
        children: [
          _LabelledWidget(title: 'Reviewed', child: reviewedCheckbox),
          icon,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                TextButton(
                  onPressed: showAppListing,
                  style: TextButton.styleFrom(
                    padding: .zero,
                    tapTargetSize: .shrinkWrap,
                    enabledMouseCursor: SystemMouseCursors.click,
                  ),
                  child: Text(title, style: theme.textTheme.bodyLarge),
                ),
                SelectableText(subtitle, style: theme.textTheme.labelMedium),
              ],
            ),
          ),
          ?archiveIconButton,
          ...controls,
        ],
      ),
    );
  }
}
