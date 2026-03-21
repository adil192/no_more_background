import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/is_this_a_test.dart';

final workers = Workers();

@visibleForTesting
final class Workers {
  ScanDevicesPoller get deviceScanner => _deviceScanner ??= ScanDevicesPoller();
  ScanDevicesPoller? _deviceScanner;

  void dispose() {
    deviceScanner.dispose();
  }

  /// Reset all workers to initial state.
  @visibleForTesting
  void reset() {
    _deviceScanner?.dispose();
    _deviceScanner = null;
  }

  /// Disable automatic polling for tests.
  /// The initial poll is still done.
  @visibleForTesting
  @pragma('vm:platform-const-if', !kDebugMode)
  static var debugDisablePolling = false;
}

abstract class _Poller<T> extends ValueNotifier<T?> {
  _Poller() : super(null) {
    if (Workers.debugDisablePolling) {
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
      await Future.delayed(interval);
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
  final interval = slowDownDeviceScanning
      ? const Duration(seconds: 4)
      : const Duration(seconds: 5);

  @override
  Future<Set<AdbDevice>> doPoll() async {
    if (Adb.impl == null) return const {};

    final previousDevices = value?.toList() ?? [];
    final List<AdbDevice> newDevices = await Future.wait([
      Adb.getDevices(),
      if (slowDownDeviceScanning) Future.delayed(const Duration(seconds: 1)),
    ]).then((results) => results.first);

    for (var i = 0; i < previousDevices.length; ++i) {
      final device = previousDevices[i];
      if (!newDevices.contains(device)) {
        previousDevices[i] = device.copyWith(state: 'disconnected');
      }
    }
    return {...newDevices, ...previousDevices};
  }

  /// Scanning devices is usually very quick, which makes the UI change
  /// abruptly. Setting a 1s minimum resolves this and doesn't noticibly
  /// slow down the user.
  @visibleForTesting
  static bool slowDownDeviceScanning = !isThisATest;
}
