import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/compute/fake_adb_impl.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/lawn_icons.dart';

import 'utils/recording_adb.dart';

void main() {
  final device = AdbDevice('Pixel_6_Pro', 'device');
  final app = AdbApp.fromValues(
    'com.adilhanney.saber',
    installer: 'null',
    uid: '10096',
    isSystemApp: false,
    isUninstalled: false,
    displayName: 'Saber',
  );

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

      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.getDevices();
        expect(impl.records, ['adb devices -l']);
      });
    });

    group('getDeviceName()', () {
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

      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.getDeviceName(device.serial);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell getprop ro.product.manufacturer',
          'adb -s Pixel_6_Pro shell getprop ro.product.model',
        ]);
      });
    });

    group('getApps()', () {
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

      test('with Vivo work profile', () async {
        // Vivo seems to throw a one-line error before the actual list.
        // https://github.com/adil192/no_more_background/issues/61
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '''
Error: Shell does not have permission to access user 11
package:com.android.emergency installer=null uid:10245
package:com.vivo.gamewatch installer=null uid:1000
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

      test('with arbitrary error', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.getApps = (
            systemApps: '''
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
Exception occurred while executing 'list':
This is an error that NoMoreBackground hasn't seen before.
''',
            systemAppsWithUninstalled: '',
            userApps: '',
            userAppsWithUninstalled: '',
          );

        final logs = <LogRecord>[];
        final subscription = Adb.log.onRecord.listen(logs.add);
        addTearDown(subscription.cancel);

        final appsFuture = Adb.getApps(device.serial, includeSystemApps: true);
        await expectLater(
          appsFuture,
          completes,
          reason: 'getApps shouldn\'t fail when encountering arbitrary errors',
        );
        final apps = await appsFuture;
        expect(apps, hasLength(2));

        expect(logs, hasLength(1));
        expect(
          logs.first.message,
          '''
Failed to parse line:
Exception occurred while executing 'list':
Please report this error! Full adb output:
[package:com.android.vending  installer=com.android.vending uid:9973, package:com.android.systemui  installer=null uid:9810, Exception occurred while executing 'list':, This is an error that NoMoreBackground hasn't seen before., ]''',
        );
      });

      test('adb command, without system apps', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.getApps(device.serial, includeSystemApps: false);
        expect(impl.records, [
          'adb shell am get-current-user',
          'adb -s Pixel_6_Pro shell pm list packages -i -U --user 0 -3',
          'adb -s Pixel_6_Pro shell pm list packages -i -U --user 0 -3 -u',
        ]);
      });

      test('adb command, with system apps', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.getApps(device.serial, includeSystemApps: true);
        expect(impl.records, [
          'adb shell am get-current-user',
          'adb -s Pixel_6_Pro shell pm list packages -i -U --user 0 -s',
          'adb -s Pixel_6_Pro shell pm list packages -i -U --user 0 -s -u',
          'adb -s Pixel_6_Pro shell pm list packages -i -U --user 0 -3',
          'adb -s Pixel_6_Pro shell pm list packages -i -U --user 0 -3 -u',
        ]);
      });
    });

    group('getRunAnyInBackground()', () {
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

      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.getAppsWithRestrictedBackground(device.serial);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell cmd appops query-op RUN_ANY_IN_BACKGROUND ignore',
        ]);
      });
    });

    group('getAppsWithWhitelistedBackground()', () {
      test('no adb', () async {
        Adb.impl = null;
        final result = await Adb.getAppsWithWhitelistedBackground(
          device.serial,
        );
        expect(result, isEmpty);
      });

      test('whitelisted', () async {
        Adb.impl = FakeAdbImpl()
          ..outputs.appsWithWhitelistedBackground = {app.packageName};
        final result = await Adb.getAppsWithWhitelistedBackground(
          device.serial,
        );
        expect(result, contains(app.packageName));
      });

      test('not whitelisted', () async {
        Adb.impl = FakeAdbImpl()..outputs.appsWithWhitelistedBackground = {};
        final result = await Adb.getAppsWithWhitelistedBackground(
          device.serial,
        );
        expect(result, isNot(contains(app.packageName)));
      });

      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.getAppsWithWhitelistedBackground(device.serial);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell dumpsys deviceidle whitelist',
        ]);
      });
    });

    group('setBackgroundActivity', () {
      for (final backgroundActivity in BackgroundActivity.values) {
        test('adb command, $backgroundActivity', () async {
          final impl = Adb.impl = RecordingAdbImpl();
          await Adb.setBackgroundActivity(
            device.serial,
            app,
            backgroundActivity,
          );
          expect(impl.records, switch (backgroundActivity) {
            .reduced => [
              'adb -s Pixel_6_Pro shell cmd appops set com.adilhanney.saber RUN_ANY_IN_BACKGROUND ignore',
              'adb -s Pixel_6_Pro shell dumpsys deviceidle whitelist -com.adilhanney.saber',
            ],
            .auto => [
              'adb -s Pixel_6_Pro shell cmd appops set com.adilhanney.saber RUN_ANY_IN_BACKGROUND allow',
              'adb -s Pixel_6_Pro shell dumpsys deviceidle whitelist -com.adilhanney.saber',
            ],
            .unrestricted => [
              'adb -s Pixel_6_Pro shell cmd appops set com.adilhanney.saber RUN_ANY_IN_BACKGROUND allow',
              'adb -s Pixel_6_Pro shell dumpsys deviceidle whitelist +com.adilhanney.saber',
            ],
          });
        });
      }
    });

    group('getAppsWithRestrictedBackgroundData()', () {
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

      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.getAppsWithRestrictedBackgroundData(device.serial);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell cmd netpolicy list restrict-background-blacklist',
        ]);
      });
    });

    group('setRestrictBackgroundData', () {
      test('adb command, restrict', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.setRestrictBackgroundData(device.serial, app, true);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell cmd netpolicy add restrict-background-blacklist 10096',
        ]);
      });

      test('adb command, unrestrict', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.setRestrictBackgroundData(device.serial, app, false);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell cmd netpolicy remove restrict-background-blacklist 10096',
        ]);
      });
    });

    group('archiveApp', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.archiveApp(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell pm archive com.adilhanney.saber',
        ]);
      });
    });

    group('requestUnarchiveApp', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.requestUnarchiveApp(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell pm request-unarchive com.adilhanney.saber',
        ]);
      });
    });

    group('openAppInfo', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.openAppInfo(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell am start -a android.settings.APPLICATION_DETAILS_SETTINGS -d package:com.adilhanney.saber',
        ]);
      });
    });

    group('forceStop', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.forceStop(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell am force-stop com.adilhanney.saber',
        ]);
      });
    });

    group('softStop', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.softStop(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell am stop-app com.adilhanney.saber',
        ]);
      });
    });

    group('hideApp', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.hideApp(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell pm hide com.adilhanney.saber',
        ]);
      });
    });

    group('unhideApp', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.unhideApp(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell pm unhide com.adilhanney.saber',
        ]);
      });
    });

    group('enableApp', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.enableApp(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell pm enable com.adilhanney.saber',
        ]);
      });
    });

    group('disableApp', () {
      test('adb command', () async {
        final impl = Adb.impl = RecordingAdbImpl();
        await Adb.disableApp(device.serial, app);
        expect(impl.records, [
          'adb -s Pixel_6_Pro shell pm disable-user com.adilhanney.saber',
        ]);
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
