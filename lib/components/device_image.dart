import 'package:flutter/widgets.dart';
import 'package:app_manager/data/adb_device.dart';
import 'package:yaru/icons.dart';

class DeviceImage extends StatelessWidget {
  const DeviceImage(this.device, {super.key, this.size = 72});

  final AdbDevice device;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: _getDeviceImage(device),
      errorBuilder: (context, error, stackTrace) {
        return SizedBox.square(
          dimension: size,
          child: Center(child: const Icon(YaruIcons.smartphone)),
        );
      },
      width: size,
      height: size,
    );
  }

  static AssetImage _getDeviceImage(AdbDevice device) {
    final id = device.device ?? device.product ?? device.model;
    return AssetImage('submodules/lineage_wiki/images/devices/small/$id.png');
  }
}
