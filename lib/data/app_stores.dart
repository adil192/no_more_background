import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:no_more_background/data/delta_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStore {
  static final stores = {
    "com.android.vending": AppStore._(
      displayName: "Play Store",
      iconImage: DeltaIcons.getIcon("com.android.vending")!,
      iconData: null,
      showAppListing: (packageName) {
        launchUrl(
          Uri.parse(
            'https://play.google.com/store/apps/details?id=$packageName',
          ),
        );
      },
    ),
    "org.fdroid.fdroid": AppStore._(
      displayName: "F-Droid",
      iconImage: DeltaIcons.getIcon("org.fdroid.fdroid")!,
      iconData: null,
      showAppListing: (packageName) {
        launchUrl(Uri.parse('https://f-droid.org/packages/$packageName'));
      },
    ),
    "com.google.android.packageinstaller": AppStore._(
      displayName: 'APK',
      iconImage: null,
      iconData: Symbols.apk_document,
      showAppListing: null,
    ),
  };

  const AppStore._({
    required this.displayName,
    required this.iconImage,
    required this.iconData,
    required this.showAppListing,
  }) : assert(iconImage != null || iconData != null);

  final String displayName;
  final AssetImage? iconImage;
  final IconData? iconData;
  final void Function(String packageName)? showAppListing;
}
