///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsConnectEn connect = TranslationsConnectEn.internal(_root);
	late final TranslationsAppsEn apps = TranslationsAppsEn.internal(_root);
}

// Path: connect
class TranslationsConnectEn {
	TranslationsConnectEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsConnectHeaderEn header = TranslationsConnectHeaderEn.internal(_root);
	late final TranslationsConnectAdbEn adb = TranslationsConnectAdbEn.internal(_root);

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'About this app'
	String get about => 'About this app';

	/// en: 'About'
	String get aboutShortened => 'About';

	/// en: 'View privacy policy'
	String get viewPrivacyPolicy => 'View privacy policy';

	late final TranslationsConnectNoAdbEn noAdb = TranslationsConnectNoAdbEn.internal(_root);
	late final TranslationsConnectNoShizukuEn noShizuku = TranslationsConnectNoShizukuEn.internal(_root);
}

// Path: apps
class TranslationsAppsEn {
	TranslationsAppsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAppsFilterEn filter = TranslationsAppsFilterEn.internal(_root);
	late final TranslationsAppsTitleEn title = TranslationsAppsTitleEn.internal(_root);
	late final TranslationsAppsArchiveEn archive = TranslationsAppsArchiveEn.internal(_root);
	late final TranslationsAppsMenuEn menu = TranslationsAppsMenuEn.internal(_root);
	late final TranslationsAppsPermissionsEn permissions = TranslationsAppsPermissionsEn.internal(_root);
	late final TranslationsAppsReviewEn review = TranslationsAppsReviewEn.internal(_root);
}

// Path: connect.header
class TranslationsConnectHeaderEn {
	TranslationsConnectHeaderEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connect your device'
	String get title => 'Connect your device';

	/// en: '$n devices found'
	String subtitle({required Object n}) => '${n} devices found';
}

// Path: connect.adb
class TranslationsConnectAdbEn {
	TranslationsConnectAdbEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fake ADB'
	String get fake => 'Fake ADB';

	/// en: 'Real ADB'
	String get real => 'Real ADB';
}

// Path: connect.noAdb
class TranslationsConnectNoAdbEn {
	TranslationsConnectNoAdbEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'We can't find ADB on your system.'
	String get noAdbFound => 'We can\'t find ADB on your system.';

	/// en: 'ADB (Android Debug Bridge) is required to connect your Android™ device to this application.'
	String get adbIsRequired => 'ADB (Android Debug Bridge) is required to connect your Android™ device to this application.';

	late final TranslationsConnectNoAdbMethodsEn methods = TranslationsConnectNoAdbMethodsEn.internal(_root);
}

// Path: connect.noShizuku
class TranslationsConnectNoShizukuEn {
	TranslationsConnectNoShizukuEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'We can't connect to Shizuku.'
	String get noShizukuFound => 'We can\'t connect to Shizuku.';

	/// en: 'Shizuku is an open-source project that lets us control other apps without needing a computer or root access.'
	String get whatIsShizuku => 'Shizuku is an open-source project that lets us control other apps without needing a computer or root access.';

	/// en: 'Follow these steps to get started.'
	String get followTheseSteps => 'Follow these steps to get started.';

	late final TranslationsConnectNoShizukuStepsEn steps = TranslationsConnectNoShizukuStepsEn.internal(_root);
}

// Path: apps.filter
class TranslationsAppsFilterEn {
	TranslationsAppsFilterEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show system apps'
	String get showSystemApps => 'Show system apps';

	/// en: 'Show reviewed apps'
	String get showReviewedApps => 'Show reviewed apps';
}

// Path: apps.title
class TranslationsAppsTitleEn {
	TranslationsAppsTitleEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All apps'
	String get showSystemApps => 'All apps';

	/// en: 'User apps'
	String get hideSystemApps => 'User apps';
}

// Path: apps.archive
class TranslationsAppsArchiveEn {
	TranslationsAppsArchiveEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Archive'
	String get archive => 'Archive';

	/// en: 'Archived'
	String get archived => 'Archived';

	/// en: 'Request unarchive'
	String get unarchive => 'Request unarchive';

	/// en: 'Archiving not supported since app was installed by "$installer".'
	String notSupported({required Object installer}) => 'Archiving not supported since app was installed by "${installer}".';
}

// Path: apps.menu
class TranslationsAppsMenuEn {
	TranslationsAppsMenuEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy display name'
	String get copyDisplayName => 'Copy display name';

	/// en: 'Copy package name'
	String get copyPackageName => 'Copy package name';

	/// en: 'View on $installer'
	String viewOnInstaller({required Object installer}) => 'View on ${installer}';
}

// Path: apps.permissions
class TranslationsAppsPermissionsEn {
	TranslationsAppsPermissionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Run in bg'
	String get runInBackground => 'Run in bg';

	/// en: 'Bg data'
	String get backgroundData => 'Bg data';
}

// Path: apps.review
class TranslationsAppsReviewEn {
	TranslationsAppsReviewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reviewed'
	String get reviewed => 'Reviewed';

