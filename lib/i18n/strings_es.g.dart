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
class TranslationsEs extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$connect$es connect = _Translations$connect$es._(_root);
	@override late final _Translations$apps$es apps = _Translations$apps$es._(_root);
	@override late final _Translations$logs$es logs = _Translations$logs$es._(_root);
}

// Path: connect
class _Translations$connect$es extends Translations$connect$en {
	_Translations$connect$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$header$es header = _Translations$connect$header$es._(_root);
	@override late final _Translations$connect$adb$es adb = _Translations$connect$adb$es._(_root);
	@override String get refresh => 'Refrescar';
	@override String get about => 'Sobre esta aplicación';
	@override String get aboutShortened => 'Acerca de';
	@override String get viewPrivacyPolicy => 'Ver política de privacidad';
	@override late final _Translations$connect$noAdb$es noAdb = _Translations$connect$noAdb$es._(_root);
	@override late final _Translations$connect$noShizuku$es noShizuku = _Translations$connect$noShizuku$es._(_root);
	@override String get viewLogsShortened => 'Registros';
	@override String get viewLogs => 'Ver registros';
}

// Path: apps
class _Translations$apps$es extends Translations$apps$en {
	_Translations$apps$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$filter$es filter = _Translations$apps$filter$es._(_root);
	@override late final _Translations$apps$title$es title = _Translations$apps$title$es._(_root);
	@override late final _Translations$apps$archive$es archive = _Translations$apps$archive$es._(_root);
	@override late final _Translations$apps$menu$es menu = _Translations$apps$menu$es._(_root);
	@override late final _Translations$apps$permissions$es permissions = _Translations$apps$permissions$es._(_root);
	@override late final _Translations$apps$review$es review = _Translations$apps$review$es._(_root);
}

// Path: logs
class _Translations$logs$es extends Translations$logs$en {
	_Translations$logs$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registros';
}

// Path: connect.header
class _Translations$connect$header$es extends Translations$connect$header$en {
	_Translations$connect$header$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conecta tu dispositivo';
	@override String subtitle({required Object n}) => '${n} dispositivos encontrados';
}

// Path: connect.adb
class _Translations$connect$adb$es extends Translations$connect$adb$en {
	_Translations$connect$adb$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get fake => 'ADB falso';
	@override String get real => 'ADB real';
}

// Path: connect.noAdb
class _Translations$connect$noAdb$es extends Translations$connect$noAdb$en {
	_Translations$connect$noAdb$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'No podemos encontrar ADB en tu sistema.';
	@override String get adbIsRequired => 'ADB (Android Debug Bridge) es necesario para conectar tu dispositivo Android™ a esta aplicación.';
	@override late final _Translations$connect$noAdb$methods$es methods = _Translations$connect$noAdb$methods$es._(_root);
}

// Path: connect.noShizuku
class _Translations$connect$noShizuku$es extends Translations$connect$noShizuku$en {
	_Translations$connect$noShizuku$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'No podemos conectar a Shizuku.';
	@override String get whatIsShizuku => 'Shizuku es un proyecto de código abierto que nos permite controlar otras aplicaciones sin necesidad de un ordenador ni acceso root.';
	@override String get followTheseSteps => 'Sigue estos pasos para empezar.';
	@override late final _Translations$connect$noShizuku$steps$es steps = _Translations$connect$noShizuku$steps$es._(_root);
	@override late final _Translations$connect$noShizuku$useRoot$es useRoot = _Translations$connect$noShizuku$useRoot$es._(_root);
}

// Path: apps.filter
class _Translations$apps$filter$es extends Translations$apps$filter$en {
	_Translations$apps$filter$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Mostrar aplicaciones de sistema';
	@override String get showReviewedApps => 'Mostrar apps revisadas';
}

// Path: apps.title
class _Translations$apps$title$es extends Translations$apps$title$en {
	_Translations$apps$title$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Todas las aplicaciones';
	@override String get hideSystemApps => 'Aplicaciones de usuario';
}

// Path: apps.archive
class _Translations$apps$archive$es extends Translations$apps$archive$en {
	_Translations$apps$archive$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Archivo';
	@override String get archived => 'Archivado';
	@override String get unarchive => 'Solicitar desarchivar';
	@override String notSupported({required Object installer}) => 'El archivado no es compatible ya que la aplicación fue instalada por "${installer}".';
}

// Path: apps.menu
class _Translations$apps$menu$es extends Translations$apps$menu$en {
	_Translations$apps$menu$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'Copiar nombre para mostrar';
	@override String get copyPackageName => 'Copiar nombre del paquete';
	@override String viewOnInstaller({required Object installer}) => 'Ver en ${installer}';
	@override late final _Translations$apps$menu$background$es background = _Translations$apps$menu$background$es._(_root);
	@override String get viewAppInfo => 'Ver información de la aplicación';
	@override String get viewAppInfoDesktop => 'Ver información de la aplicación (en el dispositivo)';
}

// Path: apps.permissions
class _Translations$apps$permissions$es extends Translations$apps$permissions$en {
	_Translations$apps$permissions$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Ejecutar en bg';
	@override String get backgroundData => 'Datos bg';
}

// Path: apps.review
class _Translations$apps$review$es extends Translations$apps$review$en {
	_Translations$apps$review$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Revisado';
	@override String get restore => 'Restaurar permisos revisados';
}

