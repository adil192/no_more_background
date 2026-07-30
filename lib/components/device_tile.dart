import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/components/device_image.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/fonts.dart';
import 'package:no_more_background/data/workers.dart';
import 'package:yaru/yaru.dart';

class DeviceTile extends HookWidget {
  const DeviceTile(
    this.deviceSerial, {
    super.key,
    this.trailing,
    this.padding = const .all(8),
    this.imageSize = 72,
  });

  final String deviceSerial;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final double imageSize;

  /// Maps [deviceSerial] to a user-friendly device name.
  static final deviceNames = <String, String?>{};

  @override
  Widget build(BuildContext context) {
    final deviceScanner = useListenable(workers.deviceScanner);
    final device = useMemoized(() {
      final devices = deviceScanner.value;
      return devices?.firstWhereOrNull((d) => d.serial == deviceSerial) ??
          AdbDevice(deviceSerial, '');
    }, [deviceScanner.value, deviceSerial]);

    final deviceNameFuture = useMemoized(() {
      return device.isUsable
          ? Adb.getDeviceName(deviceSerial).then((name) {
              deviceNames[deviceSerial] = name ?? deviceNames[deviceSerial];
            })
          : Future.value();
    }, [deviceSerial, device.state]);
    useFuture(deviceNameFuture);

    final theme = Theme.of(context);
    return Padding(
      padding: padding,
      child: Material(
        type: .transparency,
        child: YaruListTile(
          horizontalGap: 0,
          verticalGap: 0,
          title: Padding(
            padding: const .only(bottom: 4),
            child: Text(
              deviceNames[deviceSerial] ?? device.model ?? device.serial,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          subtitle: Wrap(
            spacing: 16,
            runSpacing: 4,
            children: [
              _Chip(device.state, warning: !device.isUsable),
              _Chip(device.serial),
              if (device.device != null) _Chip(device.device!),
              if (device.product != null) _Chip(device.product!),
              if (device.usb != null) _Chip('USB ${device.usb}'),
              if (device.extra != null) _Chip(device.extra!),
            ],
          ),
          leading: DeviceImage(device, size: imageSize),
          trailing: trailing,
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.title, {this.warning = false});

  final String title;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      softWrap: false,
      style: theme.textTheme.bodySmall!.copyWith(
        fontSize: 13,
        fontWeight: warning ? .w400 : .w300,
        fontStyle: .italic,
        fontFamily: kMonoFont.primary,
        fontFamilyFallback: kMonoFont.fallbacks,
        color: warning
            ? Color.lerp(
                theme.colorScheme.onSurface,
                theme.colorScheme.warning,
                0.5,
              )
            : null,
      ),
    );
  }
}
