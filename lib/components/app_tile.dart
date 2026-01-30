import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/app_stores.dart';

import 'package:yaru/yaru.dart';

class AppTile extends StatefulWidget {
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
    final theme = Theme.of(context);
    return ColoredBox(
      color: widget.app.isSystemApp
          ? theme.colorScheme.warning.withValues(alpha: 0.05)
          : Colors.transparent,
      child: ColoredBox(
        color: widget.altBackground
            ? theme.colorScheme.tertiary.withValues(alpha: 0.02)
            : Colors.transparent,
        child: YaruTile(
          title: SelectableText(widget.app.bestAvailableName),
          subtitle: widget.app.displayName != null
              ? SelectableText(widget.app.packageName)
              : null,
          padding: const .symmetric(vertical: 8, horizontal: 16),
          leading: widget.app.icon != null
              ? Image(image: widget.app.icon!, width: 40, height: 40)
              : SizedBox(
                  width: 40,
                  height: 40,
                  child: Opacity(
                    opacity: 0.5,
                    child: Icon(Icons.android, size: 24),
                  ),
                ),
          trailing: Row(
            mainAxisSize: .min,
            spacing: 2,
            children: [
              if (widget.app.installer == 'com.android.vending')
                _ArchiveIconButton(app: widget.app),
              _AppStoreIconButton(app: widget.app, title: 'Info'),
              _LabelledSwitch(
                title: 'Run in bg',
                value: widget.permissions?.runAnyInBackground ?? false,
                onChanged: widget.permissions != null
                    ? _setRunAnyInBackground
                    : null,
              ),
              _LabelledSwitch(
                title: 'Bg data',
                value: !(widget.permissions?.restrictBackgroundData ?? false),
                onChanged: widget.permissions != null
                    // Note: This is inverted from restrictBackgroundData
                    ? _setUnrestrictBackgroundData
                    : null,
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
      title: app.isUninstalled ? 'Unarchive' : 'Archive',
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

    return _LabelledWidget(
      title: title,
      child: Padding(
        padding: const .symmetric(vertical: 2),
        child: IconButton(
          tooltip: 'Show on ${appStore.displayName}',
          icon: Image(image: appStore.icon, width: 24, height: 24),
          onPressed: () => appStore.showAppListing(app.packageName),
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
