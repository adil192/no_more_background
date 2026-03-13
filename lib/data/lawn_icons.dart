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
    'com.adilhanney.no_more_background': 'NoMoreBackground',
    'com.adilhanney.ricochlime': 'Ricochlime',
    'com.adilhanney.timing': 'Timing Trainer',
    'com.bushub.transdev': 'Transdev Go',
    'com.fitbit.ecg': 'Fitbit ECG App',
    'com.google.ambient.streaming': 'Cross-Device Services',
    'com.google.android.accessibility.switchaccess': 'Switch Access',
    'com.google.android.aicore': 'Android AICore',
    'com.google.android.apps.aiwallpapers': 'AI Wallpapers',
    'com.google.android.apps.camera.services': 'Pixel Camera services',
    'com.google.android.apps.carrier.carrierwifi': 'Google Wi-Fi Provisioner',
    'com.google.android.apps.dreamliner': 'Pixel Stand',
    'com.google.android.apps.emojiwallpaper': 'Emoji Workshop Wallpaper',
    'com.google.android.apps.pixel.customizationbundle': 'Theme packs',
    'com.google.android.apps.pixel.dcservice': 'Device Connectivity Service',
    'com.google.android.apps.pixel.relationships': 'Pixel VIPs',
    'com.google.android.apps.pixel.support': 'Pixel Troubleshooting',
    'com.google.android.apps.privacy.wildlife': 'VPN by Google',
    'com.google.android.apps.restore': 'Android Switch',
    'com.google.android.apps.scone': 'Adaptive Connectivity Services',
    'com.google.android.apps.stargate': 'Satellite Gateway',
    'com.google.android.apps.turbo': 'Device Health Services',
    'com.google.android.as': 'Android System Intelligence',
    'com.google.android.as.oss': 'Private Compute Services',
    'com.google.android.contactkeys': 'Android System Key Verifier',
    'com.google.android.euicc': 'SIM Manager',
    'com.google.android.marvin.talkback': 'Android Accessibility Suite',
    'com.google.android.mosey': 'Quick Share extension',
    'com.google.android.odad': 'Google Play Protect Service',
    'com.google.android.partnersetup': 'Google Partner Setup',
    'com.google.android.settings.intelligence': 'Settings services',
    'com.google.android.soundpicker': 'Sounds',
    'com.google.android.wearable.assistant': 'Google Gemini on Wear OS',
    'com.google.android.wearable.healthservices': 'Health Services',
    'com.google.android.wearable.media.sessions': 'Wear Media',
    'com.google.android.wearable.pixel.pdms': 'Pixel Watch Management Service',
    'com.google.ar.core': 'Google Play Services for AR',
    'com.google.assistant.hubui': 'Dreams',
    'com.hermes.hercules': 'Evri',
    'com.iogame.gearworld': 'Gear Defenders',
    'com.morrisons.matchandmore.app': 'Morrisons More',
    'com.moving.movinglife': 'MovingLife',
    'com.MustBeFun.GamesInOneWatchGames': 'Games In One - Watch Games',
    'com.pg.grooming.braun.ipl': 'Braun IPL',
    'com.stagecoach.stagecoachbus': 'Stagecoach Bus',
    'com.tfgm.beenetwork': 'Bee Network',
    'nandos.android.app': 'Nando\'s UK',
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
