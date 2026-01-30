import 'package:flutter/foundation.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';

class TestAdbImpl implements AdbImpl {
  TestAdbImpl();
  final outputs = TestAdbImplOutputs();

  @override
  final String exe = '/tmp/test/adb';

  @override
  @protected
  @visibleForOverriding
  Future<String> runAdb(List<String> args, {bool silent = false}) =>
      Future.error(
        UnimplementedError('adb binary is not available in TestAdbImpl'),
      );

  @override
  Future<(String, String)> getApps(String deviceSerial) async =>
      outputs.getApps;

  @override
  Future<String> getAppsWithRestrictedBackgroundData(
    String deviceSerial,
  ) async => outputs.getAppsWithRestrictedBackgroundData;

  @override
  Future<String> getDevices() async => outputs.getDevices;

  @override
  Future<String> getRunAnyInBackground(AdbApp app, String deviceSerial) async =>
      outputs.getRunAnyInBackgroundMap[app.packageName] ?? true
      ? 'RUN_ANY_IN_BACKGROUND: allow'
      : 'RUN_ANY_IN_BACKGROUND: ignore';

  @override
  Future<void> setRestrictBackgroundData(
    String deviceSerial,
    AdbApp app,
    bool restrict,
  ) async {}

  @override
  Future<void> setRunAnyInBackground(
    AdbApp app,
    String deviceSerial,
    bool allow,
  ) async {
    outputs.getRunAnyInBackgroundMap[app.packageName] = allow;
  }
}

@visibleForTesting
class TestAdbImplOutputs {
  var getDevices = '''
List of devices attached
0a388e93           device usb:1-1 product:razor model:Nexus_7 device:flo
B05699QHA000B3     unauthorized usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:9
192.168.0.18:5555  device product:sabrina_prod_stable model:Chromecast device:sabrina transport_id:1

''';
  var getApps = (
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
  var getRunAnyInBackgroundMap = {
    'app.revanced.android.youtube': false,
    'app.revanced.manager.flutter': false,
  };
  var getAppsWithRestrictedBackgroundData =
      'Restrict background blacklisted UIDs: 10045 10050 10065 10075 10090 10100';
}
