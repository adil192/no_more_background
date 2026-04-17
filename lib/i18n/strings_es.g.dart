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
	@override late final _TranslationsConnectEs connect = _TranslationsConnectEs._(_root);
	@override late final _TranslationsAppsEs apps = _TranslationsAppsEs._(_root);
	@override late final _TranslationsLogsEs logs = _TranslationsLogsEs._(_root);
}

// Path: connect
class _TranslationsConnectEs extends TranslationsConnectEn {
	_TranslationsConnectEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectHeaderEs header = _TranslationsConnectHeaderEs._(_root);
	@override late final _TranslationsConnectAdbEs adb = _TranslationsConnectAdbEs._(_root);
	@override String get refresh => 'Refrescar';
	@override String get about => 'Sobre esta aplicación';
	@override String get aboutShortened => 'Acerca de';
	@override String get viewPrivacyPolicy => 'Ver política de privacidad';
	@override late final _TranslationsConnectNoAdbEs noAdb = _TranslationsConnectNoAdbEs._(_root);
	@override late final _TranslationsConnectNoShizukuEs noShizuku = _TranslationsConnectNoShizukuEs._(_root);
	@override String get viewLogsShortened => 'Registros';
	@override String get viewLogs => 'Ver registros';
}

// Path: apps
class _TranslationsAppsEs extends TranslationsAppsEn {
	_TranslationsAppsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppsFilterEs filter = _TranslationsAppsFilterEs._(_root);
	@override late final _TranslationsAppsTitleEs title = _TranslationsAppsTitleEs._(_root);
	@override late final _TranslationsAppsArchiveEs archive = _TranslationsAppsArchiveEs._(_root);
	@override late final _TranslationsAppsMenuEs menu = _TranslationsAppsMenuEs._(_root);
	@override late final _TranslationsAppsPermissionsEs permissions = _TranslationsAppsPermissionsEs._(_root);
	@override late final _TranslationsAppsReviewEs review = _TranslationsAppsReviewEs._(_root);
}

// Path: logs
class _TranslationsLogsEs extends TranslationsLogsEn {
	_TranslationsLogsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Registros';
}

// Path: connect.header
class _TranslationsConnectHeaderEs extends TranslationsConnectHeaderEn {
	_TranslationsConnectHeaderEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Conecta tu dispositivo';
	@override String subtitle({required Object n}) => '${n} dispositivos encontrados';
}

// Path: connect.adb
class _TranslationsConnectAdbEs extends TranslationsConnectAdbEn {
	_TranslationsConnectAdbEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get fake => 'ADB falso';
	@override String get real => 'ADB real';
}

// Path: connect.noAdb
class _TranslationsConnectNoAdbEs extends TranslationsConnectNoAdbEn {
	_TranslationsConnectNoAdbEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'No podemos encontrar ADB en tu sistema.';
	@override String get adbIsRequired => 'ADB (Android Debug Bridge) es necesario para conectar tu dispositivo Android™ a esta aplicación.';
	@override late final _TranslationsConnectNoAdbMethodsEs methods = _TranslationsConnectNoAdbMethodsEs._(_root);
}

// Path: connect.noShizuku
class _TranslationsConnectNoShizukuEs extends TranslationsConnectNoShizukuEn {
	_TranslationsConnectNoShizukuEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'No podemos conectar a Shizuku.';
	@override String get whatIsShizuku => 'Shizuku es un proyecto de código abierto que nos permite controlar otras aplicaciones sin necesidad de un ordenador ni acceso root.';
	@override String get followTheseSteps => 'Sigue estos pasos para empezar.';
	@override late final _TranslationsConnectNoShizukuStepsEs steps = _TranslationsConnectNoShizukuStepsEs._(_root);
	@override late final _TranslationsConnectNoShizukuUseRootEs useRoot = _TranslationsConnectNoShizukuUseRootEs._(_root);
}

// Path: apps.filter
class _TranslationsAppsFilterEs extends TranslationsAppsFilterEn {
	_TranslationsAppsFilterEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Mostrar aplicaciones de sistema';
	@override String get showReviewedApps => 'Mostrar apps revisadas';
}

// Path: apps.title
class _TranslationsAppsTitleEs extends TranslationsAppsTitleEn {
	_TranslationsAppsTitleEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Todas las aplicaciones';
	@override String get hideSystemApps => 'Aplicaciones de usuario';
}

// Path: apps.archive
class _TranslationsAppsArchiveEs extends TranslationsAppsArchiveEn {
	_TranslationsAppsArchiveEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Archivo';
	@override String get archived => 'Archivado';
	@override String get unarchive => 'Solicitar desarchivar';
	@override String notSupported({required Object installer}) => 'El archivado no es compatible ya que la aplicación fue instalada por "${installer}".';
}

// Path: apps.menu
class _TranslationsAppsMenuEs extends TranslationsAppsMenuEn {
	_TranslationsAppsMenuEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'Copiar nombre para mostrar';
	@override String get copyPackageName => 'Copiar nombre del paquete';
	@override String viewOnInstaller({required Object installer}) => 'Ver en ${installer}';
}

// Path: apps.permissions
class _TranslationsAppsPermissionsEs extends TranslationsAppsPermissionsEn {
	_TranslationsAppsPermissionsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Ejecutar en bg';
	@override String get backgroundData => 'Datos bg';
}

