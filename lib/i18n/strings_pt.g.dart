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
	@override late final _Translations$connect$pt connect = _Translations$connect$pt._(_root);
	@override late final _Translations$apps$pt apps = _Translations$apps$pt._(_root);
	@override late final _Translations$logs$pt logs = _Translations$logs$pt._(_root);
}

// Path: connect
class _Translations$connect$pt extends Translations$connect$en {
	_Translations$connect$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$header$pt header = _Translations$connect$header$pt._(_root);
	@override late final _Translations$connect$adb$pt adb = _Translations$connect$adb$pt._(_root);
	@override String get refresh => 'Recarregar';
	@override String get about => 'Sobre esta aplicação';
	@override String get aboutShortened => 'Sobre';
	@override String get viewPrivacyPolicy => 'Veja a política de privacidade';
	@override late final _Translations$connect$noAdb$pt noAdb = _Translations$connect$noAdb$pt._(_root);
	@override late final _Translations$connect$noShizuku$pt noShizuku = _Translations$connect$noShizuku$pt._(_root);
	@override String get viewLogsShortened => 'Registos';
	@override String get viewLogs => 'Ver registos';
}

// Path: apps
class _Translations$apps$pt extends Translations$apps$en {
	_Translations$apps$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$filter$pt filter = _Translations$apps$filter$pt._(_root);
	@override late final _Translations$apps$title$pt title = _Translations$apps$title$pt._(_root);
	@override late final _Translations$apps$archive$pt archive = _Translations$apps$archive$pt._(_root);
	@override late final _Translations$apps$menu$pt menu = _Translations$apps$menu$pt._(_root);
	@override late final _Translations$apps$permissions$pt permissions = _Translations$apps$permissions$pt._(_root);
	@override late final _Translations$apps$review$pt review = _Translations$apps$review$pt._(_root);
}

// Path: logs
class _Translations$logs$pt extends Translations$logs$en {
	_Translations$logs$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registos';
}

// Path: connect.header
class _Translations$connect$header$pt extends Translations$connect$header$en {
	_Translations$connect$header$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conecte o seu dispositivo';
	@override String subtitle({required Object n}) => '${n} dispositivos encontrados';
}

// Path: connect.adb
class _Translations$connect$adb$pt extends Translations$connect$adb$en {
	_Translations$connect$adb$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get fake => 'ADB Falso';
	@override String get real => 'ADB Real';
}

// Path: connect.noAdb
class _Translations$connect$noAdb$pt extends Translations$connect$noAdb$en {
	_Translations$connect$noAdb$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'Não conseguimos encontrar ADB no seu sistema.';
	@override String get adbIsRequired => 'ADB (Android Debug Bridge) é necessário para conectar o seu Android™ a esta aplicação.';
	@override late final _Translations$connect$noAdb$methods$pt methods = _Translations$connect$noAdb$methods$pt._(_root);
}

// Path: connect.noShizuku
class _Translations$connect$noShizuku$pt extends Translations$connect$noShizuku$en {
	_Translations$connect$noShizuku$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'Não conseguimos conectar ao Shizuku.';
	@override String get whatIsShizuku => 'Shizuku é um projeto de código aberto que nos permite controlar outras aplicações sem precisar de um computador ou acesso root.';
	@override String get followTheseSteps => 'Siga estes passos para iniciar.';
	@override late final _Translations$connect$noShizuku$steps$pt steps = _Translations$connect$noShizuku$steps$pt._(_root);
	@override late final _Translations$connect$noShizuku$useRoot$pt useRoot = _Translations$connect$noShizuku$useRoot$pt._(_root);
}

// Path: apps.filter
class _Translations$apps$filter$pt extends Translations$apps$filter$en {
	_Translations$apps$filter$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Mostrar aplicações do sistema';
	@override String get showReviewedApps => 'Mostras aplicações verificadas';
}

// Path: apps.title
class _Translations$apps$title$pt extends Translations$apps$title$en {
	_Translations$apps$title$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get searchYourApps => 'Pesquisar seus aplicativos';
	@override String get yourApps => 'Seus aplicativos';
}

// Path: apps.archive
class _Translations$apps$archive$pt extends Translations$apps$archive$en {
	_Translations$apps$archive$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Arquivo';
	@override String get archived => 'Arquivado';
	@override String get unarchive => 'Solicitar retirar do arquivo';
	@override String notSupported({required Object installer}) => 'Arquivamento não suportado desde que o aplicativo foi instalado por "${installer}".';
}

// Path: apps.menu
class _Translations$apps$menu$pt extends Translations$apps$menu$en {
	_Translations$apps$menu$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'Copiar nome de exibição';
	@override String get copyPackageName => 'Copiar nome do pacote';
	@override String get viewAppInfo => 'Ver informação da aplicação';
	@override String get viewAppInfoDesktop => 'Ver informação da aplicação (no dispositivo)';
	@override String viewOnInstaller({required Object installer}) => 'Ver no ${installer}';
	@override late final _Translations$apps$menu$background$pt background = _Translations$apps$menu$background$pt._(_root);
}

// Path: apps.permissions
class _Translations$apps$permissions$pt extends Translations$apps$permissions$en {
	_Translations$apps$permissions$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Rodar em bg';
	@override String get backgroundData => 'Dados Bg';
	@override String get more => 'Mais';
}

