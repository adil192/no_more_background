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
	@override late final _Translations$connect$fr connect = _Translations$connect$fr._(_root);
	@override late final _Translations$apps$fr apps = _Translations$apps$fr._(_root);
	@override late final _Translations$logs$fr logs = _Translations$logs$fr._(_root);
}

// Path: connect
class _Translations$connect$fr extends Translations$connect$en {
	_Translations$connect$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$header$fr header = _Translations$connect$header$fr._(_root);
	@override late final _Translations$connect$adb$fr adb = _Translations$connect$adb$fr._(_root);
	@override String get refresh => 'Actualiser';
	@override String get about => 'À propos de l\'app';
	@override String get aboutShortened => 'À propos';
	@override String get viewPrivacyPolicy => 'Voir politique de confidentialité';
	@override late final _Translations$connect$noAdb$fr noAdb = _Translations$connect$noAdb$fr._(_root);
	@override late final _Translations$connect$noShizuku$fr noShizuku = _Translations$connect$noShizuku$fr._(_root);
	@override String get viewLogsShortened => 'Journaux';
	@override String get viewLogs => 'Voir les journaux';
}

// Path: apps
class _Translations$apps$fr extends Translations$apps$en {
	_Translations$apps$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$filter$fr filter = _Translations$apps$filter$fr._(_root);
	@override late final _Translations$apps$title$fr title = _Translations$apps$title$fr._(_root);
	@override late final _Translations$apps$archive$fr archive = _Translations$apps$archive$fr._(_root);
	@override late final _Translations$apps$menu$fr menu = _Translations$apps$menu$fr._(_root);
	@override late final _Translations$apps$permissions$fr permissions = _Translations$apps$permissions$fr._(_root);
	@override late final _Translations$apps$review$fr review = _Translations$apps$review$fr._(_root);
}

// Path: logs
class _Translations$logs$fr extends Translations$logs$en {
	_Translations$logs$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Journaux';
}

// Path: connect.header
class _Translations$connect$header$fr extends Translations$connect$header$en {
	_Translations$connect$header$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Connectez votre appareil';
	@override String subtitle({required Object n}) => '${n} appareils trouvés';
}

// Path: connect.adb
class _Translations$connect$adb$fr extends Translations$connect$adb$en {
	_Translations$connect$adb$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get fake => 'ADB simulé';
	@override String get real => 'ADB réel';
}

// Path: connect.noAdb
class _Translations$connect$noAdb$fr extends Translations$connect$noAdb$en {
	_Translations$connect$noAdb$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'Nous n\'avons pas trouvé ADB sur votre système.';
	@override String get adbIsRequired => 'ADB (Android Debug Bridge) est requis pour connecter votre appareil Android™ à cette application.';
	@override late final _Translations$connect$noAdb$methods$fr methods = _Translations$connect$noAdb$methods$fr._(_root);
}

// Path: connect.noShizuku
class _Translations$connect$noShizuku$fr extends Translations$connect$noShizuku$en {
	_Translations$connect$noShizuku$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$fr steps = _Translations$connect$noShizuku$steps$fr._(_root);
	@override late final _Translations$connect$noShizuku$useRoot$fr useRoot = _Translations$connect$noShizuku$useRoot$fr._(_root);
	@override String get noShizukuFound => 'Nous ne pouvons pas nous connecter à Shizuku.';
	@override String get whatIsShizuku => 'Shizuku est un projet open-source qui nous permet de contrôler d\'autres applications sans avoir besoin d\'un ordinateur ou d\'un accès root.';
	@override String get followTheseSteps => 'Suivez ces étapes pour commencer.';
}

// Path: apps.filter
class _Translations$apps$filter$fr extends Translations$apps$filter$en {
	_Translations$apps$filter$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Afficher les applications système';
	@override String get showReviewedApps => 'Afficher les applications examinées';
}

// Path: apps.title
class _Translations$apps$title$fr extends Translations$apps$title$en {
	_Translations$apps$title$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get searchYourApps => 'Recherchez vos applications';
	@override String get yourApps => 'Vos applications';
}

