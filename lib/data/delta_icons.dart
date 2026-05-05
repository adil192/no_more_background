import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class DeltaIcons {
  static final _packageToIconMap = <String, AssetImage>{};

  static Future<void> init() async {
    if (Platform.isAndroid) {
      return;
    }

    final appFilter = await rootBundle.loadString(
      'submodules/Delta-Icons/app/src/main/assets/appfilter.xml',
    );
    final lines = appFilter.split('\n');
    final regex = RegExp(
      r'<item component="ComponentInfo\{(.+?)/.+?\}" drawable="(.+?)" />',
    );
    for (final line in lines) {
      final match = regex.firstMatch(line);
      if (match == null) continue;
      final packageName = match.group(1)!;
      final drawableName = match.group(2)!;
      _packageToIconMap[packageName] = _getDeltaIcon(drawableName);
    }
  }

  static AssetImage? getIcon(String packageName) {
    final image = _packageToIconMap[packageName];
    return image;
  }

  static final defaultIcon = _getDeltaIcon('android');

  static AssetImage _getDeltaIcon(String drawableName) => AssetImage(
    'submodules/Delta-Icons/app/src/main/res/drawable-nodpi/$drawableName.png',
  );
}
