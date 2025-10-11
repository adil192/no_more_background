import 'package:flutter/material.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:stow_codecs/stow_codecs.dart';
import 'package:stow_plain/stow_plain.dart';

final stows = Stows();

@visibleForTesting
class Stows {
  final selectedDevice = PlainStow(
    'selectedDevice',
    null,
    codec: const _AdbDeviceCodec(),
  );
}

class _AdbDeviceCodec extends AbstractCodec<AdbDevice, String> {
  const _AdbDeviceCodec();

  @override
  String encode(AdbDevice device) => device.id;

  @override
  AdbDevice decode(String id) => AdbDevice(id, 'unknown');
}
