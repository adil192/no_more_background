import 'package:flutter_test/flutter_test.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/compute/test_adb_impl.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

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
            '0a388e93',
            'device',
            usb: '1-1',
            product: 'razor',
            model: 'Nexus_7',
            device: 'flo',
          ).serialized,
          AdbDevice(
            'B05699QHA000B3',
            'unauthorized',
            product: 'caiman',
            model: 'Pixel_9_Pro',
            device: 'caiman',
            usb: '3-2',
            transportId: '9',
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

    group('getApps()', () {
      final device = AdbDevice('emulator-5556', 'device');
      test('no adb', () async {
        Adb.impl = null;
        final apps = await Adb.getApps(device.serial);
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
        final apps = await Adb.getApps(device.serial);
        expect(apps, isEmpty);
      });

      test('some apps', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
package:com.google.android.youtube  installer=com.android.vending uid:10021
''',
            systemAppsWithUninstalled: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
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
        final apps = await Adb.getApps(device.serial);
        expect(apps, [
          AdbApp(
            'app.revanced.android.youtube',
            installer: 'null',
            uid: '10044',
            isSystemApp: false,
          ),
          AdbApp(
            'com.adilhanney.saber',
            installer: 'com.google.android.packageinstaller',
            uid: '10096',
            isSystemApp: false,
          ),
          AdbApp(
            'com.android.systemui',
            installer: 'null',
            uid: '9810',
            isSystemApp: true,
          ),
          AdbApp(
            'com.android.vending',
            installer: 'com.android.vending',
            uid: '9973',
            isSystemApp: true,
          ),
          AdbApp(
            'com.google.android.youtube',
            installer: 'com.android.vending',
            uid: '10021',
            isSystemApp: true,
          ),
          AdbApp(
            'com.ubercab',
            installer: 'com.android.vending',
            uid: '10116',
            isSystemApp: false,
            isUninstalled: true,
          ),
        ]);
      });
    });

    group('getRunAnyInBackground()', () {
      final device = AdbDevice('emulator-5556', 'device');
      final app = AdbApp(
        'com.adilhanney.saber',
        installer: 'null',
        uid: '10096',
        isSystemApp: false,
      );

      test('no adb', () async {
        Adb.impl = null;
        final result = await Adb.getRunAnyInBackground(device.serial, app);
        expect(result, isFalse);
      });

      test('cannot run in background', () async {
        Adb.impl = FakeAdbImpl()
          ..setRunAnyInBackground(app, device.serial, false);
        final canRun = await Adb.getRunAnyInBackground(device.serial, app);
        expect(canRun, isFalse);
      });

      test('can run in background', () async {
        Adb.impl = FakeAdbImpl()
          ..setRunAnyInBackground(app, device.serial, true);
        final canRun = await Adb.getRunAnyInBackground(device.serial, app);
        expect(canRun, isTrue);
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
