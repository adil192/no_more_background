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
	late final Translations$connect$en connect = Translations$connect$en.internal(_root);
	late final Translations$apps$en apps = Translations$apps$en.internal(_root);
	late final Translations$logs$en logs = Translations$logs$en.internal(_root);
}

// Path: connect
class Translations$connect$en {
	Translations$connect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$connect$header$en header = Translations$connect$header$en.internal(_root);
	late final Translations$connect$adb$en adb = Translations$connect$adb$en.internal(_root);

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'About this app'
	String get about => 'About this app';

	/// en: 'About'
	String get aboutShortened => 'About';

	/// en: 'View privacy policy'
	String get viewPrivacyPolicy => 'View privacy policy';

	late final Translations$connect$noAdb$en noAdb = Translations$connect$noAdb$en.internal(_root);
	late final Translations$connect$noShizuku$en noShizuku = Translations$connect$noShizuku$en.internal(_root);

	/// en: 'Logs'
	String get viewLogsShortened => 'Logs';

	/// en: 'View logs'
	String get viewLogs => 'View logs';
}

// Path: apps
class Translations$apps$en {
	Translations$apps$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$apps$filter$en filter = Translations$apps$filter$en.internal(_root);
	late final Translations$apps$title$en title = Translations$apps$title$en.internal(_root);
	late final Translations$apps$archive$en archive = Translations$apps$archive$en.internal(_root);
	late final Translations$apps$menu$en menu = Translations$apps$menu$en.internal(_root);
	late final Translations$apps$permissions$en permissions = Translations$apps$permissions$en.internal(_root);
	late final Translations$apps$review$en review = Translations$apps$review$en.internal(_root);
}

// Path: logs
class Translations$logs$en {
	Translations$logs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Logs'
	String get title => 'Logs';
}

// Path: connect.header
class Translations$connect$header$en {
	Translations$connect$header$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connect your device'
	String get title => 'Connect your device';

	/// en: '$n devices found'
	String subtitle({required Object n}) => '${n} devices found';
}

// Path: connect.adb
class Translations$connect$adb$en {
	Translations$connect$adb$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fake ADB'
	String get fake => 'Fake ADB';

	/// en: 'Real ADB'
	String get real => 'Real ADB';
}

// Path: connect.noAdb
class Translations$connect$noAdb$en {
	Translations$connect$noAdb$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'We can't find ADB on your system.'
	String get noAdbFound => 'We can\'t find ADB on your system.';

	/// en: 'ADB (Android Debug Bridge) is required to connect your Android™ device to this application.'
	String get adbIsRequired => 'ADB (Android Debug Bridge) is required to connect your Android™ device to this application.';

	late final Translations$connect$noAdb$methods$en methods = Translations$connect$noAdb$methods$en.internal(_root);
}

// Path: connect.noShizuku
class Translations$connect$noShizuku$en {
	Translations$connect$noShizuku$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'We can't connect to Shizuku.'
	String get noShizukuFound => 'We can\'t connect to Shizuku.';

	/// en: 'Shizuku is an open-source project that lets us control other apps without needing a computer or root access.'
	String get whatIsShizuku => 'Shizuku is an open-source project that lets us control other apps without needing a computer or root access.';

	/// en: 'Follow these steps to get started.'
	String get followTheseSteps => 'Follow these steps to get started.';

	late final Translations$connect$noShizuku$steps$en steps = Translations$connect$noShizuku$steps$en.internal(_root);
	late final Translations$connect$noShizuku$useRoot$en useRoot = Translations$connect$noShizuku$useRoot$en.internal(_root);
}

// Path: apps.filter
class Translations$apps$filter$en {
	Translations$apps$filter$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show system apps'
	String get showSystemApps => 'Show system apps';

	/// en: 'Show reviewed apps'
	String get showReviewedApps => 'Show reviewed apps';
}

// Path: apps.title
class Translations$apps$title$en {
	Translations$apps$title$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search your apps'
	String get searchYourApps => 'Search your apps';

	/// en: 'Your apps'
	String get yourApps => 'Your apps';
}

// Path: apps.archive
class Translations$apps$archive$en {
	Translations$apps$archive$en.internal(this._root);

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
class Translations$apps$menu$en {
	Translations$apps$menu$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy display name'
	String get copyDisplayName => 'Copy display name';

	/// en: 'Copy package name'
	String get copyPackageName => 'Copy package name';

	/// en: 'View app info'
	String get viewAppInfo => 'View app info';

	/// en: 'View app info (on device)'
	String get viewAppInfoDesktop => 'View app info (on device)';

	/// en: 'View on $installer'
	String viewOnInstaller({required Object installer}) => 'View on ${installer}';

