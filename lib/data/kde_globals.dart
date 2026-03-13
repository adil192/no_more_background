import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ini/ini.dart';
import 'package:no_more_background/data/is_this_a_test.dart';
import 'package:yaru/yaru.dart';

abstract class KdeGlobals {
  static ThemeData applyTo(ThemeData base) {
    if (!Platform.isLinux) return base;
    if (isThisATest && debugConfigOverride == null) return base;

    final kdeGlobals = _read();
    if (kdeGlobals == null) return base;

    final bg =
        kdeGlobals.getColor('Colors:Window', 'BackgroundNormal') ??
        kdeGlobals.getColor('Colors:View', 'BackgroundNormal');
    final fg =
        kdeGlobals.getColor('Colors:View', 'ForegroundNormal') ??
        kdeGlobals.getColor('Colors:Window', 'ForegroundNormal');
    final seedColor =
        kdeGlobals.getColor('Colors:View', 'DecorationHover') ??
        kdeGlobals.getColor('Colors:Window', 'DecorationHover');
    final button = kdeGlobals.getColor('Colors:Button', 'BackgroundNormal');
    final onButton = kdeGlobals.getColor('Colors:Button', 'ForegroundNormal');
    if (bg == null || fg == null || seedColor == null) return base;

    final Brightness brightness = bg.computeLuminance() < 0.5 ? .dark : .light;
    base = switch (brightness) {
      .dark => createYaruDarkTheme(
        primaryColor: seedColor,
        lightBaseColor: fg,
        darkBaseColor: bg,
        elevatedButtonColor: button,
        elevatedButtonTextColor: onButton,
      ),
      .light => createYaruLightTheme(
        primaryColor: seedColor,
        lightBaseColor: bg,
        darkBaseColor: fg,
        elevatedButtonColor: button,
        elevatedButtonTextColor: onButton,
      ),
    };

    base = base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        inverseSurface:
            kdeGlobals.getColor('Colors:Complementary', 'BackgroundNormal') ??
            fg,
        onInverseSurface:
            kdeGlobals.getColor('Colors:Complementary', 'ForegroundNormal') ??
            bg,
      ),
    );

    return base;
  }

  @visibleForTesting
  static Config? debugConfigOverride;
  static Config? _read() {
    if (debugConfigOverride != null) return debugConfigOverride;
    final home = Platform.environment['HOME'] ?? '~';
    final kdeGlobalsFile = File('$home/.config/kdeglobals');
    debugPrint('Reading ${kdeGlobalsFile.path}');
    if (!kdeGlobalsFile.existsSync()) return null;
    final lines = kdeGlobalsFile.readAsLinesSync();
    return Config.fromStrings(lines);
  }
}

extension on Config {
  Color? getColor(String section, String key) {
    final rgb = get(section, key);
    final split = rgb?.split(',');
    if (split == null || split.length != 3) return null;
    final r = int.parse(split[0]);
    final g = int.parse(split[1]);
    final b = int.parse(split[2]);
    return Color.fromARGB(255, r, g, b);
  }
}
