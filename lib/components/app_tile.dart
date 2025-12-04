import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:yaru/yaru.dart';

class AppTile extends StatefulWidget {
  const AppTile({super.key, required this.device, required this.app});

  final AdbDevice device;
  final AdbApp app;

  @override
  State<AppTile> createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> with AutomaticKeepAliveClientMixin {
  /// Prevents concurrent adb commands for this app
  final _mutex = ReadWriteMutex();

  bool? _canRunInBackground;

  // TODO: Preload this somehow
  Future<void> _loadAppPermissions() async {
    await _mutex.protectRead(() async {
      _canRunInBackground = await Adb.canAppRunInBackground(
        widget.device,
        widget.app,
      );
    });
    if (mounted) setState(() {});
  }

  Future<void> _setCanRunInBackground(bool value) async {
    // Optimistically update UI
    _canRunInBackground = value;
    if (mounted) setState(() {});
    await _mutex.protectWrite(() async {
      if (mounted) setState(() {});
      // TODO: set
      _canRunInBackground = await Adb.canAppRunInBackground(
        widget.device,
        widget.app,
      );
    });
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadAppPermissions();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              title: 'Bg',
              value: _canRunInBackground ?? false,
              onChanged: _canRunInBackground != null && !_mutex.isLocked
                  ? _setCanRunInBackground
                  : null,
            ),
            _LabelledSwitch(title: 'Data', value: true, onChanged: null),
          ],
        ),
      ),
    );
  }

  @override
  final wantKeepAlive = true;
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