// Path: apps.review
class _TranslationsAppsReviewEs extends TranslationsAppsReviewEn {
	_TranslationsAppsReviewEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Revisado';
	@override String get restore => 'Restaurar permisos revisados';
}

// Path: connect.noAdb.methods
class _TranslationsConnectNoAdbMethodsEs extends TranslationsConnectNoAdbMethodsEn {
	_TranslationsConnectNoAdbMethodsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Hay varias maneras de instalar ADB. Después de instalar ADB, reinicie esta aplicación.';
	@override late final _TranslationsConnectNoAdbMethodsPackageManagerEs packageManager = _TranslationsConnectNoAdbMethodsPackageManagerEs._(_root);
	@override late final _TranslationsConnectNoAdbMethodsAndroidStudioEs androidStudio = _TranslationsConnectNoAdbMethodsAndroidStudioEs._(_root);
	@override late final _TranslationsConnectNoAdbMethodsStandaloneEs standalone = _TranslationsConnectNoAdbMethodsStandaloneEs._(_root);
}

// Path: connect.noShizuku.steps
class _TranslationsConnectNoShizukuStepsEs extends TranslationsConnectNoShizukuStepsEn {
	_TranslationsConnectNoShizukuStepsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectNoShizukuStepsDownloadShizukuEs downloadShizuku = _TranslationsConnectNoShizukuStepsDownloadShizukuEs._(_root);
	@override late final _TranslationsConnectNoShizukuStepsSetupShizukuEs setupShizuku = _TranslationsConnectNoShizukuStepsSetupShizukuEs._(_root);
	@override late final _TranslationsConnectNoShizukuStepsAllowAccessEs allowAccess = _TranslationsConnectNoShizukuStepsAllowAccessEs._(_root);
}

// Path: connect.noShizuku.useRoot
class _TranslationsConnectNoShizukuUseRootEs extends TranslationsConnectNoShizukuUseRootEn {
	_TranslationsConnectNoShizukuUseRootEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => '¿Tienes acceso root?';
	@override String get alternativeToShizuku => 'Los dispositivos rooteados no necesitan Shizuku para acceder a las API del sistema.';
	@override String get checkBoxToEnable => 'Marque la casilla a continuación para habilitar el acceso root y otorgue el permiso cuando se le solicite.';
	@override String get useRoot => 'Usar root';
	@override String get experimental => 'EXPERIMENTAL';
}

// Path: connect.noAdb.methods.packageManager
class _TranslationsConnectNoAdbMethodsPackageManagerEs extends TranslationsConnectNoAdbMethodsPackageManagerEn {
	_TranslationsConnectNoAdbMethodsPackageManagerEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instalé ADB a través del administrador de paquetes';
	@override String get useFollowingCommand => 'Puedes instalar ADB usando el siguiente comando en tu terminal:';
	@override String get grantFlatpakPermission => 'Luego otorgue a NoMoreBackground acceso a su sistema adb:';
}

// Path: connect.noAdb.methods.androidStudio
class _TranslationsConnectNoAdbMethodsAndroidStudioEs extends TranslationsConnectNoAdbMethodsAndroidStudioEn {
	_TranslationsConnectNoAdbMethodsAndroidStudioEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instale ADB a través de Android Studio';
	@override String get installPlatformTools => 'Si tienes Android Studio, puedes usar su administrador de SDK para instalar las herramientas de plataforma del SDK de Android paquete (que incluye ADB).';
}

// Path: connect.noAdb.methods.standalone
class _TranslationsConnectNoAdbMethodsStandaloneEs extends TranslationsConnectNoAdbMethodsStandaloneEn {
	_TranslationsConnectNoAdbMethodsStandaloneEs._(TranslationsEs root) : this._root = root, super.internal(root);

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
class _TranslationsConnectNoShizukuStepsDownloadShizukuEs extends TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	_TranslationsConnectNoShizukuStepsDownloadShizukuEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Descarga Shizuku';
	@override String get description => 'Descarga Shizuku desde Google Play u otra fuente oficial.';
	@override String get googlePlay => 'Google Play Store';
	@override String get otherSources => 'Otras fuentes';
}

// Path: connect.noShizuku.steps.setupShizuku
class _TranslationsConnectNoShizukuStepsSetupShizukuEs extends TranslationsConnectNoShizukuStepsSetupShizukuEn {
	_TranslationsConnectNoShizukuStepsSetupShizukuEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Configurar Shizuku';
	@override String get description => 'Configure Shizuku siguiendo las instrucciones en el manual del usuario.\nl recomiendo el método "Iniciar vía depuración inalámbrica".';
	@override String get userManual => 'Manual de usuario';
}

// Path: connect.noShizuku.steps.allowAccess
class _TranslationsConnectNoShizukuStepsAllowAccessEs extends TranslationsConnectNoShizukuStepsAllowAccessEn {
	_TranslationsConnectNoShizukuStepsAllowAccessEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Permitir acceso';
	@override String get description => 'Toca el botón de abajo y permite que NoMoreBackground acceda a Shizuku cuando se te solicite.';
	@override String get requestAccess => 'Solicitar acceso';
}
