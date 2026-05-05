
part of 'strings.g.dart';

typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	late final TranslationsConnectEn connect = TranslationsConnectEn.internal(_root);
	late final TranslationsAppsEn apps = TranslationsAppsEn.internal(_root);
	late final TranslationsLogsEn logs = TranslationsLogsEn.internal(_root);
}

class TranslationsConnectEn {
	TranslationsConnectEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsConnectHeaderEn header = TranslationsConnectHeaderEn.internal(_root);
	late final TranslationsConnectAdbEn adb = TranslationsConnectAdbEn.internal(_root);

	String get refresh => 'Refresh';

	String get about => 'About this app';

	String get aboutShortened => 'About';

	String get viewPrivacyPolicy => 'View privacy policy';

	late final TranslationsConnectNoAdbEn noAdb = TranslationsConnectNoAdbEn.internal(_root);
	late final TranslationsConnectNoShizukuEn noShizuku = TranslationsConnectNoShizukuEn.internal(_root);

	String get viewLogsShortened => 'Logs';

	String get viewLogs => 'View logs';
}

class TranslationsAppsEn {
	TranslationsAppsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsAppsFilterEn filter = TranslationsAppsFilterEn.internal(_root);
	late final TranslationsAppsTitleEn title = TranslationsAppsTitleEn.internal(_root);
	late final TranslationsAppsArchiveEn archive = TranslationsAppsArchiveEn.internal(_root);
	late final TranslationsAppsMenuEn menu = TranslationsAppsMenuEn.internal(_root);
	late final TranslationsAppsPermissionsEn permissions = TranslationsAppsPermissionsEn.internal(_root);
	late final TranslationsAppsReviewEn review = TranslationsAppsReviewEn.internal(_root);
}

class TranslationsLogsEn {
	TranslationsLogsEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Logs';
}

class TranslationsConnectHeaderEn {
	TranslationsConnectHeaderEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Connect your device';

	String subtitle({required Object n}) => '${n} devices found';
}

class TranslationsConnectAdbEn {
	TranslationsConnectAdbEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get fake => 'Fake ADB';

	String get real => 'Real ADB';
}

class TranslationsConnectNoAdbEn {
	TranslationsConnectNoAdbEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get noAdbFound => 'We can\'t find ADB on your system.';

	String get adbIsRequired => 'ADB (Android Debug Bridge) is required to connect your Android™ device to this application.';

	late final TranslationsConnectNoAdbMethodsEn methods = TranslationsConnectNoAdbMethodsEn.internal(_root);
}

class TranslationsConnectNoShizukuEn {
	TranslationsConnectNoShizukuEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get noShizukuFound => 'We can\'t connect to Shizuku.';

	String get whatIsShizuku => 'Shizuku is an open-source project that lets us control other apps without needing a computer or root access.';

	String get followTheseSteps => 'Follow these steps to get started.';

	late final TranslationsConnectNoShizukuStepsEn steps = TranslationsConnectNoShizukuStepsEn.internal(_root);
	late final TranslationsConnectNoShizukuUseRootEn useRoot = TranslationsConnectNoShizukuUseRootEn.internal(_root);
}

class TranslationsAppsFilterEn {
	TranslationsAppsFilterEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get showSystemApps => 'Show system apps';

	String get showReviewedApps => 'Show reviewed apps';
}

class TranslationsAppsTitleEn {
	TranslationsAppsTitleEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get showSystemApps => 'All apps';

	String get hideSystemApps => 'User apps';
}

class TranslationsAppsArchiveEn {
	TranslationsAppsArchiveEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get archive => 'Archive';

	String get archived => 'Archived';

	String get unarchive => 'Request unarchive';

	String notSupported({required Object installer}) => 'Archiving not supported since app was installed by "${installer}".';
}

class TranslationsAppsMenuEn {
	TranslationsAppsMenuEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get copyDisplayName => 'Copy display name';

	String get copyPackageName => 'Copy package name';

	String viewOnInstaller({required Object installer}) => 'View on ${installer}';
}

class TranslationsAppsPermissionsEn {
	TranslationsAppsPermissionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get runInBackground => 'Run in bg';

