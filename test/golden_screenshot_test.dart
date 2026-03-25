import 'dart:async';
import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/foundation.dart';
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
import 'package:platform_linux/platform.dart';
import 'package:yaru/yaru.dart';

import 'utils/mock_channel_handlers.dart';

final _device = AdbDevice.fromAdbOutput(
  '0a388e93      device usb:1-1 product:razor model:Nexus_7 device:flo',
);
void main() {
  group('Screenshot:', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupMockYaruWindow();
    setUpAll(() async {
      await DeltaIcons.init();
      await LawnIcons.init();
    });
    setUp(() async {
      Adb.impl = FakeAdbImpl();
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
      excludeAndroid: true,
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
      mayShowMouse: true,
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
          state.permissionMap,
          isNotEmpty,
          reason: 'Permissions should be loaded ASAP',
        );
        expect(
          state.loadAbsentPermissionsLock,
          isFalse,
          reason: 'Lock should be released and permissions loaded',
        );
      },
    );

    _screenshot(
      '3_system_apps',
      home: AppsPage(deviceSerial: _device.serial),
      mayShowMouse: true,
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
          state.permissionMap,
          isNotEmpty,
          reason: 'Permissions should be loaded ASAP',
        );
        expect(
          state.loadAbsentPermissionsLock,
          isFalse,
          reason: 'Lock should be released and permissions loaded',
        );
      },
    );

    _screenshot(
      'no_adb',
      home: const ConnectPage(),
      forAppStores: false,
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
  GoldenScreenshotDevices.androidPhone,
  GoldenScreenshotDevices.androidTablet,
];

void _screenshot(
  String description, {
  required Widget home,
  FutureOr<void> Function(ScreenshotDevice device)? setup,
  Future<void> Function(WidgetTester tester)? beforeScreenshot,
  bool mayShowMouse = false,
  bool excludeAndroid = false,
  bool forAppStores = true,
}) {
  group(description, () {
    for (final goldenDevice in _testDevices) {
      if (excludeAndroid && goldenDevice.device.platform == .android) continue;
      testGoldens('for ${goldenDevice.name}', (tester) async {
        final device = goldenDevice.device;
        debugDefaultTargetPlatformOverride = device.platform;

        await setup?.call(device);
        final mousePosition = mayShowMouse ? _getMousePosition(device) : null;

        const yaruVariant = YaruVariant.adwaitaGreen;
        await tester.pumpWidget(
          YaruTheme(
            data: const YaruThemeData(variant: yaruVariant),
            platform: FakePlatform(
              operatingSystem: switch (device.platform) {
                .linux => Platform.linux,
                .macOS => Platform.macOS,
                .windows => Platform.windows,
                .android => Platform.android,
                .iOS => Platform.iOS,
                .fuchsia => Platform.fuchsia,
              },
              environment: io.Platform.environment,
            ),
            builder: (context, yaru, _) {
              return ScreenshotApp.withConditionalTitlebar(
                device: device,
                title: 'NoMoreBackground',
                theme: MyApp.isMobile
                    ? MyApp.createMaterialTheme(
                        ColorScheme.fromSeed(seedColor: yaruVariant.color),
                        device.platform,
                      )
                    : MyApp.createYaruTheme(
                        yaru.theme.copyWith(platform: device.platform),
                      ),
                home: Stack(
                  children: [
                    home,
                    if (mousePosition != null)
                      Positioned(
                        top: mousePosition.dy,
                        left: mousePosition.dx,
                        child: Image.memory(
                          File(
                            'test/assets/adwaita-cursor-default.png',
                          ).readAsBytesSync(),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
        await tester.pump();

        await beforeScreenshot?.call(tester);

        if (mousePosition != null) {
          final gesture = await tester.createGesture(kind: .mouse);
          await gesture.addPointer(
            location: mousePosition - const Offset(24, 24),
          );
          addTearDown(gesture.removePointer);
        }

        await tester.loadAssets();
        await tester.pumpFrames(
          tester.widget(find.byType(ScreenshotApp)),
          const Duration(seconds: 1),
        );
        ScreenshotDevice.screenshotsFolder = forAppStores
            ? '../metadata/\$langCode/images/'
            : '../test/screenshots/';
        await tester.expectScreenshot(device, description);

        debugDefaultTargetPlatformOverride = null;
      });
    }
  });
}

Offset? _getMousePosition(ScreenshotDevice device) {
  if (device.platform != .linux) return null;
  final size = device.resolution / device.pixelRatio;
  return Offset(size.width * 0.6, size.height * 0.55);
}
