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
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsConnectRu connect = _TranslationsConnectRu._(_root);
	@override late final _TranslationsAppsRu apps = _TranslationsAppsRu._(_root);
	@override late final _TranslationsLogsRu logs = _TranslationsLogsRu._(_root);
}

// Path: connect
class _TranslationsConnectRu extends TranslationsConnectEn {
	_TranslationsConnectRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectHeaderRu header = _TranslationsConnectHeaderRu._(_root);
	@override late final _TranslationsConnectAdbRu adb = _TranslationsConnectAdbRu._(_root);
	@override String get refresh => 'Обновить';
	@override String get about => 'О приложении';
	@override String get aboutShortened => 'О программе';
	@override String get viewPrivacyPolicy => 'Посмотреть политику конфиденциальности';
	@override late final _TranslationsConnectNoAdbRu noAdb = _TranslationsConnectNoAdbRu._(_root);
	@override late final _TranslationsConnectNoShizukuRu noShizuku = _TranslationsConnectNoShizukuRu._(_root);
	@override String get viewLogsShortened => 'Журналы';
	@override String get viewLogs => 'Посмотреть журналы';
}

// Path: apps
class _TranslationsAppsRu extends TranslationsAppsEn {
	_TranslationsAppsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppsFilterRu filter = _TranslationsAppsFilterRu._(_root);
	@override late final _TranslationsAppsTitleRu title = _TranslationsAppsTitleRu._(_root);
	@override late final _TranslationsAppsArchiveRu archive = _TranslationsAppsArchiveRu._(_root);
	@override late final _TranslationsAppsMenuRu menu = _TranslationsAppsMenuRu._(_root);
	@override late final _TranslationsAppsPermissionsRu permissions = _TranslationsAppsPermissionsRu._(_root);
	@override late final _TranslationsAppsReviewRu review = _TranslationsAppsReviewRu._(_root);
}

// Path: logs
class _TranslationsLogsRu extends TranslationsLogsEn {
	_TranslationsLogsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Журналы';
}

// Path: connect.header
class _TranslationsConnectHeaderRu extends TranslationsConnectHeaderEn {
	_TranslationsConnectHeaderRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Подключите ваше устройство';
	@override String subtitle({required Object n}) => '${n} устройств найдено';
}

// Path: connect.adb
class _TranslationsConnectAdbRu extends TranslationsConnectAdbEn {
	_TranslationsConnectAdbRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get fake => 'Fake ADB';
	@override String get real => 'Real ADB';
}

// Path: connect.noAdb
class _TranslationsConnectNoAdbRu extends TranslationsConnectNoAdbEn {
	_TranslationsConnectNoAdbRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'ADB в вашей системе не найден.';
	@override String get adbIsRequired => 'Для подключения вашего устройства Android™ к этому приложению требуется ADB (Android Debug Bridge).';
	@override late final _TranslationsConnectNoAdbMethodsRu methods = _TranslationsConnectNoAdbMethodsRu._(_root);
}

// Path: connect.noShizuku
class _TranslationsConnectNoShizukuRu extends TranslationsConnectNoShizukuEn {
	_TranslationsConnectNoShizukuRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'Невозможно соединиться с Shizuku.';
	@override String get whatIsShizuku => 'Shizuku — это проект с открытым исходным кодом, который позволяет управлять другими приложениями без помощи компьютера или получения root-прав.';
	@override String get followTheseSteps => 'Выполните следующие шаги, чтобы начать.';
	@override late final _TranslationsConnectNoShizukuStepsRu steps = _TranslationsConnectNoShizukuStepsRu._(_root);
	@override late final _TranslationsConnectNoShizukuUseRootRu useRoot = _TranslationsConnectNoShizukuUseRootRu._(_root);
}

// Path: apps.filter
class _TranslationsAppsFilterRu extends TranslationsAppsFilterEn {
	_TranslationsAppsFilterRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Показать системные приложения';
	@override String get showReviewedApps => 'Показать проверенные приложения';
}

// Path: apps.title
class _TranslationsAppsTitleRu extends TranslationsAppsTitleEn {
	_TranslationsAppsTitleRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Все приложения';
	@override String get hideSystemApps => 'Пользовательские приложения';
}

// Path: apps.archive
class _TranslationsAppsArchiveRu extends TranslationsAppsArchiveEn {
	_TranslationsAppsArchiveRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Архив';
	@override String get archived => 'Архивированные';
	@override String get unarchive => 'Запросить разархивацию';
	@override String notSupported({required Object installer}) => 'Архивирование не поддерживается, поскольку приложение было установлено с помощью "${installer}".';
}

// Path: apps.menu
class _TranslationsAppsMenuRu extends TranslationsAppsMenuEn {
	_TranslationsAppsMenuRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'Копировать отображаемое имя';
	@override String get copyPackageName => 'Скопировать имя пакета';
	@override String viewOnInstaller({required Object installer}) => 'Посмотреть в ${installer}';
}

// Path: apps.permissions
class _TranslationsAppsPermissionsRu extends TranslationsAppsPermissionsEn {
	_TranslationsAppsPermissionsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Работа в фоне';
	@override String get backgroundData => 'Фоновые данные';
}

