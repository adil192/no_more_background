import 'package:flutter/foundation.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';

class FakeAdbImpl implements AdbImpl {
  FakeAdbImpl();
  final outputs = FakeAdbImplOutputs();

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
  Future<AppLists> getApps(String deviceSerial) async => outputs.getApps;

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
  ) async {
    if (restrict) {
      outputs.uidsWithRestrictedBackgroundData.add(int.parse(app.uid));
    } else {
      outputs.uidsWithRestrictedBackgroundData.remove(int.parse(app.uid));
    }
  }

  @override
  Future<void> setRunAnyInBackground(
    AdbApp app,
    String deviceSerial,
    bool allow,
  ) async {
    outputs.getRunAnyInBackgroundMap[app.packageName] = allow;
  }

  @override
  Future<void> archiveApp(String deviceSerial, AdbApp app) async {}

  @override
  Future<void> requestUnarchiveApp(String deviceSerial, AdbApp app) async {}
}

@visibleForTesting
class FakeAdbImplOutputs {
  var getDevices = '''
List of devices attached
0a388e93           device usb:1-1 product:razor model:Nexus_7 device:flo
B05699QHA000B3     unauthorized usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:9
192.168.0.18:5555  device product:sabrina_prod_stable model:Chromecast device:sabrina transport_id:1

''';
  AppLists getApps = (
    systemApps: '''
package:android  installer=null uid:1000
package:android.auto_generated_rro_product__  installer=null uid:1001
package:android.auto_generated_rro_vendor__  installer=null uid:1002
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
''',
    systemAppsWithUninstalled: '''
package:android  installer=null uid:1000
package:android.auto_generated_rro_product__  installer=null uid:1001
package:android.auto_generated_rro_vendor__  installer=null uid:1002
package:com.android.vending  installer=com.android.vending uid:9973
package:com.android.systemui  installer=null uid:9810
''',
    userApps: '''
package:cn.com.aftershokz.app  installer=com.android.vending uid:10060
package:com.adilhanney.ricochlime  installer=org.fdroid.fdroid uid:10075
package:com.adilhanney.saber  installer=com.android.vending uid:10080
package:com.celzero.bravedns  installer=com.android.vending uid:10095
package:com.discord  installer=com.android.vending uid:10100
package:com.duckduckgo.mobile.android  installer=org.fdroid.fdroid uid:10105
package:com.google.android.apps.adm  installer=com.android.vending uid:10110
package:com.google.android.youtube  installer=com.android.vending uid:10115
package:com.valvesoftware.android.steam.community  installer=com.android.vending uid:10117
package:com.whatsapp  installer=com.android.vending uid:10120
package:com.zhiliaoapp.musically  installer=com.android.vending uid:10125
package:net.thunderbird.android  installer=org.fdroid.fdroid uid:10130
''',
    userAppsWithUninstalled: '''
package:cn.com.aftershokz.app  installer=com.android.vending uid:10060
package:com.adilhanney.ricochlime  installer=org.fdroid.fdroid uid:10075
package:com.adilhanney.saber  installer=com.android.vending uid:10080
package:com.amazon.mShop.android.shopping  installer=com.android.vending uid:10090
package:com.celzero.bravedns  installer=com.android.vending uid:10095
package:com.discord  installer=com.android.vending uid:10100
package:com.duckduckgo.mobile.android  installer=org.fdroid.fdroid uid:10105
package:com.google.android.apps.adm  installer=com.android.vending uid:10110
package:com.google.android.youtube  installer=com.android.vending uid:10115
package:com.ubercab  installer=com.android.vending uid:10116
package:com.valvesoftware.android.steam.community  installer=com.android.vending uid:10117
package:com.whatsapp  installer=com.android.vending uid:10120
package:com.zhiliaoapp.musically  installer=com.android.vending uid:10125
package:net.thunderbird.android  installer=org.fdroid.fdroid uid:10130
''',
  );
  var getRunAnyInBackgroundMap = {
    'com.google.android.youtube': false,
    'com.zhiliaoapp.musically': false,
    'com.valvesoftware.android.steam.community': false,
  };
  var uidsWithRestrictedBackgroundData = {
    10075,
    10090,
    10100,
    10105,
    10115,
    10117,
    10125,
  };
  String get getAppsWithRestrictedBackgroundData =>
      'Restrict background blacklisted UIDs: ${uidsWithRestrictedBackgroundData.join(' ')}';
}
