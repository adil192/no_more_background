import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:no_more_background/components/connect_page_content_no_adb.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/compute/test_adb_impl.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/delta_icons.dart';
import 'package:no_more_background/data/lawn_icons.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:no_more_background/data/workers.dart';
import 'package:no_more_background/main.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:yaru/theme.dart';

final _device = AdbDevice.fromAdbOutput(
  '0a388e93      device usb:1-1 product:razor model:Nexus_7 device:flo',
);
void main() {
  group('Screenshot:', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    ScanDevicesPoller.slowDownDeviceScanning = false;
    setUpAll(() async {
      await DeltaIcons.init();
      await LawnIcons.init();
    });
    setUp(() async {
      Adb.impl = TestAdbImpl();
      Workers.debugDisablePolling = true;
      for (final stow in [
        stows.showSystemApps,
        stows.showReviewedApps,
        stows.showArchivedApps,
      ]) {
        stow.value = stow.defaultValue;
      }
    });
    tearDown(() {
      workers.reset();
    });

    _screenshot(
      '1_connect',
      home: ConnectPage(),
      beforeScreenshot: (tester) async {
        // Wait for devices to load
        while (workers.deviceScanner.isPolling.value) {
          await tester.runAsync(() async {
            await Future.delayed(const Duration(milliseconds: 1));
          });
        }
        await tester.pump();
        expect(
          workers.deviceScanner.value,
          isNotEmpty,
          reason: 'ConnectPage should load devices ASAP',
        );
      },
    );

    _screenshot(
      '2_apps',
      home: AppsPage(deviceSerial: _device.serial),
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

    _screenshot(
      '3_system_apps',
      home: AppsPage(deviceSerial: _device.serial),
      beforeScreenshot: (tester) async {
        await tester.tap(find.text('Show system apps'));
        await tester.pump();
        final state = tester.state<AppsPageState>(find.byType(AppsPage));
        await state.restrictedDataAppUids;
        await tester.pump();
        expect(stows.showSystemApps.value, isTrue);
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

    _screenshot(
      '99_no_adb',
      home: const ConnectPage(),
      setup: (device) {
        Adb.impl = null;
        ConnectPageContentNoAdb.debugInstallAdbCommandOverride =
            device.platform == .macOS
            ? 'brew install android-platform-tools'
            : device.platform == .linux
            ? 'sudo apt install adb'
            : null;
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
  FutureOr<void> Function(ScreenshotDevice device)? setup,
  Future<void> Function(WidgetTester tester)? beforeScreenshot,
}) {
  group(description, () {
    for (final goldenDevice in _testDevices) {
      testGoldens('for ${goldenDevice.name}', (tester) async {
        final device = goldenDevice.device;

        await setup?.call(device);

        await tester.pumpWidget(
          ScreenshotApp.withConditionalTitlebar(
            device: device,
            title: 'NoMoreBackground',
            theme: MyApp.createTheme(
              yaruDark.copyWith(platform: device.platform),
            ),
            home: home,
          ),
        );
        await tester.pump();

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
