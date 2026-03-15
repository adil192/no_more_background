import 'package:url_launcher/url_launcher.dart';

class AppStore {
  static final stores = {
    "com.android.vending": AppStore._(
      displayName: "Play Store",
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
      showAppListing: (packageName) {
        launchUrl(Uri.parse('https://f-droid.org/packages/$packageName'));
      },
    ),
  };

  const AppStore._({required this.displayName, required this.showAppListing});

  final String displayName;
  final void Function(String packageName) showAppListing;
}