	String get backgroundData => 'Bg data';
}

class TranslationsAppsReviewEn {
	TranslationsAppsReviewEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get reviewed => 'Reviewed';

	String get restore => 'Restore reviewed permissions';
}

class TranslationsConnectNoAdbMethodsEn {
	TranslationsConnectNoAdbMethodsEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get summary => 'There are a few ways you can install ADB. After installing ADB, restart this application.';

	late final TranslationsConnectNoAdbMethodsPackageManagerEn packageManager = TranslationsConnectNoAdbMethodsPackageManagerEn.internal(_root);
	late final TranslationsConnectNoAdbMethodsAndroidStudioEn androidStudio = TranslationsConnectNoAdbMethodsAndroidStudioEn.internal(_root);
	late final TranslationsConnectNoAdbMethodsStandaloneEn standalone = TranslationsConnectNoAdbMethodsStandaloneEn.internal(_root);
}

class TranslationsConnectNoShizukuStepsEn {
	TranslationsConnectNoShizukuStepsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsConnectNoShizukuStepsDownloadShizukuEn downloadShizuku = TranslationsConnectNoShizukuStepsDownloadShizukuEn.internal(_root);
	late final TranslationsConnectNoShizukuStepsSetupShizukuEn setupShizuku = TranslationsConnectNoShizukuStepsSetupShizukuEn.internal(_root);
	late final TranslationsConnectNoShizukuStepsAllowAccessEn allowAccess = TranslationsConnectNoShizukuStepsAllowAccessEn.internal(_root);
}

class TranslationsConnectNoShizukuUseRootEn {
	TranslationsConnectNoShizukuUseRootEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get areYouRooted => 'Are you rooted?';

	String get alternativeToShizuku => 'Rooted devices don\'t need Shizuku to access system APIs.';

	String get checkBoxToEnable => 'Tick the box below to enable root, and grant the permission when asked.';

	String get useRoot => 'Use root';

	String get experimental => 'EXPERIMENTAL';
}

class TranslationsConnectNoAdbMethodsPackageManagerEn {
	TranslationsConnectNoAdbMethodsPackageManagerEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Install ADB via package manager';

	String get useFollowingCommand => 'You can install ADB using the following command in your terminal:';

	String get grantFlatpakPermission => 'Then grant NoMoreBackground access to your system\'s adb:';
}

class TranslationsConnectNoAdbMethodsAndroidStudioEn {
	TranslationsConnectNoAdbMethodsAndroidStudioEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Install ADB via Android Studio';

	String get installPlatformTools => 'If you have Android Studio, you can use its SDK manager to install the Android SDK Platform Tools package (which includes ADB).';
}

class TranslationsConnectNoAdbMethodsStandaloneEn {
	TranslationsConnectNoAdbMethodsStandaloneEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Install ADB standalone';

	TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'You can download the standalone platform tools from the official Android developer website: '),
		link,
		const TextSpan(text: '.'),
	]);

	String get extractAndAddToPath => 'After downloading, extract the archive and add the platform-tools directory to your system\'s PATH environment variable.';
}

class TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	TranslationsConnectNoShizukuStepsDownloadShizukuEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Download Shizuku';

	String get description => 'Download Shizuku from Google Play or another official source.';

	String get googlePlay => 'Google Play';

	String get otherSources => 'Other sources';
}

class TranslationsConnectNoShizukuStepsSetupShizukuEn {
	TranslationsConnectNoShizukuStepsSetupShizukuEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Set up Shizuku';

	String get description => 'Set up Shizuku by following the instructions in the user manual.\nI recommend the "Start via wireless debugging" method.';

	String get userManual => 'User manual';
}

class TranslationsConnectNoShizukuStepsAllowAccessEn {
	TranslationsConnectNoShizukuStepsAllowAccessEn.internal(this._root);

	final Translations _root; // ignore: unused_field


	String get title => 'Allow access';

	String get description => 'Tap the button below and allow NoMoreBackground to access Shizuku when prompted.';

	String get requestAccess => 'Request access';
}
