import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:app_manager/compute/adb.dart';
import 'package:app_manager/data/adb_device.dart';
import 'package:app_manager/data/is_this_a_test.dart';

final workers = Workers();

@visibleForTesting
final class Workers {
  ScanDevicesPoller get deviceScanner => _deviceScanner ??= ScanDevicesPoller();
  ScanDevicesPoller? _deviceScanner;

  void dispose() {
    deviceScanner.dispose();
  }

  @visibleForTesting
  void reset() {
    _deviceScanner?.dispose();
    _deviceScanner = null;
  }
}

abstract class _Poller<T> extends ValueNotifier<T?> {
  _Poller() : super(null) {
    if (isThisATest) {
      requestPoll();
    } else {
      _startPolling();
    }
  }
  Duration get interval;
  @visibleForOverriding
  Future<T> doPoll();

  bool _disposed = false;

  final isPolling = ValueNotifier(false);

  void _startPolling() {
    Future.doWhile(() async {
      await requestPoll();
      if (!isThisATest) await Future.delayed(interval);
      return !_disposed;
    });
  }

  Future<void> requestPoll() async {
    if (isPolling.value) return;
    try {
      isPolling.value = true;
      value = await doPoll();
    } finally {
      isPolling.value = false;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    isPolling.dispose();
    super.dispose();
  }
}

class ScanDevicesPoller extends _Poller<Set<AdbDevice>> {
  @override
  final interval = const Duration(seconds: 1);

  @override
  Future<Set<AdbDevice>> doPoll() async {
    if (Adb.impl == null) return const {};

    final previousDevices = value?.toList() ?? [];
    final newDevices = await Adb.getDevices();

    for (var i = 0; i < previousDevices.length; ++i) {
      final device = previousDevices[i];
      if (!newDevices.contains(device)) {
        previousDevices[i] = device.copyWith(state: 'disconnected');
      }
    }
    return {...newDevices, ...previousDevices};
  }
}
