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
class TranslationsPt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pt,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <pt>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsPt _root = this; // ignore: unused_field

	@override 
	TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPt(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsConnectPt connect = _TranslationsConnectPt._(_root);
	@override late final _TranslationsAppsPt apps = _TranslationsAppsPt._(_root);
	@override late final _TranslationsLogsPt logs = _TranslationsLogsPt._(_root);
}

// Path: connect
class _TranslationsConnectPt extends TranslationsConnectEn {
	_TranslationsConnectPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectHeaderPt header = _TranslationsConnectHeaderPt._(_root);
	@override late final _TranslationsConnectAdbPt adb = _TranslationsConnectAdbPt._(_root);
	@override String get refresh => 'Recarregar';
	@override String get about => 'Sobre esta aplicação';
	@override String get aboutShortened => 'Sobre';
	@override String get viewPrivacyPolicy => 'Veja a política de privacidade';
	@override late final _TranslationsConnectNoAdbPt noAdb = _TranslationsConnectNoAdbPt._(_root);
	@override late final _TranslationsConnectNoShizukuPt noShizuku = _TranslationsConnectNoShizukuPt._(_root);
	@override String get viewLogsShortened => 'Registos';
	@override String get viewLogs => 'Ver registos';
}

// Path: apps
class _TranslationsAppsPt extends TranslationsAppsEn {
	_TranslationsAppsPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppsFilterPt filter = _TranslationsAppsFilterPt._(_root);
	@override late final _TranslationsAppsTitlePt title = _TranslationsAppsTitlePt._(_root);
	@override late final _TranslationsAppsArchivePt archive = _TranslationsAppsArchivePt._(_root);
	@override late final _TranslationsAppsMenuPt menu = _TranslationsAppsMenuPt._(_root);
	@override late final _TranslationsAppsPermissionsPt permissions = _TranslationsAppsPermissionsPt._(_root);
	@override late final _TranslationsAppsReviewPt review = _TranslationsAppsReviewPt._(_root);
}

// Path: logs
class _TranslationsLogsPt extends TranslationsLogsEn {
	_TranslationsLogsPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registos';
}

// Path: connect.header
class _TranslationsConnectHeaderPt extends TranslationsConnectHeaderEn {
	_TranslationsConnectHeaderPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conecte o seu dispositivo';
	@override String subtitle({required Object n}) => '${n} dispositivos encontrados';
}

// Path: connect.adb
class _TranslationsConnectAdbPt extends TranslationsConnectAdbEn {
	_TranslationsConnectAdbPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get fake => 'ADB Falso';
	@override String get real => 'ADB Real';
}

// Path: connect.noAdb
class _TranslationsConnectNoAdbPt extends TranslationsConnectNoAdbEn {
	_TranslationsConnectNoAdbPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'Não conseguimos encontrar ADB no seu sistema.';
	@override String get adbIsRequired => 'ADB (Android Debug Bridge) é necessário para conectar o seu Android™ a esta aplicação.';
	@override late final _TranslationsConnectNoAdbMethodsPt methods = _TranslationsConnectNoAdbMethodsPt._(_root);
}

// Path: connect.noShizuku
class _TranslationsConnectNoShizukuPt extends TranslationsConnectNoShizukuEn {
	_TranslationsConnectNoShizukuPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'Não conseguimos conectar ao Shizuku.';
	@override String get whatIsShizuku => 'Shizuku é um projeto de código aberto que nos permite controlar outras aplicações sem precisar de um computador ou acesso root.';
	@override String get followTheseSteps => 'Siga estes passos para iniciar.';
	@override late final _TranslationsConnectNoShizukuStepsPt steps = _TranslationsConnectNoShizukuStepsPt._(_root);
	@override late final _TranslationsConnectNoShizukuUseRootPt useRoot = _TranslationsConnectNoShizukuUseRootPt._(_root);
}

// Path: apps.filter
class _TranslationsAppsFilterPt extends TranslationsAppsFilterEn {
	_TranslationsAppsFilterPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Mostrar aplicações do sistema';
	@override String get showReviewedApps => 'Mostras aplicações verificadas';
}

// Path: apps.title
class _TranslationsAppsTitlePt extends TranslationsAppsTitleEn {
	_TranslationsAppsTitlePt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Todas as aplicções';
	@override String get hideSystemApps => 'Aplicações do utilizador';
}

// Path: apps.archive
class _TranslationsAppsArchivePt extends TranslationsAppsArchiveEn {
	_TranslationsAppsArchivePt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Arquivo';
	@override String get archived => 'Arquivado';
	@override String get unarchive => 'Solicitar retirar do arquivo';
	@override String notSupported({required Object installer}) => 'Arquivamento não suportado desde que o aplicativo foi instalado por "${installer}".';
}

// Path: apps.menu
class _TranslationsAppsMenuPt extends TranslationsAppsMenuEn {
	_TranslationsAppsMenuPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'Copiar nome de exibição';
	@override String get copyPackageName => 'Copiar nome do pacote';
	@override String viewOnInstaller({required Object installer}) => 'Ver no ${installer}';
}

// Path: apps.permissions
class _TranslationsAppsPermissionsPt extends TranslationsAppsPermissionsEn {
	_TranslationsAppsPermissionsPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Rodar em bg';
	@override String get backgroundData => 'Dados Bg';
}