// Path: apps.review
class _Translations$apps$review$pt extends Translations$apps$review$en {
	_Translations$apps$review$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Verificados';
	@override String get restore => 'Restaurar permissões verificadas';
}

// Path: connect.noAdb.methods
class _Translations$connect$noAdb$methods$pt extends Translations$connect$noAdb$methods$en {
	_Translations$connect$noAdb$methods$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Há algumas maneiras de instalar o ADB. Depois de instalar o ADB, reinicie a aplicação.';
	@override late final _Translations$connect$noAdb$methods$packageManager$pt packageManager = _Translations$connect$noAdb$methods$packageManager$pt._(_root);
	@override late final _Translations$connect$noAdb$methods$androidStudio$pt androidStudio = _Translations$connect$noAdb$methods$androidStudio$pt._(_root);
	@override late final _Translations$connect$noAdb$methods$standalone$pt standalone = _Translations$connect$noAdb$methods$standalone$pt._(_root);
}

// Path: connect.noShizuku.steps
class _Translations$connect$noShizuku$steps$pt extends Translations$connect$noShizuku$steps$en {
	_Translations$connect$noShizuku$steps$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$downloadShizuku$pt downloadShizuku = _Translations$connect$noShizuku$steps$downloadShizuku$pt._(_root);
	@override late final _Translations$connect$noShizuku$steps$setupShizuku$pt setupShizuku = _Translations$connect$noShizuku$steps$setupShizuku$pt._(_root);
	@override late final _Translations$connect$noShizuku$steps$allowAccess$pt allowAccess = _Translations$connect$noShizuku$steps$allowAccess$pt._(_root);
}

// Path: connect.noShizuku.useRoot
class _Translations$connect$noShizuku$useRoot$pt extends Translations$connect$noShizuku$useRoot$en {
	_Translations$connect$noShizuku$useRoot$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Estás como root?';
	@override String get alternativeToShizuku => 'Dispositivos com root não precisam do Shizuku para aceder às APIs do sistema.';
	@override String get checkBoxToEnable => 'Marque a caixa abaixo para habilitar o root, e conceda a permissão quando solicitado.';
	@override String get useRoot => 'Use root';
	@override String get experimental => 'EXPERIMENTAL';
}

// Path: apps.menu.background
class _Translations$apps$menu$background$pt extends Translations$apps$menu$background$en {
	_Translations$apps$menu$background$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get reduced => 'Reduzir a atividade em segundo plano';
	@override String get auto => 'Permitir atividade em segundo plano padrão';
	@override String get unrestricted => 'Permitir atividade em segundo plano sem restrições';
}

// Path: connect.noAdb.methods.packageManager
class _Translations$connect$noAdb$methods$packageManager$pt extends Translations$connect$noAdb$methods$packageManager$en {
	_Translations$connect$noAdb$methods$packageManager$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instalar o ADB através do gestor de pacotes';
	@override String get useFollowingCommand => 'Você pode instalar o ADB através dos seguintes comandos no terminal:';
	@override String get grantFlatpakPermission => 'Depois garanta ao NoMoreBackground acesso ao seu adb do seu sistema:';
}

// Path: connect.noAdb.methods.androidStudio
class _Translations$connect$noAdb$methods$androidStudio$pt extends Translations$connect$noAdb$methods$androidStudio$en {
	_Translations$connect$noAdb$methods$androidStudio$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instale ADB através do Android Studio';
	@override String get installPlatformTools => 'Se você tiver Android Studio, pode usar o SDK manager para instalar o SDK Platform Tools package (que inclui o ADB).';
}

// Path: connect.noAdb.methods.standalone
class _Translations$connect$noAdb$methods$standalone$pt extends Translations$connect$noAdb$methods$standalone$en {
	_Translations$connect$noAdb$methods$standalone$pt._(TranslationsPt root) : this._root = root, super.internal(root);

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
class _Translations$connect$noShizuku$steps$downloadShizuku$pt extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	_Translations$connect$noShizuku$steps$downloadShizuku$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descarregue o Shizuku';
	@override String get description => 'Descarregue o Shizuku através da Play Store ou de outra plataforma oficial.';
	@override String get googlePlay => 'Play Store';
	@override String get otherSources => 'Outras fontes';
}

// Path: connect.noShizuku.steps.setupShizuku
class _Translations$connect$noShizuku$steps$setupShizuku$pt extends Translations$connect$noShizuku$steps$setupShizuku$en {
	_Translations$connect$noShizuku$steps$setupShizuku$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configure o Shizuku';
	@override String get description => 'Configure o Shizuku seguindo as instruções no manual do utilizador.\nI recomenda o método "Iniciar via depuração sem fios".';
	@override String get userManual => 'Manual do utilizador';
}

// Path: connect.noShizuku.steps.allowAccess
class _Translations$connect$noShizuku$steps$allowAccess$pt extends Translations$connect$noShizuku$steps$allowAccess$en {
	_Translations$connect$noShizuku$steps$allowAccess$pt._(TranslationsPt root) : this._root = root, super.internal(root);

	final TranslationsPt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Permitir acesso';
	@override String get description => 'Clique no botão abaixo que permite ao NoMoreBackground aceder ao Shizuku quando solicitado.';
	@override String get requestAccess => 'Solicitar acesso';
}
