import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/workers.dart';
import 'package:yaru/yaru.dart';

class DeviceTile extends HookWidget {
  const DeviceTile(
    this.deviceSerial, {
    super.key,
    this.trailing,
    this.padding = const .all(8),
  });

  final String deviceSerial;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final deviceScanner = useListenable(workers.deviceScanner);
    final device = useMemoized(() {
      final devices = deviceScanner.value;
      return devices?.firstWhereOrNull((d) => d.serial == deviceSerial) ??
          AdbDevice(deviceSerial, '');
    }, [deviceScanner.value, deviceSerial]);

    return Padding(
      padding: padding,
      child: Hero(
        tag: device.serial,
        child: Material(
          type: .transparency,
          child: YaruTile(
            padding: .zero,
            title: Text(device.model ?? device.serial),
            subtitle: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                _Chip(
                  title: device.state,
                  yaruInfoType: device.isUsable ? null : YaruInfoType.warning,
                ),
                _Chip(title: device.serial),
                if (device.device != null) _Chip(title: device.device!),
                if (device.product != null) _Chip(title: device.product!),
                if (device.usb != null) _Chip(title: 'USB ${device.usb}'),
              ],
            ),
            leading: Icon(YaruIcons.smartphone),
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.title, this.yaruInfoType});

  final String title;
  final YaruInfoType? yaruInfoType;

  @override
  Widget build(BuildContext context) {
    return YaruInfoBadge(
      title: Text(title),
      yaruInfoType: yaruInfoType ?? YaruInfoType.information,
      color: yaruInfoType == null ? Colors.grey.shade700 : null,
    );
  }
}
