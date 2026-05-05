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
    this.extra,
  });

  factory AdbDevice.fromAdbOutput(String outputLine) {
    final parts = outputLine.split(RegExp(r'\s+'));
    final serial = parts.removeAt(0);
    final state = parts.removeAt(0);

    String? usb, product, model, device, transportId, extra;
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
        case 'extra':
          extra = value;
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
      extra: extra,
    );
  }

  final String serial;
  final String state;
  final String? usb, product, model, device, transportId;

  final String? extra;

  bool get isUsable {
    return switch (state) {
      'unauthorized' => false,
      'disconnected' => false,
      '' => false,
      _ => true,
    };
  }

  @override
  String toString() {
    return 'AdbDevice($serial, $state, usb:$usb product:$product model:$model device:$device transportId:$transportId extra:$extra)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AdbDevice && other.serial == serial;
  }

  @override
  int get hashCode => serial.hashCode;

  AdbDevice copyWith({
    String? serial,
    String? state,
    String? usb,
    String? product,
    String? model,
    String? device,
    String? transportId,
    String? extra,
  }) {
    return AdbDevice(
      serial ?? this.serial,
      state ?? this.state,
      usb: usb ?? this.usb,
      product: product ?? this.product,
      model: model ?? this.model,
      device: device ?? this.device,
      transportId: transportId ?? this.transportId,
      extra: extra ?? this.extra,
    );
  }
}