// Path: apps.archive
class _Translations$apps$archive$fr extends Translations$apps$archive$en {
	_Translations$apps$archive$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Archive';
	@override String get archived => 'Archivé';
	@override String get unarchive => 'Demander le déarchivage';
	@override String notSupported({required Object installer}) => 'L\'archivage n\'est pas pris en charge car l\'application a été installée par "${installer}".';
}

// Path: apps.menu
class _Translations$apps$menu$fr extends Translations$apps$menu$en {
	_Translations$apps$menu$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$menu$runInBackground$fr runInBackground = _Translations$apps$menu$runInBackground$fr._(_root);
	@override late final _Translations$apps$menu$backgroundData$fr backgroundData = _Translations$apps$menu$backgroundData$fr._(_root);
	@override String get copyDisplayName => 'Copier le nom d\'affichage';
	@override String get copyPackageName => 'Copier le nom du paquet';
	@override String viewOnInstaller({required Object installer}) => 'Vue sur ${installer}';
	@override String get viewAppInfo => 'Afficher les informations de l\'application';
	@override String get viewAppInfoDesktop => 'Afficher les informations de l\'application (sur l\'appareil)';
}

// Path: apps.permissions
class _Translations$apps$permissions$fr extends Translations$apps$permissions$en {
	_Translations$apps$permissions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Exécuter en fond';
	@override String get backgroundData => 'Données de fond';
	@override String get more => 'Plus';
}

// Path: apps.review
class _Translations$apps$review$fr extends Translations$apps$review$en {
	_Translations$apps$review$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Examiné';
	@override String get restore => 'Restaurer les permissions examinées';
}

// Path: connect.noAdb.methods
class _Translations$connect$noAdb$methods$fr extends Translations$connect$noAdb$methods$en {
	_Translations$connect$noAdb$methods$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Il existe plusieurs façons d\'installer ADB. Après l\'installation d\'ADB, redémarrez cette application.';
	@override late final _Translations$connect$noAdb$methods$packageManager$fr packageManager = _Translations$connect$noAdb$methods$packageManager$fr._(_root);
	@override late final _Translations$connect$noAdb$methods$androidStudio$fr androidStudio = _Translations$connect$noAdb$methods$androidStudio$fr._(_root);
	@override late final _Translations$connect$noAdb$methods$standalone$fr standalone = _Translations$connect$noAdb$methods$standalone$fr._(_root);
}

// Path: connect.noShizuku.steps
class _Translations$connect$noShizuku$steps$fr extends Translations$connect$noShizuku$steps$en {
	_Translations$connect$noShizuku$steps$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$downloadShizuku$fr downloadShizuku = _Translations$connect$noShizuku$steps$downloadShizuku$fr._(_root);
	@override late final _Translations$connect$noShizuku$steps$setupShizuku$fr setupShizuku = _Translations$connect$noShizuku$steps$setupShizuku$fr._(_root);
	@override late final _Translations$connect$noShizuku$steps$allowAccess$fr allowAccess = _Translations$connect$noShizuku$steps$allowAccess$fr._(_root);
}

// Path: connect.noShizuku.useRoot
class _Translations$connect$noShizuku$useRoot$fr extends Translations$connect$noShizuku$useRoot$en {
	_Translations$connect$noShizuku$useRoot$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Es-tu rooté?';
	@override String get alternativeToShizuku => 'Les appareils rootés n\'ont pas besoin de Shizuku pour accéder aux API du système.';
	@override String get checkBoxToEnable => 'Cochez la case ci-dessous pour activer la racine et accordez la permission lorsque vous y êtes invité.';
	@override String get useRoot => 'Utiliser la racine';
	@override String get experimental => 'EXPÉRIMENTAL';
}

