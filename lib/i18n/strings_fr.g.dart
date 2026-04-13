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
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsConnectFr connect = _TranslationsConnectFr._(_root);
}

// Path: connect
class _TranslationsConnectFr extends TranslationsConnectEn {
	_TranslationsConnectFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectHeaderFr header = _TranslationsConnectHeaderFr._(_root);
	@override late final _TranslationsConnectAdbFr adb = _TranslationsConnectAdbFr._(_root);
	@override String get refresh => 'Actualiser';
	@override String get about => 'À propos de l\'app';
	@override String get aboutShortened => 'À propos';
	@override String get viewPrivacyPolicy => 'Voir politique de confidentialité';
	@override late final _TranslationsConnectNoAdbFr noAdb = _TranslationsConnectNoAdbFr._(_root);
	@override late final _TranslationsConnectNoShizukuFr noShizuku = _TranslationsConnectNoShizukuFr._(_root);
}

// Path: connect.header
class _TranslationsConnectHeaderFr extends TranslationsConnectHeaderEn {
	_TranslationsConnectHeaderFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Connectez votre appareil';
	@override String subtitle({required Object n}) => '${n} appareils trouvés';
}

// Path: connect.adb
class _TranslationsConnectAdbFr extends TranslationsConnectAdbEn {
	_TranslationsConnectAdbFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get fake => 'ADB simulé';
	@override String get real => 'ADB réel';
}

// Path: connect.noAdb
class _TranslationsConnectNoAdbFr extends TranslationsConnectNoAdbEn {
	_TranslationsConnectNoAdbFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'Nous n\'avons pas trouvé ADB sur votre système.';
	@override String get adbIsRequired => 'ADB (Android Debug Bridge) est requis pour connecter votre appareil Android™ à cette application.';
	@override late final _TranslationsConnectNoAdbMethodsFr methods = _TranslationsConnectNoAdbMethodsFr._(_root);
}

// Path: connect.noShizuku
class _TranslationsConnectNoShizukuFr extends TranslationsConnectNoShizukuEn {
	_TranslationsConnectNoShizukuFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectNoShizukuStepsFr steps = _TranslationsConnectNoShizukuStepsFr._(_root);
	@override late final _TranslationsConnectNoShizukuUseRootFr useRoot = _TranslationsConnectNoShizukuUseRootFr._(_root);
}

// Path: connect.noAdb.methods
class _TranslationsConnectNoAdbMethodsFr extends TranslationsConnectNoAdbMethodsEn {
	_TranslationsConnectNoAdbMethodsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Il existe plusieurs façons d\'installer ADB. Après l\'installation d\'ADB, redémarrez cette application.';
	@override late final _TranslationsConnectNoAdbMethodsPackageManagerFr packageManager = _TranslationsConnectNoAdbMethodsPackageManagerFr._(_root);
	@override late final _TranslationsConnectNoAdbMethodsAndroidStudioFr androidStudio = _TranslationsConnectNoAdbMethodsAndroidStudioFr._(_root);
	@override late final _TranslationsConnectNoAdbMethodsStandaloneFr standalone = _TranslationsConnectNoAdbMethodsStandaloneFr._(_root);
}

// Path: connect.noShizuku.steps
class _TranslationsConnectNoShizukuStepsFr extends TranslationsConnectNoShizukuStepsEn {
	_TranslationsConnectNoShizukuStepsFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectNoShizukuStepsDownloadShizukuFr downloadShizuku = _TranslationsConnectNoShizukuStepsDownloadShizukuFr._(_root);
}

// Path: connect.noShizuku.useRoot
class _TranslationsConnectNoShizukuUseRootFr extends TranslationsConnectNoShizukuUseRootEn {
	_TranslationsConnectNoShizukuUseRootFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Es-tu rooté?';
}

// Path: connect.noAdb.methods.packageManager
class _TranslationsConnectNoAdbMethodsPackageManagerFr extends TranslationsConnectNoAdbMethodsPackageManagerEn {
	_TranslationsConnectNoAdbMethodsPackageManagerFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Installer ADB via le gestionnaire de paquets';
	@override String get useFollowingCommand => 'Vous pouvait installer ADB avec les commandes suivants dans votre terminal :';
	@override String get grantFlatpakPermission => 'Puis authoriser NoMoreBackground l\'access à votre systeme ADB :';
}

// Path: connect.noAdb.methods.androidStudio
class _TranslationsConnectNoAdbMethodsAndroidStudioFr extends TranslationsConnectNoAdbMethodsAndroidStudioEn {
	_TranslationsConnectNoAdbMethodsAndroidStudioFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Installer ADB via Android Studio';
	@override String get installPlatformTools => 'Si vous avait Android Studio, vous pouvait utiliser le SDK manager pour installer le Android SDK Platform Tools package (qui inclus ADB).';
}

// Path: connect.noAdb.methods.standalone
class _TranslationsConnectNoAdbMethodsStandaloneFr extends TranslationsConnectNoAdbMethodsStandaloneEn {
	_TranslationsConnectNoAdbMethodsStandaloneFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Installer ADB standalone';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'Vous pouvez télécharger les platform tools standalone depuis le site officiel d\'Android Developer: '),
		link,
		const TextSpan(text: '.'),
	]);
}

// Path: connect.noShizuku.steps.downloadShizuku
class _TranslationsConnectNoShizukuStepsDownloadShizukuFr extends TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	_TranslationsConnectNoShizukuStepsDownloadShizukuFr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Télécharger Shizuku';
	@override String get otherSources => 'Autres sources';
}
