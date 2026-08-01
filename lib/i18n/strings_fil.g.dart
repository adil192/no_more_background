///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsFil extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFil({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fil,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <fil>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsFil _root = this; // ignore: unused_field

	@override 
	TranslationsFil $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFil(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$connect$fil connect = _Translations$connect$fil._(_root);
	@override late final _Translations$apps$fil apps = _Translations$apps$fil._(_root);
	@override late final _Translations$logs$fil logs = _Translations$logs$fil._(_root);
}

// Path: connect
class _Translations$connect$fil extends Translations$connect$en {
	_Translations$connect$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$header$fil header = _Translations$connect$header$fil._(_root);
	@override late final _Translations$connect$adb$fil adb = _Translations$connect$adb$fil._(_root);
	@override String get refresh => 'Isapanahon';
	@override String get about => 'Tungkol sa app';
	@override String get aboutShortened => 'Tungkol';
	@override String get viewPrivacyPolicy => 'Tingnan ang patakaran sa pagkapribado';
	@override late final _Translations$connect$noAdb$fil noAdb = _Translations$connect$noAdb$fil._(_root);
	@override late final _Translations$connect$noShizuku$fil noShizuku = _Translations$connect$noShizuku$fil._(_root);
	@override String get viewLogsShortened => 'Talaan';
	@override String get viewLogs => 'Tignan ang talaan';
}

// Path: apps
class _Translations$apps$fil extends Translations$apps$en {
	_Translations$apps$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$filter$fil filter = _Translations$apps$filter$fil._(_root);
	@override late final _Translations$apps$title$fil title = _Translations$apps$title$fil._(_root);
	@override late final _Translations$apps$archive$fil archive = _Translations$apps$archive$fil._(_root);
	@override late final _Translations$apps$menu$fil menu = _Translations$apps$menu$fil._(_root);
	@override late final _Translations$apps$permissions$fil permissions = _Translations$apps$permissions$fil._(_root);
	@override late final _Translations$apps$review$fil review = _Translations$apps$review$fil._(_root);
}

// Path: logs
class _Translations$logs$fil extends Translations$logs$en {
	_Translations$logs$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Talaan';
}

// Path: connect.header
class _Translations$connect$header$fil extends Translations$connect$header$en {
	_Translations$connect$header$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Konektahin ang iyong device';
	@override String subtitle({required Object n}) => '${n} na device ang nahanap';
}

// Path: connect.adb
class _Translations$connect$adb$fil extends Translations$connect$adb$en {
	_Translations$connect$adb$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get fake => 'Pekeng ADB';
	@override String get real => 'Totoong ADB';
}

// Path: connect.noAdb
class _Translations$connect$noAdb$fil extends Translations$connect$noAdb$en {
	_Translations$connect$noAdb$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'Hindi mahanap sa iyong sistema ang ADB.';
	@override String get adbIsRequired => 'ADB (Android Debug Bridge) ay mahalaga para konektahin ang iyong Android™ device sa app na ito.';
	@override late final _Translations$connect$noAdb$methods$fil methods = _Translations$connect$noAdb$methods$fil._(_root);
}

// Path: connect.noShizuku
class _Translations$connect$noShizuku$fil extends Translations$connect$noShizuku$en {
	_Translations$connect$noShizuku$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'Hindi makakonekta sa Shizuku.';
	@override String get whatIsShizuku => 'Ang Shizuku ay isang open-source o bukás-na-pinagmulang proyekto na nagbibigay-daan sa pagkontrola sa ibang mga app nang hindi nangangailangan ng kompyuter o root na akses.';
	@override String get followTheseSteps => 'Sundin itong mga hakbang para makapagsimula.';
	@override late final _Translations$connect$noShizuku$steps$fil steps = _Translations$connect$noShizuku$steps$fil._(_root);
	@override late final _Translations$connect$noShizuku$useRoot$fil useRoot = _Translations$connect$noShizuku$useRoot$fil._(_root);
}

// Path: apps.filter
class _Translations$apps$filter$fil extends Translations$apps$filter$en {
	_Translations$apps$filter$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Ipakita ang mga app sa sistema';
	@override String get showReviewedApps => 'Ipakita ang mga nasuring app';
}

