import 'package:flutter/services.dart';

/// LawnIcons tells us the display names of apps from their package names.
/// We aren't actually using any icons from lawnicons.
abstract class LawnIcons {
  /// Maps the package name to its display name.
  static final _displayNames = <String, String>{
    // Some apps that aren't in lawnicons.
    // Feel free to submit a PR to add more.
    'com.adilhanney.fan': 'Just Fan Noise',
    'com.adilhanney.ricochlime': 'Ricochlime',
    'com.adilhanney.timing': 'Timing Trainer',
    'com.google.android.contactkeys': 'Android System Key Verifier',
    'com.google.android.mosey': 'Quick Share extension',
    'com.moving.movinglife': 'MovingLife',
    'com.pg.grooming.braun.ipl': 'Braun IPL',
    'org.hanney.adil.nonogram': 'Nonogram',
  };

  static Future<void> init() async {
    final appFilter = await rootBundle.loadString(
      'submodules/lawnicons/app/assets/appfilter.xml',
    );
    final lines = appFilter.split('\n');
    // E.g. <item component="ComponentInfo{com.adilhanney.saber/com.adilhanney.saber.MainActivity}" drawable="saber" name="Saber" />
    final regex = RegExp(
      r'<item [^<>]*component="ComponentInfo[\{\(](.+?)\/.+?[\)\}]" drawable=".+?" name="(.+?)" \/>',
    );
    for (final line in lines) {
      final match = regex.firstMatch(line);
      if (match == null) continue;
      final packageName = match.group(1)!;
      final displayName = match.group(2)!;
      _displayNames[packageName] = displayName;
    }
  }

  static String? getDisplayName(String packageName) =>
      _displayNames[packageName];
}