// Path: apps.review
class _TranslationsAppsReviewPt extends TranslationsAppsReviewEn {
	_TranslationsAppsReviewPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Verificados';
	@override String get restore => 'Restaurar permissões verificadas';
}

// Path: connect.noAdb.methods
class _TranslationsConnectNoAdbMethodsPt extends TranslationsConnectNoAdbMethodsEn {
	_TranslationsConnectNoAdbMethodsPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Há algumas maneiras de instalar o ADB. Depois de instalar o ADB, reinicie a aplicação.';
	@override late final _TranslationsConnectNoAdbMethodsPackageManagerPt packageManager = _TranslationsConnectNoAdbMethodsPackageManagerPt._(_root);
	@override late final _TranslationsConnectNoAdbMethodsAndroidStudioPt androidStudio = _TranslationsConnectNoAdbMethodsAndroidStudioPt._(_root);
	@override late final _TranslationsConnectNoAdbMethodsStandalonePt standalone = _TranslationsConnectNoAdbMethodsStandalonePt._(_root);
}

// Path: connect.noShizuku.steps
class _TranslationsConnectNoShizukuStepsPt extends TranslationsConnectNoShizukuStepsEn {
	_TranslationsConnectNoShizukuStepsPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectNoShizukuStepsDownloadShizukuPt downloadShizuku = _TranslationsConnectNoShizukuStepsDownloadShizukuPt._(_root);
	@override late final _TranslationsConnectNoShizukuStepsSetupShizukuPt setupShizuku = _TranslationsConnectNoShizukuStepsSetupShizukuPt._(_root);
	@override late final _TranslationsConnectNoShizukuStepsAllowAccessPt allowAccess = _TranslationsConnectNoShizukuStepsAllowAccessPt._(_root);
}

// Path: connect.noShizuku.useRoot
class _TranslationsConnectNoShizukuUseRootPt extends TranslationsConnectNoShizukuUseRootEn {
	_TranslationsConnectNoShizukuUseRootPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Estás como root?';
	@override String get alternativeToShizuku => 'Dispositivos com root não precisam do Shizuku para aceder às APIs do sistema.';
	@override String get checkBoxToEnable => 'Marque a caixa abaixo para habilitar o root, e conceda a permissão quando solicitado.';
	@override String get useRoot => 'Use root';
	@override String get experimental => 'EXPERIMENTAL';
}

// Path: connect.noAdb.methods.packageManager
class _TranslationsConnectNoAdbMethodsPackageManagerPt extends TranslationsConnectNoAdbMethodsPackageManagerEn {
	_TranslationsConnectNoAdbMethodsPackageManagerPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instalar o ADB através do gestor de pacotes';
	@override String get useFollowingCommand => 'Você pode instalar o ADB através dos seguintes comandos no terminal:';
	@override String get grantFlatpakPermission => 'Depois garanta ao NoMoreBackground acesso ao seu adb do seu sistema:';
}

// Path: connect.noAdb.methods.androidStudio
class _TranslationsConnectNoAdbMethodsAndroidStudioPt extends TranslationsConnectNoAdbMethodsAndroidStudioEn {
	_TranslationsConnectNoAdbMethodsAndroidStudioPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instale ADB através do Android Studio';
	@override String get installPlatformTools => 'Se você tiver Android Studio, pode usar o SDK manager para instalar o SDK Platform Tools package (que inclui o ADB).';
}

// Path: connect.noAdb.methods.standalone
class _TranslationsConnectNoAdbMethodsStandalonePt extends TranslationsConnectNoAdbMethodsStandaloneEn {
	_TranslationsConnectNoAdbMethodsStandalonePt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instalar ADB independentemente (standalone)';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'Você pode descarregar a plataforma de ferramentas de maneira independente (standalone) através do site do desenvolvedor: '),
		link,
		const TextSpan(text: '.'),
	]);
	@override String get extractAndAddToPath => 'Depois de descarregar, extraia o arquivo e adicione as ferramentas de plataforma ao seu ambiente de variáveis PATH do seu sistema.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _TranslationsConnectNoShizukuStepsDownloadShizukuPt extends TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	_TranslationsConnectNoShizukuStepsDownloadShizukuPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descarregue o Shizuku';
	@override String get description => 'Descarregue o Shizuku através da Play Store ou de outra plataforma oficial.';
	@override String get googlePlay => 'Play Store';
	@override String get otherSources => 'Outras fontes';
}

// Path: connect.noShizuku.steps.setupShizuku
class _TranslationsConnectNoShizukuStepsSetupShizukuPt extends TranslationsConnectNoShizukuStepsSetupShizukuEn {
	_TranslationsConnectNoShizukuStepsSetupShizukuPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configure o Shizuku';
	@override String get description => 'Configure o Shizuku seguindo as instruções no manual do utilizador.\nI recomenda o método "Iniciar via depuração sem fios".';
	@override String get userManual => 'Manual do utilizador';
}

// Path: connect.noShizuku.steps.allowAccess
class _TranslationsConnectNoShizukuStepsAllowAccessPt extends TranslationsConnectNoShizukuStepsAllowAccessEn {
	_TranslationsConnectNoShizukuStepsAllowAccessPt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Permitir acesso';
	@override String get description => 'Clique no botão abaixo que permite ao NoMoreBackground aceder ao Shizuku quando solicitado.';
	@override String get requestAccess => 'Solicitar acesso';
}