	/// en: 'Restore reviewed permissions'
	String get restore => 'Restore reviewed permissions';
}

// Path: connect.noAdb.methods
class TranslationsConnectNoAdbMethodsEn {
	TranslationsConnectNoAdbMethodsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'There are a few ways you can install ADB. After installing ADB, restart this application.'
	String get summary => 'There are a few ways you can install ADB. After installing ADB, restart this application.';

	late final TranslationsConnectNoAdbMethodsPackageManagerEn packageManager = TranslationsConnectNoAdbMethodsPackageManagerEn.internal(_root);
	late final TranslationsConnectNoAdbMethodsAndroidStudioEn androidStudio = TranslationsConnectNoAdbMethodsAndroidStudioEn.internal(_root);
	late final TranslationsConnectNoAdbMethodsStandaloneEn standalone = TranslationsConnectNoAdbMethodsStandaloneEn.internal(_root);
}

// Path: connect.noShizuku.steps
class TranslationsConnectNoShizukuStepsEn {
	TranslationsConnectNoShizukuStepsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsConnectNoShizukuStepsDownloadShizukuEn downloadShizuku = TranslationsConnectNoShizukuStepsDownloadShizukuEn.internal(_root);
	late final TranslationsConnectNoShizukuStepsSetupShizukuEn setupShizuku = TranslationsConnectNoShizukuStepsSetupShizukuEn.internal(_root);
	late final TranslationsConnectNoShizukuStepsAllowAccessEn allowAccess = TranslationsConnectNoShizukuStepsAllowAccessEn.internal(_root);
}

// Path: connect.noAdb.methods.packageManager
class TranslationsConnectNoAdbMethodsPackageManagerEn {
	TranslationsConnectNoAdbMethodsPackageManagerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Install ADB via package manager'
	String get title => 'Install ADB via package manager';

	/// en: 'You can install ADB using the following command in your terminal:'
	String get useFollowingCommand => 'You can install ADB using the following command in your terminal:';

	/// en: 'Then grant NoMoreBackground access to your system's adb:'
	String get grantFlatpakPermission => 'Then grant NoMoreBackground access to your system\'s adb:';
}

// Path: connect.noAdb.methods.androidStudio
class TranslationsConnectNoAdbMethodsAndroidStudioEn {
	TranslationsConnectNoAdbMethodsAndroidStudioEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Install ADB via Android Studio'
	String get title => 'Install ADB via Android Studio';

	/// en: 'If you have Android Studio, you can use its SDK manager to install the Android SDK Platform Tools package (which includes ADB).'
	String get installPlatformTools => 'If you have Android Studio, you can use its SDK manager to install the Android SDK Platform Tools package (which includes ADB).';
}

// Path: connect.noAdb.methods.standalone
class TranslationsConnectNoAdbMethodsStandaloneEn {
	TranslationsConnectNoAdbMethodsStandaloneEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Install ADB standalone'
	String get title => 'Install ADB standalone';

	/// en: 'You can download the standalone platform tools from the official Android developer website: $link.'
	TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'You can download the standalone platform tools from the official Android developer website: '),
		link,
		const TextSpan(text: '.'),
	]);

	/// en: 'After downloading, extract the archive and add the platform-tools directory to your system's PATH environment variable.'
	String get extractAndAddToPath => 'After downloading, extract the archive and add the platform-tools directory to your system\'s PATH environment variable.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	TranslationsConnectNoShizukuStepsDownloadShizukuEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Download Shizuku'
	String get title => 'Download Shizuku';

	/// en: 'Download Shizuku from Google Play or another official source.'
	String get description => 'Download Shizuku from Google Play or another official source.';

	/// en: 'Google Play'
	String get googlePlay => 'Google Play';

	/// en: 'Other sources'
	String get otherSources => 'Other sources';
}

// Path: connect.noShizuku.steps.setupShizuku
class TranslationsConnectNoShizukuStepsSetupShizukuEn {
	TranslationsConnectNoShizukuStepsSetupShizukuEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Set up Shizuku'
	String get title => 'Set up Shizuku';

	/// en: 'Set up Shizuku by following the instructions in the user manual.\nI recommend the "Start via wireless debugging" method.'
	String get description => 'Set up Shizuku by following the instructions in the user manual.\nI recommend the "Start via wireless debugging" method.';

	/// en: 'User manual'
	String get userManual => 'User manual';
}

// Path: connect.noShizuku.steps.allowAccess
class TranslationsConnectNoShizukuStepsAllowAccessEn {
	TranslationsConnectNoShizukuStepsAllowAccessEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Allow access'
	String get title => 'Allow access';

	/// en: 'Tap the button below and allow NoMoreBackground to access Shizuku when prompted.'
	String get description => 'Tap the button below and allow NoMoreBackground to access Shizuku when prompted.';

	/// en: 'Request access'
	String get requestAccess => 'Request access';
}
