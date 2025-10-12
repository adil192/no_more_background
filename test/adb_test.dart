import 'package:flutter_test/flutter_test.dart';
import 'package:no_more_background/compute/adb.dart';

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
  });
}

class TestAdbImpl implements AdbImpl {
  TestAdbImpl();

  @override
  final String exe = '/tmp/test-adb';

  String getDevicesOutput = '''List of devices attached
emulator-5556 device product:sdk_google_phone_x86_64 model:Android_SDK_built_for_x86_64 device:generic_x86_64
emulator-5554 device product:sdk_google_phone_x86 model:Android_SDK_built_for_x86 device:generic_x86
0a388e93      unauthorized usb:1-1 product:razor model:Nexus_7 device:flo
4C0210000000  device usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:5

''';
  @override
  Future<String> getDevices() async => getDevicesOutput;
}
