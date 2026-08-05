import 'package:flutter/foundation.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';

class FakeAdbImpl implements AdbImpl {
  FakeAdbImpl();
  final outputs = FakeAdbImplOutputs();

  @override
  final String exe = '/tmp/test/adb';

  @override
  @visibleForTesting
  @visibleForOverriding
  Future<String> runAdb(List<String> args, {bool silent = false}) =>
      Future.error(
        UnimplementedError('adb binary is not available in TestAdbImpl'),
      );

  @override
  Future<String> getCurrentUser(AdbDeviceSerial deviceSerial) async => '0';

  @override
  Future<String> getProp(AdbDeviceSerial deviceSerial, String key) async =>
      outputs.props[deviceSerial]?[key] ?? '';

  @override
  Future<AppLists> getApps(
    AdbDeviceSerial deviceSerial, {
    required bool includeSystemApps,
  }) async => (
    systemApps: includeSystemApps ? outputs.getApps.systemApps : '',
    systemAppsWithUninstalled: includeSystemApps
        ? outputs.getApps.systemAppsWithUninstalled
        : '',
    userApps: outputs.getApps.userApps,
    userAppsWithUninstalled: outputs.getApps.userAppsWithUninstalled,
  );

  @override
  Future<String> getDevices() async => outputs.getDevices;

  @override
  Future<String> getAppsWithRestrictedBackground(
    AdbDeviceSerial deviceSerial,
  ) async => outputs.appsWithRestrictedBackground.join('\n');
  @override
  Future<void> setRestrictedBackground(
    AdbApp app,
    AdbDeviceSerial deviceSerial,
    bool restricted,
  ) async {
    if (restricted) {
      outputs.appsWithRestrictedBackground.add(app.packageName);
    } else {
      outputs.appsWithRestrictedBackground.remove(app.packageName);
    }
  }

  @override
  Future<String> getAppsWithWhitelistedBackground(
    AdbDeviceSerial deviceSerial,
  ) async => [
    'system-excidle,com.android.vending,12345',
    'system-excidle,com.google.android.gms,12345',
    'system,com.android.cellbroadcastreceiver,12345',
    for (final packageName in outputs.appsWithWhitelistedBackground)
      'user,$packageName,12345',
  ].join('\n');
  @override
  Future<void> setWhitelistedBackground(
    AdbApp app,
    AdbDeviceSerial deviceSerial,
    bool whitelist,
  ) async {
    if (whitelist) {
      outputs.appsWithWhitelistedBackground.add(app.packageName);
    } else {
      outputs.appsWithWhitelistedBackground.remove(app.packageName);
    }
  }

  @override
  Future<String> getAppsWithRestrictedBackgroundData(
    AdbDeviceSerial deviceSerial,
  ) async => outputs.getAppsWithRestrictedBackgroundData;

  @override
  Future<void> setRestrictBackgroundData(
    AdbDeviceSerial deviceSerial,
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
  Future<void> archiveApp(AdbDeviceSerial deviceSerial, AdbApp app) async {}

  @override
  Future<void> requestUnarchiveApp(
    AdbDeviceSerial deviceSerial,
    AdbApp app,
  ) async {}

  @override
  Future<void> openAppInfo(AdbDeviceSerial deviceSerial, AdbApp app) async {}

  @override
  Future<void> forceStop(AdbDeviceSerial deviceSerial, AdbApp app) async {}

  @override
  Future<void> softStop(AdbDeviceSerial deviceSerial, AdbApp app) async {}

  @override
  Future<void> hideApp(AdbDeviceSerial deviceSerial, AdbApp app) async {}

  @override
  Future<void> unhideApp(AdbDeviceSerial deviceSerial, AdbApp app) async {}

  @override
  Future<void> enableApp(AdbDeviceSerial deviceSerial, AdbApp app) async {}

  @override
  Future<void> disableApp(AdbDeviceSerial deviceSerial, AdbApp app) async {}
}

@visibleForTesting
class FakeAdbImplOutputs {
  var getDevices = '''
List of devices attached
B05699QHA000B3     device usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:9
ra388e93           unauthorized usb:1-1 product:razor model:Nexus_7 device:flo
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
  var appsWithRestrictedBackground = {
    'com.google.android.youtube',
    'com.zhiliaoapp.musically',
    'com.valvesoftware.android.steam.community',
  };
  var appsWithWhitelistedBackground = {'com.celzero.bravedns'};
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
  var props = {
    AdbDeviceSerial('B05699QHA000B3'): {
      'ro.product.manufacturer': 'Google',
      'ro.product.model': 'Pixel 9 Pro',
    },
    AdbDeviceSerial('ra388e93'): {
      'ro.product.manufacturer': 'Google',
      'ro.product.model': 'Nexus 7',
    },
    AdbDeviceSerial('192.168.0.18:5555'): {
      'ro.product.manufacturer': 'Google',
      'ro.product.model': 'Chromecast with Google TV (4K)',
    },
  };
}