// Path: connect.noAdb.methods
class _Translations$connect$noAdb$methods$es extends Translations$connect$noAdb$methods$en {
	_Translations$connect$noAdb$methods$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Hay varias maneras de instalar ADB. Después de instalar ADB, reinicie esta aplicación.';
	@override late final _Translations$connect$noAdb$methods$packageManager$es packageManager = _Translations$connect$noAdb$methods$packageManager$es._(_root);
	@override late final _Translations$connect$noAdb$methods$androidStudio$es androidStudio = _Translations$connect$noAdb$methods$androidStudio$es._(_root);
	@override late final _Translations$connect$noAdb$methods$standalone$es standalone = _Translations$connect$noAdb$methods$standalone$es._(_root);
}

// Path: connect.noShizuku.steps
class _Translations$connect$noShizuku$steps$es extends Translations$connect$noShizuku$steps$en {
	_Translations$connect$noShizuku$steps$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$downloadShizuku$es downloadShizuku = _Translations$connect$noShizuku$steps$downloadShizuku$es._(_root);
	@override late final _Translations$connect$noShizuku$steps$setupShizuku$es setupShizuku = _Translations$connect$noShizuku$steps$setupShizuku$es._(_root);
	@override late final _Translations$connect$noShizuku$steps$allowAccess$es allowAccess = _Translations$connect$noShizuku$steps$allowAccess$es._(_root);
}

// Path: connect.noShizuku.useRoot
class _Translations$connect$noShizuku$useRoot$es extends Translations$connect$noShizuku$useRoot$en {
	_Translations$connect$noShizuku$useRoot$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => '¿Tienes acceso root?';
	@override String get alternativeToShizuku => 'Los dispositivos rooteados no necesitan Shizuku para acceder a las API del sistema.';
	@override String get checkBoxToEnable => 'Marque la casilla a continuación para habilitar el acceso root y otorgue el permiso cuando se le solicite.';
	@override String get useRoot => 'Usar root';
	@override String get experimental => 'EXPERIMENTAL';
}

// Path: apps.menu.background
class _Translations$apps$menu$background$es extends Translations$apps$menu$background$en {
	_Translations$apps$menu$background$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get reduced => 'Reducir actividad en segundo plano';
	@override String get auto => 'Permitir la actividad de fondo predeterminada';
	@override String get unrestricted => 'Permitir actividad en segundo plano sin restricciones';
}

// Path: connect.noAdb.methods.packageManager
class _Translations$connect$noAdb$methods$packageManager$es extends Translations$connect$noAdb$methods$packageManager$en {
	_Translations$connect$noAdb$methods$packageManager$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instalé ADB a través del administrador de paquetes';
	@override String get useFollowingCommand => 'Puedes instalar ADB usando el siguiente comando en tu terminal:';
	@override String get grantFlatpakPermission => 'Luego otorgue a NoMoreBackground acceso a su sistema adb:';
}

// Path: connect.noAdb.methods.androidStudio
class _Translations$connect$noAdb$methods$androidStudio$es extends Translations$connect$noAdb$methods$androidStudio$en {
	_Translations$connect$noAdb$methods$androidStudio$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instale ADB a través de Android Studio';
	@override String get installPlatformTools => 'Si tienes Android Studio, puedes usar su administrador de SDK para instalar las herramientas de plataforma del SDK de Android paquete (que incluye ADB).';
}

// Path: connect.noAdb.methods.standalone
class _Translations$connect$noAdb$methods$standalone$es extends Translations$connect$noAdb$methods$standalone$en {
	_Translations$connect$noAdb$methods$standalone$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instalar ADB independiente';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'Puede descargar las herramientas de la plataforma independiente desde el sitio web oficial para desarrolladores de Android: '),
		link,
		const TextSpan(text: '.'),
	]);
	@override String get extractAndAddToPath => 'Después de la descarga, extraiga el archivo y agregue el directorio platform-tools a la variable de entorno PATH de su sistema variable de entorno.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _Translations$connect$noShizuku$steps$downloadShizuku$es extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	_Translations$connect$noShizuku$steps$downloadShizuku$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descarga Shizuku';
	@override String get description => 'Descarga Shizuku desde Google Play u otra fuente oficial.';
	@override String get googlePlay => 'Google Play Store';
	@override String get otherSources => 'Otras fuentes';
}

// Path: connect.noShizuku.steps.setupShizuku
class _Translations$connect$noShizuku$steps$setupShizuku$es extends Translations$connect$noShizuku$steps$setupShizuku$en {
	_Translations$connect$noShizuku$steps$setupShizuku$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configurar Shizuku';
	@override String get description => 'Configure Shizuku siguiendo las instrucciones en el manual del usuario.\nl recomiendo el método "Iniciar vía depuración inalámbrica".';
	@override String get userManual => 'Manual de usuario';
}

// Path: connect.noShizuku.steps.allowAccess
class _Translations$connect$noShizuku$steps$allowAccess$es extends Translations$connect$noShizuku$steps$allowAccess$en {
	_Translations$connect$noShizuku$steps$allowAccess$es._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Permitir acceso';
	@override String get description => 'Toca el botón de abajo y permite que NoMoreBackground acceda a Shizuku cuando se te solicite.';
	@override String get requestAccess => 'Solicitar acceso';
}
