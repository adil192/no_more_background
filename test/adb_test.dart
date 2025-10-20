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
          AdbApp('com.android.vending', isSystemApp: true),
          AdbApp('com.android.systemui', isSystemApp: true),
          AdbApp('com.google.android.youtube', isSystemApp: true),
          AdbApp('com.adilhanney.saber', isSystemApp: false),
          AdbApp('com.example.myapp', isSystemApp: false),
        ]);
      });
    });
  });
}

class TestAdbImpl implements AdbImpl {
  TestAdbImpl();

  @override
  final String exe = '/tmp/test-adb';

  @override
  Future<String> getDevices() async => getDevicesOutput;
  var getDevicesOutput = '''List of devices attached
emulator-5556 device product:sdk_google_phone_x86_64 model:Android_SDK_built_for_x86_64 device:generic_x86_64
emulator-5554 device product:sdk_google_phone_x86 model:Android_SDK_built_for_x86 device:generic_x86
0a388e93      unauthorized usb:1-1 product:razor model:Nexus_7 device:flo
4C0210000000  device usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:5

''';

  @override
  Future<(String, String)> getApps(AdbDevice device) async => getAppsOutput;
  var getAppsOutput = (
    '''package:com.android.vending
package:com.android.systemui
package:com.google.android.youtube
''',
    '''package:com.adilhanney.saber
package:com.example.myapp
''',
  );
}
