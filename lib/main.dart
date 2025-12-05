import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/icon_pack.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([Adb.ensureInitialized(), IconPack.init()]);
  _addLicenses();
  runApp(const MyApp());
}

void _addLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'Delta-Icons',
    ], await rootBundle.loadString('assets/Delta-Icons-License.txt'));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _appKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, _) {
        return MaterialApp(
          key: _appKey,
          theme: createTheme(yaru.theme ?? yaruLight),
          darkTheme: createTheme(yaru.darkTheme ?? yaruDark),
          debugShowCheckedModeBanner: false,
          home: const ConnectPage(),
        );
      },
    );
  }

  @visibleForTesting
  static ThemeData createTheme(ThemeData base) {
    if (base.platform != .iOS && base.platform != .macOS) return base;

    final typography = Typography.material2021(
      platform: base.platform,
      colorScheme: base.colorScheme,
    );
    return base.copyWith(
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
        applyThemeToAll: true,
      ),
      textTheme: base.textTheme.copyWithFontFrom(
        base.brightness == .light ? typography.black : typography.white,
      ),
    );
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
