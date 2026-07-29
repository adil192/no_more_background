import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_screenshot/golden_screenshot.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:no_more_background/components/app_tile.dart';
import 'package:no_more_background/components/how_to_install_adb.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/compute/fake_adb_impl.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/delta_icons.dart';
import 'package:no_more_background/data/lawn_icons.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:no_more_background/data/workers.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:no_more_background/main.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:no_more_background/state/use_app_permissions.dart';
import 'package:yaru/yaru.dart';

import 'utils/mock_channel_handlers.dart';

final _device = AdbDevice.fromAdbOutput(
  'B05699QHA000B3     device usb:3-2 product:caiman model:Pixel_9_Pro device:caiman transport_id:9',
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
      for (final stow in [
        stows.reviewedAppsBySerial,
        stows.showSystemApps,
        stows.showReviewedApps,
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
      setup: (_) {
        permissionsCompleter = Completer.sync();
      },
      beforeScreenshot: (tester) async {
        await permissionsCompleter!.future;
        await tester.pump();
      },
    );

    _screenshot(
      '3_app_expanded',
      home: AppsPage(deviceSerial: _device.serial),
      setup: (_) {
        permissionsCompleter = Completer.sync();
      },
      beforeScreenshot: (tester) async {
        await permissionsCompleter!.future;
        await tester.pump();

        final moreButtonFinder = find.descendant(
          of: find.ancestor(
            of: find.text('DuckDuckGo'),
            matching: find.byType(AppTile),
          ),
          matching: find.byIcon(Symbols.tune),
        );
        await tester.tap(moreButtonFinder);
        await tester.pump();
      },
    );

    _screenshot(
      '4_system_apps',
      home: AppsPage(deviceSerial: _device.serial),
      mayShowMouse: true,
      setup: (_) {
        permissionsCompleter = Completer.sync();
      },
      beforeScreenshot: (tester) async {
        await tester.tap(find.text(t.apps.filter.showSystemApps));
        await tester.pump();
        await permissionsCompleter!.future;
        await tester.pump();
        expect(stows.showSystemApps.value, isTrue);
      },
    );

    _screenshot(
      'no_adb',
      home: const ConnectPage(),
      forAppStores: false,
      setup: (device) {
        Adb.impl = null;
        HowToInstallAdb.debugInstallAdbCommandOverride =
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
      group('for ${goldenDevice.name}', () {
        final device = goldenDevice.device;

        const localesWithFontIssues = <AppLocale>{.zhHans, .zhHant};
        const localesWithAppleFontIssues = <AppLocale>{.ar};
        for (final locale in forAppStores ? AppLocale.values : [AppLocale.en]) {
          if (localesWithFontIssues.contains(locale)) continue;
          if ((device.platform == .iOS || device.platform == .macOS) &&
              localesWithAppleFontIssues.contains(locale)) {
            continue;
          }
          testGoldens('in ${locale.name}', (tester) async {
            debugDefaultTargetPlatformOverride = device.platform;
            await tester.runAsync(() => LocaleSettings.setLocale(locale));

            await setup?.call(device);
            final mousePosition = mayShowMouse
                ? _getMousePosition(device)
                : null;

            const yaruVariant = YaruVariant.adwaitaGreen;
            late final yaruTheme = createYaruLightTheme(
              primaryColor: yaruVariant.color,
              fontFamily: 'Roboto',
            );
            await tester.pumpWidget(
              TranslationProvider(
                child: ScreenshotApp.withConditionalTitlebar(
                  device: device,
                  title: 'NoMoreBackground',
                  locale: locale.flutterLocale,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  localizationsDelegates: GlobalMaterialLocalizations.delegates,
                  theme: device.platform == .android
                      ? MyApp.createMaterialTheme(
                          ColorScheme.fromSeed(seedColor: yaruVariant.color),
                          device.platform,
                        )
                      : MyApp.createYaruTheme(
                          yaruTheme.copyWith(platform: device.platform),
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
                ),
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
            await tester.pumpAndSettle();
            ScreenshotDevice.screenshotsFolder = forAppStores
                ? '../metadata/\$langCode/images/'
                : '../test/screenshots/';
            await tester.expectScreenshot(
              device,
              description,
              langCode: locale == AppLocale.en ? 'en-US' : locale.languageTag,
            );

            debugDefaultTargetPlatformOverride = null;
          });
        }
      });
    }
  });
}

Offset? _getMousePosition(ScreenshotDevice device) {
  if (device.platform != .linux) return null;
  final size = device.resolution / device.pixelRatio;
  return Offset(size.width * 0.6, size.height * 0.55);
}
