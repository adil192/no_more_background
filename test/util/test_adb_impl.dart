import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

class TestAdbImpl implements AdbImpl {
  TestAdbImpl();

  @override
  final String exe = '/tmp/test-adb';

  @override
  Future<String> getDevices() async => getDevicesOutput;
  var getDevicesOutput = '''List of devices attached
emulator-5556 device product:sdk_google_phone_x86_64 model:Android_SDK_built_for_x86_64 device:generic_x86_64
emulator-5554 unauthorized product:sdk_google_phone_x86 model:Android_SDK_built_for_x86 device:generic_x86
0a388e93      device usb:1-1 product:razor model:Nexus_7 device:flo

''';

  @override
  Future<(String, String)> getApps(AdbDevice device) async => getAppsOutput;
  var getAppsOutput = (
    '''package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
package:com.google.android.youtube  installer=com.android.vending uid:10021
''',
    '''package:com.adilhanney.saber  installer=com.google.android.packageinstaller uid:10096
package:app.revanced.android.youtube  installer=null uid:10044
''',
  );

  bool runAnyInBackground = true;
  @override
  Future<String> getRunAnyInBackground(AdbApp app, AdbDevice device) async {
    return runAnyInBackground
        ? 'RUN_ANY_IN_BACKGROUND: allow'
        : 'RUN_ANY_IN_BACKGROUND: ignore';
  }

  @override
  Future<void> setRunAnyInBackground(
    AdbApp app,
    AdbDevice device,
    bool allow,
  ) async {
    runAnyInBackground = allow;
  }

  String restrictedBackgroundDataOutput = '';
  @override
  Future<String> getAppsWithRestrictedBackgroundData(AdbDevice device) async {
    return restrictedBackgroundDataOutput;
  }

  @override
  Future<void> setRestrictBackgroundData(
    AdbDevice device,
    AdbApp app,
    bool restrict,
  ) async {}
}
