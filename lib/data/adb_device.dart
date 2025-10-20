import 'package:flutter/material.dart';

@immutable
class AdbDevice {
  const AdbDevice(
    this.serial,
    this.state, {
    this.usb,
    this.product,
    this.model,
    this.device,
    this.transportId,
  });

  /// Parses the output from `adb devices -l`, e.g.
  /// 4C0210000000 device usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:5
  factory AdbDevice.fromAdbOutput(List<String> parts) {
    final serial = parts.removeAt(0);
    final state = parts.removeAt(0);

    String? usb, product, model, device, transportId;
    for (final tidbit in parts) {
      final [key, value] = tidbit.split(':');
      switch (key) {
        case 'usb':
          usb = value;
        case 'product':
          product = value;
        case 'model':
          model = value;
        case 'device':
          device = value;
        case 'transport_id':
          transportId = value;
      }
    }
    return AdbDevice(
      serial,
      state,
      usb: usb,
      product: product,
      model: model,
      device: device,
      transportId: transportId,
    );
  }

  final String serial;
  final String state;
  final String? usb, product, model, device, transportId;

  bool get isUsable {
    return switch (state) {
      'unauthorized' => false,
      '' => false,
      _ => true,
    };
  }

  @override
  String toString() {
    return 'AdbDevice($serial, $state, usb:$usb product:$product model:$model device:$device transportId:$transportId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AdbDevice &&
        other.serial == serial &&
        other.state == state &&
        other.usb == usb &&
        other.product == product &&
        other.model == model &&
        other.device == device &&
        other.transportId == transportId;
  }

  @override
  int get hashCode {
    return Object.hash(serial, state, usb, product, model, device, transportId);
  }
}
