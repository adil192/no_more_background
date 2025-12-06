import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

class TestAdbImpl implements AdbImpl {
  TestAdbImpl();

  @override
  final String exe = '/tmp/test-adb';

  @override
  Future<String> getDevices() async => getDevicesOutput;
  var getDevicesOutput = '''
List of devices attached
emulator-5556 device product:sdk_google_phone_x86_64 model:Android_SDK_built_for_x86_64 device:generic_x86_64
emulator-5554 unauthorized product:sdk_google_phone_x86 model:Android_SDK_built_for_x86 device:generic_x86
0a388e93      device usb:1-1 product:razor model:Nexus_7 device:flo

''';

  @override
  Future<(String, String)> getApps(AdbDevice device) async => getAppsOutput;
  var getAppsOutput = (
    '''
package:android  installer=null uid:1000
package:android.auto_generated_rro_product__  installer=null uid:1001
package:android.auto_generated_rro_vendor__  installer=null uid:1002
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
package:com.google.android.youtube  installer=com.android.vending uid:10021
''',
    '''
package:app.revanced.android.youtube  installer=null uid:10045
package:app.revanced.manager.flutter  installer=null uid:10050
package:cn.com.aftershokz.app  installer=com.android.vending uid:10060
package:com.abdurazaaqmohammed.AntiSplit  installer=com.google.android.packageinstaller uid:10065
package:com.adilhanney.ricochlime  installer=com.android.vending uid:10075
package:com.adilhanney.saber  installer=com.google.android.packageinstaller uid:10080
package:com.amazon.mShop.android.shopping  installer=com.android.vending uid:10090
package:com.celzero.bravedns  installer=com.android.vending uid:10095
package:com.discord  installer=com.android.vending uid:10100
package:com.ebay.mobile  installer=com.android.vending uid:10105
package:com.fitbit.FitbitMobile  installer=com.android.vending uid:10110
package:com.google.android.apps.adm  installer=com.android.vending uid:10115
''',
  );

  final runAnyInBackgroundMap = <AdbApp, bool>{};
  @override
  Future<String> getRunAnyInBackground(AdbApp app, AdbDevice device) async {
    final runAnyInBackground = runAnyInBackgroundMap[app] ?? true;
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
    runAnyInBackgroundMap[app] = allow;
  }

  String restrictedBackgroundDataOutput =
      'Restrict background blacklisted UIDs: 10045 10050 10065 10075 10090 10100';
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
