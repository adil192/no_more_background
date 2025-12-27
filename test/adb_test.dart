import 'package:flutter_test/flutter_test.dart';
import 'package:no_more_background/compute/adb.dart';
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
        Adb.impl = TestAdbImpl()
          ..outputs.getDevices = 'List of devices attached\n\n';
        final devices = await Adb.getDevices();
        expect(devices, isEmpty);
      });

      test('multiple devices', () async {
        Adb.impl = TestAdbImpl();
        final devices = await Adb.getDevices();
        expect(devices, [
          AdbDevice(
            '0a388e93',
            'device',
            usb: '1-1',
            product: 'razor',
            model: 'Nexus_7',
            device: 'flo',
          ),
          AdbDevice(
            'B05699QHA000B3',
            'unauthorized',
            product: 'caiman',
            model: 'Pixel_9_Pro',
            device: 'caiman',
            usb: '3-2',
            transportId: '9',
          ),
          AdbDevice(
            '192.168.0.18:5555',
            'device',
            product: 'sabrina_prod_stable',
            model: 'Chromecast',
            device: 'sabrina',
            transportId: '1',
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
        Adb.impl = TestAdbImpl()..outputs.getApps = ('', '');
        final apps = await Adb.getApps(device);
        expect(apps, isEmpty);
      });

      test('some apps', () async {
        Adb.impl = TestAdbImpl()
          ..outputs.getApps = (
            '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
package:com.google.android.youtube  installer=com.android.vending uid:10021
''',
            '''
package:com.adilhanney.saber  installer=com.google.android.packageinstaller uid:10096
package:app.revanced.android.youtube  installer=null uid:10044
''',
          );
        final apps = await Adb.getApps(device);
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
        final result = await Adb.getRunAnyInBackground(device, app);
        expect(result, isFalse);
      });

      test('cannot run in background', () async {
        Adb.impl = TestAdbImpl()..setRunAnyInBackground(app, device, false);
        final canRun = await Adb.getRunAnyInBackground(device, app);
        expect(canRun, isFalse);
      });

      test('can run in background', () async {
        Adb.impl = TestAdbImpl()..setRunAnyInBackground(app, device, true);
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
          ..outputs.getAppsWithRestrictedBackgroundData =
              'Restrict background blacklisted UIDs: 10021 10044 10053 10096';
        final uids = await Adb.getAppsWithRestrictedBackgroundData(device);
        expect(uids, ['10021', '10044', '10053', '10096']);
      });
    });
  });
}
