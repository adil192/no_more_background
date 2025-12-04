import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:yaru/yaru.dart';

class AppTile extends StatefulWidget {
  const AppTile({
    super.key,
    required this.device,
    required this.app,
    required this.permissions,
  });

  final AdbDevice device;
  final AdbApp app;
  final AdbAppPermissions? permissions;

  @override
  State<AppTile> createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> {
  /// Prevents concurrent adb commands for this app
  final _mutex = ReadWriteMutex();

  Future<void> _setRunAnyInBackground(bool value) async {
    final permissions = widget.permissions;
    if (permissions == null) return;

    // Optimistically update UI
    permissions.runAnyInBackground = value;
    if (mounted) setState(() {});
    await _mutex.protectWrite(() async {
      if (mounted) setState(() {});
      // TODO: set
      permissions.runAnyInBackground = await Adb.getRunAnyInBackground(
        widget.device,
        widget.app,
      );
    });
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: YaruTile(
        title: SelectableText(widget.app.packageName),
        leading: Icon(YaruIcons.application),
        trailing: Row(
          mainAxisSize: .min,
          children: [
            // TODO: Add functionality
            _LabelledSwitch(
              title: 'Run in bg',
              value: widget.permissions?.runAnyInBackground ?? false,
              onChanged: widget.permissions != null && !_mutex.isLocked
                  ? _setRunAnyInBackground
                  : null,
            ),
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
