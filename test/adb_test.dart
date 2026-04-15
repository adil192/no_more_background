import 'package:flutter_test/flutter_test.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/compute/test_adb_impl.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/lawn_icons.dart';

void main() {
  group('adb', () {
    group('getDevices()', () {
      test('no adb', () async {
        Adb.impl = null;
        final devices = await Adb.getDevices();
        expect(devices, isEmpty);
      });

      test('no devices', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getDevices = 'List of devices attached\n\n';
        final devices = await Adb.getDevices();
        expect(devices, isEmpty);
      });

      test('multiple devices', () async {
        Adb.impl = FakeAdbImpl();
        final devices = await Adb.getDevices();
        expect(devices.map((device) => device.serialized).toList(), [
          AdbDevice(
            'B05699QHA000B3',
            'device',
            product: 'caiman',
            model: 'Pixel_9_Pro',
            device: 'caiman',
            usb: '3-2',
            transportId: '9',
          ).serialized,
          AdbDevice(
            'ra388e93',
            'unauthorized',
            usb: '1-1',
            product: 'razor',
            model: 'Nexus_7',
            device: 'flo',
          ).serialized,
          AdbDevice(
            '192.168.0.18:5555',
            'device',
            product: 'sabrina_prod_stable',
            model: 'Chromecast',
            device: 'sabrina',
            transportId: '1',
          ).serialized,
        ]);
      });
    });

    group('getDeviceName()', () {
      final device = AdbDevice('Pixel_6_Pro', 'device');
      test('Pixel 6 Pro', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.props = {
            'Pixel_6_Pro': {
              'ro.product.manufacturer': 'Google',
              'ro.product.model': 'Pixel 6 Pro',
            },
          };
        final model = await Adb.getDeviceName(device.serial);
        expect(model, 'Google Pixel 6 Pro');
      });
    });

    group('getApps()', () {
      final device = AdbDevice('emulator-5556', 'device');
      test('no adb', () async {
        Adb.impl = null;
        final apps = await Adb.getApps(device.serial, includeSystemApps: true);
        expect(apps, isEmpty);
      });

      test('no apps', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '',
            systemAppsWithUninstalled: '',
            userApps: '',
            userAppsWithUninstalled: '',
          );
        final apps = await Adb.getApps(device.serial, includeSystemApps: true);
        expect(apps, isEmpty);
      });

      test('no user apps, don\'t include system apps', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
''',
            systemAppsWithUninstalled: '',
            userApps: '',
            userAppsWithUninstalled: '',
          );
        final apps = await Adb.getApps(device.serial, includeSystemApps: false);
        expect(apps, isEmpty);
      });

      test('no user apps, include system apps', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
''',
            systemAppsWithUninstalled: '',
            userApps: '',
            userAppsWithUninstalled: '',
          );
        final apps = await Adb.getApps(device.serial, includeSystemApps: true);
        expect(apps, hasLength(2));
      });

      test('some apps', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
''',
            systemAppsWithUninstalled: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
package:com.google.android.youtube  installer=com.android.vending uid:10021
''',
            userApps: '''
package:com.adilhanney.saber  installer=com.google.android.packageinstaller uid:10096
package:app.revanced.android.youtube  installer=null uid:10044
''',

            userAppsWithUninstalled: '''
package:com.adilhanney.saber  installer=com.google.android.packageinstaller uid:10096
package:app.revanced.android.youtube  installer=null uid:10044
package:com.ubercab  installer=com.android.vending uid:10116
''',
          );
        await LawnIcons.init();
        final apps = await Adb.getApps(device.serial, includeSystemApps: true);
        final appStrings = apps.map((app) => app.toString()).toList();
        expect(appStrings, [
          'AdbApp(9810){ Flashlight (com.android.systemui), system app }',
          'AdbApp(9973){ Google Play Store (com.android.vending) from com.android.vending, system app }',
          'AdbApp(10096){ Saber (com.adilhanney.saber) from com.google.android.packageinstaller }',
          'AdbApp(10116){ Uber (com.ubercab) from com.android.vending, uninstalled }',
          'AdbApp(10021){ YouTube (com.google.android.youtube) from com.android.vending, system app, uninstalled }',
          'AdbApp(10044){ YouTube ReVanced (app.revanced.android.youtube) }',
        ]);
      });

      test('with work profile', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
Error: java.lang.SecurityException: Shell does not have permission to access user 10
 com.android.server.am.ActivityManagerService.handleIncomingUser:14054 android.app.ActivityManager.handleIncomingUser:5607 com.android.server.pm.PackageManagerShellCommand.translateUserId:4043
''',
            systemAppsWithUninstalled: '',
            userApps: '',
            userAppsWithUninstalled: '',
          );
        final appsFuture = Adb.getApps(device.serial, includeSystemApps: true);
        await expectLater(
          appsFuture,
          completes,
          reason: 'getApps shouldn\'t fail when encountering a work profile',
        );
        final apps = await appsFuture;
        expect(apps, hasLength(2));
      });
    });

    group('getRunAnyInBackground()', () {
      final device = AdbDevice('emulator-5556', 'device');
      final app = AdbApp.fromValues(
        'com.adilhanney.saber',
        installer: 'null',
        uid: '10096',
        isSystemApp: false,
        isUninstalled: false,
        displayName: 'Saber',
      );

      test('no adb', () async {
        Adb.impl = null;
        final result = await Adb.getAppsWithRestrictedBackground(device.serial);
        expect(result, isEmpty);
      });

      test('cannot run in background', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.appsWithRestrictedBackground = {app.packageName};
        final result = await Adb.getAppsWithRestrictedBackground(device.serial);
        expect(result, [app.packageName]);
      });

      test('can run in background', () async {
        Adb.impl = FakeAdbImpl()..outputs.appsWithRestrictedBackground = {};
        final result = await Adb.getAppsWithRestrictedBackground(device.serial);
        expect(result, isEmpty);
      });
    });

    group('getAppsWithRestrictedBackgroundData()', () {
      final device = AdbDevice('emulator-5556', 'device');

      test('no adb', () async {
        Adb.impl = null;
        final uids = await Adb.getAppsWithRestrictedBackgroundData(
          device.serial,
        );
        expect(uids, isEmpty);
      });

      test('some restricted uids', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.uidsWithRestrictedBackgroundData = {
            10021,
            10044,
            10053,
            10096,
          };
        final uids = await Adb.getAppsWithRestrictedBackgroundData(
          device.serial,
        );
        expect(uids, ['10021', '10044', '10053', '10096']);
      });
    });
  });
}

extension on AdbDevice {
  Map<String, String?> get serialized => {
    'serial': serial,
    'state': state,
    'usb': usb,
    'product': product,
    'model': model,
    'device': device,
    'transportId': transportId,
  };
}
