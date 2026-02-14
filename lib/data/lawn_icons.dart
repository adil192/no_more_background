import 'package:flutter/services.dart';

/// LawnIcons tells us the display names of apps from their package names.
/// We aren't actually using any icons from lawnicons.
abstract class LawnIcons {
  /// Maps the package name to its display name.
  ///
  /// This is prepopulated with some apps that aren't yet included in lawnicons.
  /// Also see [_displayNamesOverrides] which fixes some incorrect app names.
  ///
  /// Feel free to submit a PR to add more. Keep it alphabetical.
  static final _displayNames = <String, String>{
    'com.adilhanney.fan': 'Just Fan Noise',
    'com.adilhanney.ricochlime': 'Ricochlime',
    'com.adilhanney.timing': 'Timing Trainer',
    'com.fitbit.ecg': 'Fitbit ECG App',
    'com.google.android.contactkeys': 'Android System Key Verifier',
    'com.google.android.marvin.talkback': 'Android Accessibility Suite',
    'com.google.android.mosey': 'Quick Share extension',
    'com.google.android.wearable.assistant': 'Google Gemini on Wear OS',
    'com.google.android.wearable.healthservices': 'Health Services',
    'com.google.android.wearable.media.sessions': 'Wear Media',
    'com.google.android.wearable.pixel.pdms': 'Pixel Watch Management Service',
    'com.moving.movinglife': 'MovingLife',
    'com.MustBeFun.GamesInOneWatchGames': 'Games In One - Watch Games',
    'com.pg.grooming.braun.ipl': 'Braun IPL',
    'org.hanney.adil.nonogram': 'Nonogram',
  };
  static final _displayNamesOverrides = <String, String>{
    'com.android.shell': 'Shell', // was LSPosed
    'com.google.android.gms': 'Google Play services', // was microG Settings
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
    _displayNames.addAll(_displayNamesOverrides);
  }

  static String? getDisplayName(String packageName) =>
      _displayNames[packageName];
}
