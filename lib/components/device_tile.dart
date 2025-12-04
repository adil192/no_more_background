import 'package:flutter/material.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:yaru/yaru.dart';

class DeviceTile extends StatelessWidget {
  const DeviceTile({super.key, required this.device, this.trailing});

  final AdbDevice device;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return YaruTile(
      title: Text(device.model ?? device.serial),
      subtitle: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          _Chip(
            title: device.state,
            yaruInfoType: device.isUsable ? null : YaruInfoType.warning,
          ),
          _Chip(title: device.state),
          _Chip(title: device.serial),
          if (device.device != null) _Chip(title: device.device!),
          if (device.product != null) _Chip(title: device.product!),
          if (device.usb != null) _Chip(title: 'USB ${device.usb}'),
        ],
      ),
      leading: Icon(YaruIcons.smartphone),
      trailing: trailing,
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
