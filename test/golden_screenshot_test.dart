import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/icon_pack.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:yaru/theme.dart';

import 'util/test_adb_impl.dart';

final _device = AdbDevice.fromAdbOutput(
  '0a388e93      device usb:1-1 product:razor model:Nexus_7 device:flo',
);
void main() {
  group('Screenshot:', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    ConnectPage.slowDownDeviceScanning = false;
    setUpAll(() async {
      await IconPack.init();
    });
    setUp(() async {
      Adb.impl = TestAdbImpl()
        ..restrictBg('app.revanced.android.youtube')
        ..restrictBg('app.revanced.manager.flutter')
        ..restrictBg('cn.com.aftershokz.app')
        ..restrictBg('com.abdurazaaqmohammed.AntiSplit')
        ..restrictBg('com.adilhanney.ricochlime')
        ..restrictBg('com.adilhanney.super_nonogram')
        ..restrictBg('com.adilhanney.timing');
    });

    _screenshot('1_connect', home: ConnectPage());

    _screenshot(
      '2_apps',
      home: AppsPage(device: _device),
      beforeScreenshot: (tester) async {
        final state = tester.state<AppsPageState>(find.byType(AppsPage));
        await state.restrictedDataAppUids;
        await tester.pump();
        expect(
          state.apps,
          isNotEmpty,
          reason: 'AppsPage should load apps ASAP',
        );
        expect(
          state.permissionMap.keys,
          containsAll(state.apps),
          reason: 'Permissions should be loaded ASAP',
        );
      },
    );
  });
}

const _testDevices = [
  GoldenScreenshotDevices.flathub,
  GoldenScreenshotDevices.macbook,
];

void _screenshot(
  String description, {
  required Widget home,
  Future<void> Function(WidgetTester tester)? beforeScreenshot,
}) {
  group(description, () {
    for (final goldenDevice in _testDevices) {
      testGoldens('for ${goldenDevice.name}', (tester) async {
        final device = goldenDevice.device;

        await tester.pumpWidget(
          ScreenshotApp.withConditionalTitlebar(
            device: device,
            title: 'no_more_background',
            theme: yaruDark,
            home: home,
          ),
        );

        await beforeScreenshot?.call(tester);
        await tester.loadAssets();
        await tester.pumpFrames(
          tester.widget(find.byType(ScreenshotApp)),
          const Duration(seconds: 1),
        );
        await tester.expectScreenshot(device, description);
      });
    }
  });
}

extension _SuccinctAdbImpl on TestAdbImpl {
  void restrictBg(String packageName) {
    final app = AdbApp(
      packageName,
      installer: 'null',
      uid: '0',
      isSystemApp: false,
    );
    setRunAnyInBackground(app, _device, false);
  }
}
