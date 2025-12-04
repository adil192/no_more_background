import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class IconPack {
  /// Maps the package name to the drawable name.
  static final iconDrawables = <String, String>{};

  static Future<void> init() async {
    final appFilter = await rootBundle.loadString(
      'submodules/Delta-Icons/app/src/main/assets/appfilter.xml',
    );
    final lines = appFilter.split('\n');
    // E.g. <item component="ComponentInfo{com.adilhanney.saber/com.adilhanney.saber.MainActivity}" drawable="saber" />
    final regex = RegExp(
      r'<item component="ComponentInfo\{(.+?)/.+?\}" drawable="(.+?)" />',
    );
    for (final line in lines) {
      final match = regex.firstMatch(line);
      if (match == null) continue;
      final packageName = match.group(1)!;
      final drawableName = match.group(2)!;
      iconDrawables[packageName] = drawableName;
    }
  }

  static ImageProvider? getIcon(String packageName) {
    final drawableName = iconDrawables[packageName];
    if (drawableName == null) return null;
    return _getDrawable(drawableName);
  }

  static final defaultIcon = _getDrawable('android');

  static ImageProvider _getDrawable(String drawableName) => AssetImage(
    'submodules/Delta-Icons/app/src/main/res/drawable-nodpi/$drawableName.png',
  );
}
