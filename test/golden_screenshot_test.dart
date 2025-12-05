import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:yaru/theme.dart';

import 'util/test_adb_impl.dart';

void main() {
  group('Screenshot:', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    ConnectPage.slowDownDeviceScanning = false;
    final device = AdbDevice.fromAdbOutput(
      '0a388e93      device usb:1-1 product:razor model:Nexus_7 device:flo',
    );
    setUp(() {
      Adb.impl = TestAdbImpl();
    });

    _screenshot('1_connect', home: ConnectPage());

    _screenshot('2_apps', home: AppsPage(device: device));
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
