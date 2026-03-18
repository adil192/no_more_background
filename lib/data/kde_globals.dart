import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ini/ini.dart';
import 'package:no_more_background/data/is_this_a_test.dart';
import 'package:yaru/yaru.dart';

abstract class KdeGlobals {
  static ThemeData applyTo(ThemeData base) {
    if (isThisATest) {
      if (base.platform != .linux) return base;
    } else {
      if (!Platform.isLinux) return base;
    }

    final kdeGlobals = KdeGlobals.kdeGlobals;
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
    if (bg == null || fg == null || seedColor == null) return base;
    final button = kdeGlobals.getColor('Colors:Button', 'BackgroundNormal');
    final onButton = kdeGlobals.getColor('Colors:Button', 'ForegroundNormal');
    final borderColor = Color.lerp(bg, fg, 0.2);

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
        outline: borderColor,
      ),
      dividerColor: borderColor,
      dividerTheme: base.dividerTheme.copyWith(color: borderColor),
    );

    return base;
  }

  @visibleForTesting
  static Config? kdeGlobals;

  /// Call this to re-read the `~/.config/kdeglobals` file.
  /// We expect the file to change when the user changes their theme.
  static void refresh() {
    debugPrint('Refreshing ${kdeGlobalsFile.path}');
    if (!kdeGlobalsFile.existsSync()) {
      kdeGlobals = null;
    } else {
      final lines = kdeGlobalsFile.readAsLinesSync();
      kdeGlobals = Config.fromStrings(lines);
    }
  }

  static final kdeGlobalsFile = () {
    late final home = Platform.environment['HOME'] ?? '~';
    final xdgConfigDir =
        Platform.environment['XDG_CONFIG_HOME'] ?? '$home/.config';
    return File('$xdgConfigDir/kdeglobals');
  }();
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
