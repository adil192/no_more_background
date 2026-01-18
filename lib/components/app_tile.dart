import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/icon_pack.dart';
import 'package:url_launcher/url_launcher.dart';
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

  void _showPlayStoreListing() {
    launchUrl(
      Uri.parse(
        'https://play.google.com/store/apps/details?id=${widget.app.packageName}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appIcon = IconPack.getIcon(widget.app.packageName);
    return ColoredBox(
      color: widget.app.isSystemApp
          ? theme.colorScheme.warning.withValues(alpha: 0.05)
          : Colors.transparent,
      child: ColoredBox(
        color: widget.altBackground
            ? theme.colorScheme.tertiary.withValues(alpha: 0.02)
            : Colors.transparent,
        child: YaruTile(
          title: SelectableText(widget.app.packageName),
          padding: const .symmetric(vertical: 8, horizontal: 16),
          leading: Image(
            image: appIcon ?? IconPack.defaultIcon,
            width: 40,
            height: appIcon != null ? 40 : 24,
            errorBuilder: (context, error, stackTrace) =>
                Icon(YaruIcons.application),
          ),
          trailing: Row(
            mainAxisSize: .min,
            spacing: 2,
            children: [
              _LabelledIconButton(
                icon: IconPack.getIcon('com.android.vending')!,
                title: 'Info',
                onPressed: _showPlayStoreListing,
              ),
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

class _LabelledIconButton extends StatelessWidget {
  const _LabelledIconButton({
    required this.icon,
    required this.title,
    this.onPressed,
  });

  final ImageProvider icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _LabelledWidget(
      title: title,
      child: Padding(
        padding: const .symmetric(vertical: 2),
        child: IconButton(
          icon: Image(image: icon, width: 24, height: 24),
          onPressed: onPressed,
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