// Path: apps.title
class _Translations$apps$title$fil extends Translations$apps$title$en {
	_Translations$apps$title$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get searchYourApps => 'Hanapin ang iyong mga app';
	@override String get yourApps => 'Iyong mga app';
}

// Path: apps.archive
class _Translations$apps$archive$fil extends Translations$apps$archive$en {
	_Translations$apps$archive$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Arkibo';
	@override String get archived => 'Arkibado';
	@override String get unarchive => 'Hilingin na di i-arkibo';
	@override String notSupported({required Object installer}) => 'Hindi suportado ang pag-arkibo dahil ang "${installer}" ang nag-install sa app.';
}

// Path: apps.menu
class _Translations$apps$menu$fil extends Translations$apps$menu$en {
	_Translations$apps$menu$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'Kopyahin ang nakadisplay na pangalan';
	@override String get copyPackageName => 'Kopyahin ang pangalan ng pakete';
	@override String get viewAppInfo => 'Tingnan ang impormasyon ng app';
	@override String get viewAppInfoDesktop => 'Tingnan ang impormasyon ng app (sa device)';
	@override String viewOnInstaller({required Object installer}) => 'Tingnan sa ${installer}';
	@override late final _Translations$apps$menu$runInBackground$fil runInBackground = _Translations$apps$menu$runInBackground$fil._(_root);
	@override late final _Translations$apps$menu$backgroundData$fil backgroundData = _Translations$apps$menu$backgroundData$fil._(_root);
}

// Path: apps.permissions
class _Translations$apps$permissions$fil extends Translations$apps$permissions$en {
	_Translations$apps$permissions$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Itakbo sa bg';
	@override String get backgroundData => 'Bg data';
	@override String get more => 'Higit pa';
}

// Path: apps.review
class _Translations$apps$review$fil extends Translations$apps$review$en {
	_Translations$apps$review$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Nasuri';
	@override String get restore => 'Ibalik ang mga nasuring permiso';
}

// Path: connect.noAdb.methods
class _Translations$connect$noAdb$methods$fil extends Translations$connect$noAdb$methods$en {
	_Translations$connect$noAdb$methods$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get summary => 'May ilang paraan upang ma-install ang ADB. Pagkatapos ma-install ang ADB, muling buksan ang aplikasyong ito.';
	@override late final _Translations$connect$noAdb$methods$packageManager$fil packageManager = _Translations$connect$noAdb$methods$packageManager$fil._(_root);
	@override late final _Translations$connect$noAdb$methods$androidStudio$fil androidStudio = _Translations$connect$noAdb$methods$androidStudio$fil._(_root);
	@override late final _Translations$connect$noAdb$methods$standalone$fil standalone = _Translations$connect$noAdb$methods$standalone$fil._(_root);
}

// Path: connect.noShizuku.steps
class _Translations$connect$noShizuku$steps$fil extends Translations$connect$noShizuku$steps$en {
	_Translations$connect$noShizuku$steps$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$downloadShizuku$fil downloadShizuku = _Translations$connect$noShizuku$steps$downloadShizuku$fil._(_root);
	@override late final _Translations$connect$noShizuku$steps$setupShizuku$fil setupShizuku = _Translations$connect$noShizuku$steps$setupShizuku$fil._(_root);
	@override late final _Translations$connect$noShizuku$steps$allowAccess$fil allowAccess = _Translations$connect$noShizuku$steps$allowAccess$fil._(_root);
}

// Path: connect.noShizuku.useRoot
class _Translations$connect$noShizuku$useRoot$fil extends Translations$connect$noShizuku$useRoot$en {
	_Translations$connect$noShizuku$useRoot$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Naka-root ka ba?';
	@override String get alternativeToShizuku => 'Hindi na kailangan ng mga naka-root na device ang Shizuku para ma-akses ang mga API ng sistema.';
	@override String get checkBoxToEnable => 'I-tsek ang kahon sa ibaba upang paganahin ang root, at pahintulutan kapag hiniling ito.';
	@override String get useRoot => 'Gamitin ang root';
	@override String get experimental => 'EKSPERIMENTAL';
}