// Path: apps.menu.runInBackground
class _Translations$apps$menu$runInBackground$fr extends Translations$apps$menu$runInBackground$en {
	_Translations$apps$menu$runInBackground$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Les commandes de batterie standard d\'Android';
	@override String get reduced => 'Réduire l\'activité en arrière-plan';
	@override String get auto => 'Autoriser l\'activité d\'arrière-plan par défaut';
	@override String get unrestricted => 'Autoriser l\'activité en arrière-plan sans restriction';
	@override String get explanation => 'C\'est un bon début, mais ce n\'est pas complètement efficace.';
}

// Path: apps.menu.backgroundData
class _Translations$apps$menu$backgroundData$fr extends Translations$apps$menu$backgroundData$en {
	_Translations$apps$menu$backgroundData$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Contrôles des données d\'arrière-plan';
	@override String get explanation => 'Ceci n\'affecté que l\'utilisation des données mobiles en arrière-plan.\nLe Wi-Fi et l\'utilisation au premier plan ne sont pas affectés.';
	@override String get restricted => 'Activer l\'utilisation des données mobiles en arrière-plan';
}

// Path: connect.noAdb.methods.packageManager
class _Translations$connect$noAdb$methods$packageManager$fr extends Translations$connect$noAdb$methods$packageManager$en {
	_Translations$connect$noAdb$methods$packageManager$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Installer ADB via le gestionnaire de paquets';
	@override String get useFollowingCommand => 'Vous pouvait installer ADB avec les commandes suivants dans votre terminal :';
	@override String get grantFlatpakPermission => 'Puis authoriser NoMoreBackground l\'access à votre systeme ADB :';
}

// Path: connect.noAdb.methods.androidStudio
class _Translations$connect$noAdb$methods$androidStudio$fr extends Translations$connect$noAdb$methods$androidStudio$en {
	_Translations$connect$noAdb$methods$androidStudio$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Installer ADB via Android Studio';
	@override String get installPlatformTools => 'Si vous avait Android Studio, vous pouvait utiliser le SDK manager pour installer le Android SDK Platform Tools package (qui inclus ADB).';
}

// Path: connect.noAdb.methods.standalone
class _Translations$connect$noAdb$methods$standalone$fr extends Translations$connect$noAdb$methods$standalone$en {
	_Translations$connect$noAdb$methods$standalone$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Installer ADB standalone';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'Vous pouvez télécharger les platform tools standalone depuis le site officiel d\'Android Developer: '),
		link,
		const TextSpan(text: '.'),
	]);
	@override String get extractAndAddToPath => 'Après le téléchargement, extrayez l\'archive et ajoutez le répertoire platform-tools à la variable d\'environnement PATH de votre système.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _Translations$connect$noShizuku$steps$downloadShizuku$fr extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	_Translations$connect$noShizuku$steps$downloadShizuku$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Télécharger Shizuku';
	@override String get otherSources => 'Autres sources';
	@override String get description => 'Téléchargez Shizuku depuis Google Play ou une autre source officielle.';
	@override String get googlePlay => 'Google Play';
}

// Path: connect.noShizuku.steps.setupShizuku
class _Translations$connect$noShizuku$steps$setupShizuku$fr extends Translations$connect$noShizuku$steps$setupShizuku$en {
	_Translations$connect$noShizuku$steps$setupShizuku$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configurer Shizuku';
	@override String get description => 'Configurez Shizuku en suivant les instructions du manuel d\'utilisation. Je recommande la méthode "Démarrer via débogage sans fil".';
	@override String get userManual => 'Manuel de l\'utilisateur';
}

// Path: connect.noShizuku.steps.allowAccess
class _Translations$connect$noShizuku$steps$allowAccess$fr extends Translations$connect$noShizuku$steps$allowAccess$en {
	_Translations$connect$noShizuku$steps$allowAccess$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Autoriser l\'accès';
	@override String get description => 'Appuyez sur le bouton ci-dessous et autorisez NoMoreBackground à accéder à Shizuku lorsque vous y êtes invité.';
	@override String get requestAccess => 'Demander l\'accès';
}
