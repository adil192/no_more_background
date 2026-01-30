import 'package:flutter/rendering.dart';
import 'package:no_more_background/data/delta_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStore {
  static final stores = {
    "com.android.vending": AppStore._(
      displayName: "Play Store",
      icon: DeltaIcons.getIcon("com.android.vending")!,
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
      icon: DeltaIcons.getIcon("org.fdroid.fdroid")!,
      showAppListing: (packageName) {
        launchUrl(Uri.parse('https://f-droid.org/packages/$packageName'));
      },
    ),
  };

  const AppStore._({
    required this.displayName,
    required this.icon,
    required this.showAppListing,
  });

  final String displayName;
  final AssetImage icon;
  final void Function(String packageName) showAppListing;
}