// Path: apps.menu.runInBackground
class _Translations$apps$menu$runInBackground$fil extends Translations$apps$menu$runInBackground$en {
	_Translations$apps$menu$runInBackground$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get reduced => 'Bawasan ang aktibidad sa background';
	@override String get auto => 'Payagan ang mga default na aktibidad sa background';
	@override String get unrestricted => 'Payagan ang mga walang limitasyong aktibidad sa background';
	@override String get title => 'Mga karaniwang kontrol sa baterya ng Android';
	@override String get explanation => 'Maganda ang simula nito pero hindi pa lubos na epektibo.';
}

// Path: apps.menu.backgroundData
class _Translations$apps$menu$backgroundData$fil extends Translations$apps$menu$backgroundData$en {
	_Translations$apps$menu$backgroundData$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mga kontrol sa background data';
	@override String get explanation => 'Nakaapekto lamang ito sa paggamit ng mobile data sa background.\nHindi naaapektuhan ang Wi-Fi at foreground usage.';
	@override String get restricted => 'Payagan ang paggamit ng mobile data sa background';
}

// Path: connect.noAdb.methods.packageManager
class _Translations$connect$noAdb$methods$packageManager$fil extends Translations$connect$noAdb$methods$packageManager$en {
	_Translations$connect$noAdb$methods$packageManager$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-install ang ADB gamit ng package manager';
	@override String get useFollowingCommand => 'Maaari mong i-install ang ADB sa pamamagitan ng pagtakbo ng utos sa iyong terminal:';
	@override String get grantFlatpakPermission => 'Pagkatapos, pahintulutan ang NoMoreBackground na gamitin ang adb ng iyong sistema:';
}

// Path: connect.noAdb.methods.androidStudio
class _Translations$connect$noAdb$methods$androidStudio$fil extends Translations$connect$noAdb$methods$androidStudio$en {
	_Translations$connect$noAdb$methods$androidStudio$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-install ang ADB gamit ng Android Studio';
	@override String get installPlatformTools => 'Kung may Android Studio ka, maaari mong gamitin ang SDK manager nito para i-install ang Android SDK Platform Tools package (kasama na ang ADB).';
}

// Path: connect.noAdb.methods.standalone
class _Translations$connect$noAdb$methods$standalone$fil extends Translations$connect$noAdb$methods$standalone$en {
	_Translations$connect$noAdb$methods$standalone$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-install ang ADB nang mag-isa';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'Maaari mong i-download ang standalone platform tools mula sa opisyal na Android developer website: '),
		link,
		const TextSpan(text: '.'),
	]);
	@override String get extractAndAddToPath => 'Pagkatapos ma-download, i-extract ang arkibo at idagdag ang direktoryo ng platform-tools sa environment variable na PATH ng iyong sistema.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _Translations$connect$noShizuku$steps$downloadShizuku$fil extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	_Translations$connect$noShizuku$steps$downloadShizuku$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'I-download ang Shizuku';
	@override String get description => 'I-download ang Shizuku mula sa Google Play o iba pang opisyal na pinagmulan.';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => 'Iba pang pinagmulan';
}

// Path: connect.noShizuku.steps.setupShizuku
class _Translations$connect$noShizuku$steps$setupShizuku$fil extends Translations$connect$noShizuku$steps$setupShizuku$en {
	_Translations$connect$noShizuku$steps$setupShizuku$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ihanda ang Shizuku';
	@override String get description => 'Ihanda ang Shizuku sa pamamagitan ng pagsunod sa mga tagubilin sa manwal ng gumagamit.\nInirerekomenda ko ang paraang "Simulan sa pamamagitan ng wireless na pagde-debug".';
	@override String get userManual => 'Manwal ng gumagamit';
}

// Path: connect.noShizuku.steps.allowAccess
class _Translations$connect$noShizuku$steps$allowAccess$fil extends Translations$connect$noShizuku$steps$allowAccess$en {
	_Translations$connect$noShizuku$steps$allowAccess$fil._(TranslationsFil root) : this._root = root, super.internal(root);

	final TranslationsFil _root; // ignore: unused_field

	// Translations
	@override String get title => 'Payagan ang akses';
	@override String get description => 'Pindutin ang botón sa ibaba at payagan ang NoMoreBackground na gamitin ang Shizuku kapag hiniling ito.';
	@override String get requestAccess => 'Humiling ng akses';
}
