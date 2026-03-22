import 'dart:io';

import 'package:dynamic_yaru/dynamic_yaru.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/delta_icons.dart';
import 'package:no_more_background/data/lawn_icons.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Adb.ensureInitialized(),
    LawnIcons.init(),
    DeltaIcons.init(),
    stows.reviewedAppsBySerial.waitUntilRead(),
  ]);
  _addLicenses();
  runApp(const MyApp());
}

void _addLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'no_more_background',
    ], await rootBundle.loadString('LICENSE.md'));
    yield LicenseEntryWithLineBreaks([
      'no_more_background',
    ], await rootBundle.loadString('assets/icon/LICENSE'));

    if (!Platform.isAndroid) {
      yield LicenseEntryWithLineBreaks([
        'Delta-Icons',
      ], await rootBundle.loadString('assets/Delta-Icons-License.txt'));
    }
    yield LicenseEntryWithLineBreaks([
      'lawnicons',
    ], await rootBundle.loadString('submodules/lawnicons/LICENSE'));
    yield LicenseEntryWithLineBreaks([
      'lineage_wiki',
    ], await rootBundle.loadString('submodules/lineage_wiki/licenses/LICENSE'));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _appKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, _) {
        return HookBuilder(
          builder: (context) {
            final brightness = MediaQuery.platformBrightnessOf(context);
            useMemoized(DynamicYaru.refresh, [brightness]);
            final theme = useMemoized(
              () => switch (brightness) {
                .dark => createTheme(yaru.darkTheme),
                .light => createTheme(yaru.theme),
              },
              [brightness, yaru.theme.colorScheme.primary],
            );

            return MaterialApp(
              key: _appKey,
              theme: theme,
              debugShowCheckedModeBanner: false,
              home: (Platform.isAndroid && Adb.impl != null)
                  ? const AppsPage(deviceSerial: 'localhost')
                  : const ConnectPage(),
            );
          },
        );
      },
    );
  }

  @visibleForTesting
  static ThemeData createTheme(ThemeData base) {
    base = DynamicYaru.getTheme() ?? base;

    final typography = Typography.material2021(
      platform: base.platform,
      colorScheme: base.colorScheme,
    );
    base = base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        // Remove bottom border of AppBar
        shape: const Border(),
        centerTitle: false,
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
        applyThemeToAll: true,
      ),
      textTheme: base.textTheme.copyWithFontFrom(
        base.brightness == .light ? typography.black : typography.white,
      ),
    );
    return base;
  }
}

extension on TextTheme {
  TextTheme copyWithFontFrom(TextTheme other) {
    return TextTheme(
      displayLarge: displayLarge?.copyWithFontFrom(other.displayLarge),
      displayMedium: displayMedium?.copyWithFontFrom(other.displayMedium),
      displaySmall: displaySmall?.copyWithFontFrom(other.displaySmall),
      headlineLarge: headlineLarge?.copyWithFontFrom(other.headlineLarge),
      headlineMedium: headlineMedium?.copyWithFontFrom(other.headlineMedium),
      headlineSmall: headlineSmall?.copyWithFontFrom(other.headlineSmall),
      titleLarge: titleLarge?.copyWithFontFrom(other.titleLarge),
      titleMedium: titleMedium?.copyWithFontFrom(other.titleMedium),
      titleSmall: titleSmall?.copyWithFontFrom(other.titleSmall),
      bodyLarge: bodyLarge?.copyWithFontFrom(other.bodyLarge),
      bodyMedium: bodyMedium?.copyWithFontFrom(other.bodyMedium),
      bodySmall: bodySmall?.copyWithFontFrom(other.bodySmall),
      labelLarge: labelLarge?.copyWithFontFrom(other.labelLarge),
      labelMedium: labelMedium?.copyWithFontFrom(other.labelMedium),
      labelSmall: labelSmall?.copyWithFontFrom(other.labelSmall),
    );
  }
}

extension on TextStyle {
  /// [TextStyle.copyWith] doesn't let us set [TextStyle._package] to null,
  /// so we need this extension method.
  TextStyle copyWithFontFrom(TextStyle? other) {
    return other?.copyWith(
          inherit: inherit,
          color: color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          textBaseline: textBaseline,
          locale: locale,
          foreground: foreground,
          background: background,
          shadows: shadows,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          overflow: overflow,
        ) ??
        this;
  }
}
