import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/icon_pack.dart';
import 'package:yaru/yaru.dart';

class AppTile extends StatefulWidget {
  const AppTile({
    super.key,
    required this.device,
    required this.app,
    required this.permissions,
    this.altBackground = false,
  });

  final AdbDevice device;
  final AdbApp app;
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

    await Adb.setRunAnyInBackground(widget.device, widget.app, value);

    permissions.runAnyInBackground = await Adb.getRunAnyInBackground(
      widget.device,
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
      widget.device,
      widget.app,
      !unrestricted,
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appIcon = IconPack.getIcon(widget.app.packageName);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.altBackground
            ? theme.colorScheme.tertiary.withValues(alpha: 0.02)
            : Colors.transparent,
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: YaruTile(
        title: SelectableText(widget.app.packageName),
        leading: Image(
          image: appIcon ?? IconPack.defaultIcon,
          width: 40,
          height: appIcon != null ? 40 : 24,
          errorBuilder: (context, error, stackTrace) =>
              Icon(YaruIcons.application),
        ),
        trailing: Row(
          mainAxisSize: .min,
          children: [
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
    return Column(
      children: [
        Text(title, style: theme.textTheme.labelMedium!.copyWith(height: 0.5)),

        if (theme.platform == .iOS || theme.platform == .macOS)
          CupertinoSwitch(value: value, onChanged: onChanged)
        else
          YaruSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}