// Path: apps.review
class _TranslationsAppsReviewRu extends TranslationsAppsReviewEn {
	_TranslationsAppsReviewRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Проверенные';
	@override String get restore => 'Восстановить проверенные разрешения';
}

// Path: connect.noAdb.methods
class _TranslationsConnectNoAdbMethodsRu extends TranslationsConnectNoAdbMethodsEn {
	_TranslationsConnectNoAdbMethodsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Существует несколько способов установки ADB. После установки ADB перезапустите это приложение.';
	@override late final _TranslationsConnectNoAdbMethodsPackageManagerRu packageManager = _TranslationsConnectNoAdbMethodsPackageManagerRu._(_root);
	@override late final _TranslationsConnectNoAdbMethodsAndroidStudioRu androidStudio = _TranslationsConnectNoAdbMethodsAndroidStudioRu._(_root);
	@override late final _TranslationsConnectNoAdbMethodsStandaloneRu standalone = _TranslationsConnectNoAdbMethodsStandaloneRu._(_root);
}

// Path: connect.noShizuku.steps
class _TranslationsConnectNoShizukuStepsRu extends TranslationsConnectNoShizukuStepsEn {
	_TranslationsConnectNoShizukuStepsRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectNoShizukuStepsDownloadShizukuRu downloadShizuku = _TranslationsConnectNoShizukuStepsDownloadShizukuRu._(_root);
	@override late final _TranslationsConnectNoShizukuStepsSetupShizukuRu setupShizuku = _TranslationsConnectNoShizukuStepsSetupShizukuRu._(_root);
	@override late final _TranslationsConnectNoShizukuStepsAllowAccessRu allowAccess = _TranslationsConnectNoShizukuStepsAllowAccessRu._(_root);
}

// Path: connect.noShizuku.useRoot
class _TranslationsConnectNoShizukuUseRootRu extends TranslationsConnectNoShizukuUseRootEn {
	_TranslationsConnectNoShizukuUseRootRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Устройство имеет root-доступ?';
	@override String get alternativeToShizuku => 'Устройствам с root-правами для доступа к системным API не требуется Shizuku.';
	@override String get checkBoxToEnable => 'Поставьте галочку в поле ниже, чтобы предоставить root-права, и дайте необходимые разрешения при запросе.';
	@override String get useRoot => 'Использовать root';
	@override String get experimental => 'ЭКСПЕРИМЕНТАЛЬНО';
}

// Path: connect.noAdb.methods.packageManager
class _TranslationsConnectNoAdbMethodsPackageManagerRu extends TranslationsConnectNoAdbMethodsPackageManagerEn {
	_TranslationsConnectNoAdbMethodsPackageManagerRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Установка ADB через менеджер пакетов';
	@override String get useFollowingCommand => 'Вы можете установить ADB, используя следующую команду в терминале:';
	@override String get grantFlatpakPermission => 'Затем предоставьте NoMoreBackground доступ к ADB вашей системы:';
}

// Path: connect.noAdb.methods.androidStudio
class _TranslationsConnectNoAdbMethodsAndroidStudioRu extends TranslationsConnectNoAdbMethodsAndroidStudioEn {
	_TranslationsConnectNoAdbMethodsAndroidStudioRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Установка ADB через Android Studio';
	@override String get installPlatformTools => 'Если у вас установлена Android Studio, вы можете использовать её менеджер SDK для установки пакета Android SDK Platform Tools, который включает ADB.';
}

// Path: connect.noAdb.methods.standalone
class _TranslationsConnectNoAdbMethodsStandaloneRu extends TranslationsConnectNoAdbMethodsStandaloneEn {
	_TranslationsConnectNoAdbMethodsStandaloneRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Установка ADB в автономном режиме';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'Вы можете загрузить автономные инструменты платформы с официального сайта разработчиков Android: '),
		link,
		const TextSpan(text: '.'),
	]);
	@override String get extractAndAddToPath => 'После загрузки распакуйте архив и добавьте каталог platform-tools в переменную среды PATH вашей системы.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _TranslationsConnectNoShizukuStepsDownloadShizukuRu extends TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	_TranslationsConnectNoShizukuStepsDownloadShizukuRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Скачать Shizuku';
	@override String get description => 'Скачайте Shizuku из Google Play или другого официального источника.';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => 'Другие источники';
}

// Path: connect.noShizuku.steps.setupShizuku
class _TranslationsConnectNoShizukuStepsSetupShizukuRu extends TranslationsConnectNoShizukuStepsSetupShizukuEn {
	_TranslationsConnectNoShizukuStepsSetupShizukuRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройте Shizuku';
	@override String get description => 'Настройте Shizuku, следуя инструкциям в руководстве пользователя.\nРекомендуемый метод: "Запуск через отладку по Wi-Fi".';
	@override String get userManual => 'Руководство пользователя';
}

// Path: connect.noShizuku.steps.allowAccess
class _TranslationsConnectNoShizukuStepsAllowAccessRu extends TranslationsConnectNoShizukuStepsAllowAccessEn {
	_TranslationsConnectNoShizukuStepsAllowAccessRu._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Разрешить доступ';
	@override String get description => 'Нажмите кнопку ниже и, когда появится соответствующий запрос, разрешите NoMoreBackground доступ к Shizuku.';
	@override String get requestAccess => 'Запросить доступ';
}