	late final Translations$apps$menu$background$en background = Translations$apps$menu$background$en.internal(_root);
}

// Path: apps.permissions
class Translations$apps$permissions$en {
	Translations$apps$permissions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Run in bg'
	String get runInBackground => 'Run in bg';

	/// en: 'Bg data'
	String get backgroundData => 'Bg data';

	/// en: 'More'
	String get more => 'More';
}

// Path: apps.review
class Translations$apps$review$en {
	Translations$apps$review$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reviewed'
	String get reviewed => 'Reviewed';

	/// en: 'Restore reviewed permissions'
	String get restore => 'Restore reviewed permissions';
}

// Path: connect.noAdb.methods
class Translations$connect$noAdb$methods$en {
	Translations$connect$noAdb$methods$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'There are a few ways you can install ADB. After installing ADB, restart this application.'
	String get summary => 'There are a few ways you can install ADB. After installing ADB, restart this application.';

	late final Translations$connect$noAdb$methods$packageManager$en packageManager = Translations$connect$noAdb$methods$packageManager$en.internal(_root);
	late final Translations$connect$noAdb$methods$androidStudio$en androidStudio = Translations$connect$noAdb$methods$androidStudio$en.internal(_root);
	late final Translations$connect$noAdb$methods$standalone$en standalone = Translations$connect$noAdb$methods$standalone$en.internal(_root);
}

// Path: connect.noShizuku.steps
class Translations$connect$noShizuku$steps$en {
	Translations$connect$noShizuku$steps$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$connect$noShizuku$steps$downloadShizuku$en downloadShizuku = Translations$connect$noShizuku$steps$downloadShizuku$en.internal(_root);
	late final Translations$connect$noShizuku$steps$setupShizuku$en setupShizuku = Translations$connect$noShizuku$steps$setupShizuku$en.internal(_root);
	late final Translations$connect$noShizuku$steps$allowAccess$en allowAccess = Translations$connect$noShizuku$steps$allowAccess$en.internal(_root);
}

// Path: connect.noShizuku.useRoot
class Translations$connect$noShizuku$useRoot$en {
	Translations$connect$noShizuku$useRoot$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Are you rooted?'
	String get areYouRooted => 'Are you rooted?';

	/// en: 'Rooted devices don't need Shizuku to access system APIs.'
	String get alternativeToShizuku => 'Rooted devices don\'t need Shizuku to access system APIs.';

	/// en: 'Tick the box below to enable root, and grant the permission when asked.'
	String get checkBoxToEnable => 'Tick the box below to enable root, and grant the permission when asked.';

	/// en: 'Use root'
	String get useRoot => 'Use root';

	/// en: 'EXPERIMENTAL'
	String get experimental => 'EXPERIMENTAL';
}

// Path: apps.menu.background
class Translations$apps$menu$background$en {
	Translations$apps$menu$background$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reduce background activity'
	String get reduced => 'Reduce background activity';

	/// en: 'Allow default background activity'
	String get auto => 'Allow default background activity';

	/// en: 'Allow unrestricted background activity'
	String get unrestricted => 'Allow unrestricted background activity';
}

// Path: connect.noAdb.methods.packageManager
class Translations$connect$noAdb$methods$packageManager$en {
	Translations$connect$noAdb$methods$packageManager$en.internal(this._root);

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
class Translations$connect$noAdb$methods$androidStudio$en {
	Translations$connect$noAdb$methods$androidStudio$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Install ADB via Android Studio'
	String get title => 'Install ADB via Android Studio';

	/// en: 'If you have Android Studio, you can use its SDK manager to install the Android SDK Platform Tools package (which includes ADB).'
	String get installPlatformTools => 'If you have Android Studio, you can use its SDK manager to install the Android SDK Platform Tools package (which includes ADB).';
}

// Path: connect.noAdb.methods.standalone
class Translations$connect$noAdb$methods$standalone$en {
	Translations$connect$noAdb$methods$standalone$en.internal(this._root);

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
class Translations$connect$noShizuku$steps$downloadShizuku$en {
	Translations$connect$noShizuku$steps$downloadShizuku$en.internal(this._root);

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
class Translations$connect$noShizuku$steps$setupShizuku$en {
	Translations$connect$noShizuku$steps$setupShizuku$en.internal(this._root);

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
class Translations$connect$noShizuku$steps$allowAccess$en {
	Translations$connect$noShizuku$steps$allowAccess$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Allow access'
	String get title => 'Allow access';

	/// en: 'Tap the button below and allow NoMoreBackground to access Shizuku when prompted.'
	String get description => 'Tap the button below and allow NoMoreBackground to access Shizuku when prompted.';

	/// en: 'Request access'
	String get requestAccess => 'Request access';
}
