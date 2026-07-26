import 'dart:async';

import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/compute/fake_adb_impl.dart';
import 'package:no_more_background/data/adb_app.dart';

/// An `adb` implementation that records all `adb` commands that would be run.
///
/// After recording each command, a response from [fakeAdb] is used for the
/// return value.
class RecordingAdbImpl implements AdbImpl {
  RecordingAdbImpl();

  final List<String> records = [];
  late final AdbImpl realAdb = _RealAdbImpl(records);
  final FakeAdbImpl fakeAdb = FakeAdbImpl();

  @override
  String get exe => 'adb';

  @override
  Future<void> archiveApp(String deviceSerial, AdbApp app) async {
    await realAdb.archiveApp(deviceSerial, app);
    return fakeAdb.archiveApp(deviceSerial, app);
  }

  @override
  Future<AppLists> getApps(
    String deviceSerial, {
    required bool includeSystemApps,
  }) async {
    await realAdb.getApps(deviceSerial, includeSystemApps: includeSystemApps);
    return fakeAdb.getApps(deviceSerial, includeSystemApps: includeSystemApps);
  }

  @override
  Future<String> getAppsWithRestrictedBackground(String deviceSerial) async {
    await realAdb.getAppsWithRestrictedBackground(deviceSerial);
    return fakeAdb.getAppsWithRestrictedBackground(deviceSerial);
  }

  @override
  Future<String> getAppsWithRestrictedBackgroundData(
    String deviceSerial,
  ) async {
    await realAdb.getAppsWithRestrictedBackgroundData(deviceSerial);
    return fakeAdb.getAppsWithRestrictedBackgroundData(deviceSerial);
  }

  @override
  Future<String> getAppsWithWhitelistedBackground(String deviceSerial) async {
    await realAdb.getAppsWithWhitelistedBackground(deviceSerial);
    return fakeAdb.getAppsWithWhitelistedBackground(deviceSerial);
  }

  @override
  Future<String> getCurrentUser(String deviceSerial) async {
    await realAdb.getCurrentUser(deviceSerial);
    return fakeAdb.getCurrentUser(deviceSerial);
  }

  @override
  FutureOr<String> getDevices() async {
    await realAdb.getDevices();
    return fakeAdb.getDevices();
  }

  @override
  Future<String> getProp(String deviceSerial, String key) async {
    await realAdb.getProp(deviceSerial, key);
    return fakeAdb.getProp(deviceSerial, key);
  }

  @override
  Future<void> openAppInfo(String deviceSerial, AdbApp app) async {
    await realAdb.openAppInfo(deviceSerial, app);
    return fakeAdb.openAppInfo(deviceSerial, app);
  }

  @override
  Future<void> requestUnarchiveApp(String deviceSerial, AdbApp app) async {
    await realAdb.requestUnarchiveApp(deviceSerial, app);
    return fakeAdb.requestUnarchiveApp(deviceSerial, app);
  }

  @override
  Future<String> runAdb(List<String> args, {bool silent = false}) async {
    await realAdb.runAdb(args, silent: silent);
    return fakeAdb.runAdb(args, silent: silent);
  }

  @override
  Future<void> setRestrictBackgroundData(
    String deviceSerial,
    AdbApp app,
    bool restrict,
  ) async {
    await realAdb.setRestrictBackgroundData(deviceSerial, app, restrict);
    return fakeAdb.setRestrictBackgroundData(deviceSerial, app, restrict);
  }

  @override
  Future<void> setRestrictedBackground(
    AdbApp app,
    String deviceSerial,
    bool restricted,
  ) async {
    await realAdb.setRestrictedBackground(app, deviceSerial, restricted);
    return fakeAdb.setRestrictedBackground(app, deviceSerial, restricted);
  }

  @override
  Future<void> setWhitelistedBackground(
    AdbApp app,
    String deviceSerial,
    bool whitelist,
  ) async {
    await realAdb.setWhitelistedBackground(app, deviceSerial, whitelist);
    return fakeAdb.setWhitelistedBackground(app, deviceSerial, whitelist);
  }
}

/// Overrides [runAdb] to record its command and return nothing.
class _RealAdbImpl extends AdbImpl {
  const _RealAdbImpl(this.records) : super('adb');
  final List<String> records;
  @override
  Future<String> runAdb(List<String> args, {bool silent = false}) async {
    records.add(['adb', ...args].join(' '));
    return '';
  }
}
