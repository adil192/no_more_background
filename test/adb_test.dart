import 'package:flutter_test/flutter_test.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

import 'util/test_adb_impl.dart';

void main() {
  group('adb', () {
    group('getDevices()', () {
      test('no adb', () async {
        Adb.impl = null;
        final devices = await Adb.getDevices();
        expect(devices, isEmpty);
      });

      test('no devices', () async {
        Adb.impl = TestAdbImpl()
          ..getDevicesOutput = 'List of devices attached\n\n';
        final devices = await Adb.getDevices();
        expect(devices, isEmpty);
      });

      test('multiple devices', () async {
        Adb.impl = TestAdbImpl();
        final devices = await Adb.getDevices();
        expect(devices, [
          AdbDevice(
            'emulator-5556',
            'device',
            product: 'sdk_google_phone_x86_64',
            model: 'Android_SDK_built_for_x86_64',
            device: 'generic_x86_64',
          ),
          AdbDevice(
            'emulator-5554',
            'device',
            product: 'sdk_google_phone_x86',
            model: 'Android_SDK_built_for_x86',
            device: 'generic_x86',
          ),
          AdbDevice(
            '0a388e93',
            'unauthorized',
            usb: '1-1',
            product: 'razor',
            model: 'Nexus_7',
            device: 'flo',
          ),
          AdbDevice(
            '4C0210000000',
            'device',
            usb: '3-2',
            product: 'caiman',
            model: 'Pixel_9_Pro',
            device: 'caiman',
            transportId: '5',
          ),
        ]);
      });
    });

    group('getApps()', () {
      final device = AdbDevice('emulator-5556', 'device');
      test('no adb', () async {
        Adb.impl = null;
        final apps = await Adb.getApps(device);
        expect(apps, isEmpty);
      });

      test('no apps', () async {
        Adb.impl = TestAdbImpl()..getAppsOutput = ('', '');
        final apps = await Adb.getApps(device);
        expect(apps, isEmpty);
      });

      test('some apps', () async {
        Adb.impl = TestAdbImpl();
        final apps = await Adb.getApps(device);
        expect(apps, [
          AdbApp(
            'app.revanced.android.youtube',
            installer: 'null',
            isSystemApp: false,
          ),
          AdbApp(
            'com.adilhanney.saber',
            installer: 'com.google.android.packageinstaller',
            isSystemApp: false,
          ),
          AdbApp('com.android.systemui', installer: 'null', isSystemApp: true),
          AdbApp(
            'com.android.vending',
            installer: 'com.android.vending',
            isSystemApp: true,
          ),
          AdbApp(
            'com.google.android.youtube',
            installer: 'com.android.vending',
            isSystemApp: true,
          ),
        ]);
      });
    });

    group('getRunAnyInBackground()', () {
      final device = AdbDevice('emulator-5556', 'device');
      final app = AdbApp('com.app', installer: 'null', isSystemApp: false);

      test('no adb', () async {
        Adb.impl = null;
        final result = await Adb.getRunAnyInBackground(device, app);
        expect(result, isFalse);
      });

      test('cannot run in background', () async {
        Adb.impl = TestAdbImpl()..runAnyInBackground = false;
        final canRun = await Adb.getRunAnyInBackground(device, app);
        expect(canRun, isFalse);
      });

      test('can run in background', () async {
        Adb.impl = TestAdbImpl()..runAnyInBackground = true;
        final canRun = await Adb.getRunAnyInBackground(device, app);
        expect(canRun, isTrue);
      });
    });

    group('getAppsWithRestrictedBackgroundData()', () {
      final device = AdbDevice('emulator-5556', 'device');

      test('no adb', () async {
        Adb.impl = null;
        final uids = await Adb.getAppsWithRestrictedBackgroundData(device);
        expect(uids, isEmpty);
      });

      test('some restricted uids', () async {
        Adb.impl = TestAdbImpl()
          ..restrictedBackgroundDataOutput =
              'Restrict background blacklisted UIDs: 10021 10044 10053 10096';
        final uids = await Adb.getAppsWithRestrictedBackgroundData(device);
        expect(uids, ['10021', '10044', '10053', '10096']);
      });
    });
  });
}
