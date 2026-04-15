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
class TranslationsZhHant extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhHant({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhHant,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <zh-Hant>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsZhHant _root = this; // ignore: unused_field

	@override 
	TranslationsZhHant $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhHant(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsConnectZhHant connect = _TranslationsConnectZhHant._(_root);
}

// Path: connect
class _TranslationsConnectZhHant extends TranslationsConnectEn {
	_TranslationsConnectZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectHeaderZhHant header = _TranslationsConnectHeaderZhHant._(_root);
	@override String get refresh => '重新整理';
	@override String get about => '關於此應用';
	@override String get aboutShortened => '關於';
	@override String get viewPrivacyPolicy => '瀏覽隱私政策';
	@override late final _TranslationsConnectNoAdbZhHant noAdb = _TranslationsConnectNoAdbZhHant._(_root);
	@override late final _TranslationsConnectNoShizukuZhHant noShizuku = _TranslationsConnectNoShizukuZhHant._(_root);
}

// Path: connect.header
class _TranslationsConnectHeaderZhHant extends TranslationsConnectHeaderEn {
	_TranslationsConnectHeaderZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '連線到您的裝置';
	@override String subtitle({required Object n}) => '已發現 ${n} 個裝置';
}

// Path: connect.noAdb
class _TranslationsConnectNoAdbZhHant extends TranslationsConnectNoAdbEn {
	_TranslationsConnectNoAdbZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => '我們未在您的系統內搜尋到ADB。';
	@override String get adbIsRequired => '需要用ADB (Android Debug Bridge)將Android™裝置連線到此應用。';
	@override late final _TranslationsConnectNoAdbMethodsZhHant methods = _TranslationsConnectNoAdbMethodsZhHant._(_root);
}

// Path: connect.noShizuku
class _TranslationsConnectNoShizukuZhHant extends TranslationsConnectNoShizukuEn {
	_TranslationsConnectNoShizukuZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => '我們未能連線到Shizuku。';
}

// Path: connect.noAdb.methods
class _TranslationsConnectNoAdbMethodsZhHant extends TranslationsConnectNoAdbMethodsEn {
	_TranslationsConnectNoAdbMethodsZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get summary => '有幾種方式可以安裝ADB。安裝完ADB後，請重啟此應用。';
	@override late final _TranslationsConnectNoAdbMethodsPackageManagerZhHant packageManager = _TranslationsConnectNoAdbMethodsPackageManagerZhHant._(_root);
	@override late final _TranslationsConnectNoAdbMethodsAndroidStudioZhHant androidStudio = _TranslationsConnectNoAdbMethodsAndroidStudioZhHant._(_root);
	@override late final _TranslationsConnectNoAdbMethodsStandaloneZhHant standalone = _TranslationsConnectNoAdbMethodsStandaloneZhHant._(_root);
}

// Path: connect.noAdb.methods.packageManager
class _TranslationsConnectNoAdbMethodsPackageManagerZhHant extends TranslationsConnectNoAdbMethodsPackageManagerEn {
	_TranslationsConnectNoAdbMethodsPackageManagerZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '透過包管理器安裝ADB';
	@override String get useFollowingCommand => '您可以在終端內透過以下命令安裝ADB：';
	@override String get grantFlatpakPermission => '然後，授予NoMoreBackground 訪問系統adb：';
}

// Path: connect.noAdb.methods.androidStudio
class _TranslationsConnectNoAdbMethodsAndroidStudioZhHant extends TranslationsConnectNoAdbMethodsAndroidStudioEn {
	_TranslationsConnectNoAdbMethodsAndroidStudioZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '透過Android Studio安裝ADB';
	@override String get installPlatformTools => '如果您有Android Studio，您可使用SDK manager 來安裝 Android SDK Platform Tools 包（該包包括了ADB）。';
}

// Path: connect.noAdb.methods.standalone
class _TranslationsConnectNoAdbMethodsStandaloneZhHant extends TranslationsConnectNoAdbMethodsStandaloneEn {
	_TranslationsConnectNoAdbMethodsStandaloneZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '單獨安裝ADB';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: '您可以透過官方 Android 開發者網站：'),
		link,
		const TextSpan(text: ' 下載單獨的platform-tools。'),
	]);
	@override String get extractAndAddToPath => '下載該檔案後，解壓該檔案並將platform-tools 目錄新增到您系統的PATH環境變數。';
}
