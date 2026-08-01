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
	@override late final _Translations$connect$ru connect = _Translations$connect$ru._(_root);
	@override late final _Translations$apps$ru apps = _Translations$apps$ru._(_root);
	@override late final _Translations$logs$ru logs = _Translations$logs$ru._(_root);
}

// Path: connect
class _Translations$connect$ru extends Translations$connect$en {
	_Translations$connect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$header$ru header = _Translations$connect$header$ru._(_root);
	@override late final _Translations$connect$adb$ru adb = _Translations$connect$adb$ru._(_root);
	@override String get refresh => 'Обновить';
	@override String get about => 'О приложении';
	@override String get aboutShortened => 'О программе';
	@override String get viewPrivacyPolicy => 'Посмотреть политику конфиденциальности';
	@override late final _Translations$connect$noAdb$ru noAdb = _Translations$connect$noAdb$ru._(_root);
	@override late final _Translations$connect$noShizuku$ru noShizuku = _Translations$connect$noShizuku$ru._(_root);
	@override String get viewLogsShortened => 'Логи';
	@override String get viewLogs => 'Открыть логи';
}

// Path: apps
class _Translations$apps$ru extends Translations$apps$en {
	_Translations$apps$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$filter$ru filter = _Translations$apps$filter$ru._(_root);
	@override late final _Translations$apps$title$ru title = _Translations$apps$title$ru._(_root);
	@override late final _Translations$apps$archive$ru archive = _Translations$apps$archive$ru._(_root);
	@override late final _Translations$apps$menu$ru menu = _Translations$apps$menu$ru._(_root);
	@override late final _Translations$apps$permissions$ru permissions = _Translations$apps$permissions$ru._(_root);
	@override late final _Translations$apps$review$ru review = _Translations$apps$review$ru._(_root);
}

// Path: logs
class _Translations$logs$ru extends Translations$logs$en {
	_Translations$logs$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Логи';
}

// Path: connect.header
class _Translations$connect$header$ru extends Translations$connect$header$en {
	_Translations$connect$header$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Подключите ваше устройство';
	@override String subtitle({required Object n}) => '${n} устройств найдено';
}

// Path: connect.adb
class _Translations$connect$adb$ru extends Translations$connect$adb$en {
	_Translations$connect$adb$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get fake => 'Fake ADB';
	@override String get real => 'Real ADB';
}

// Path: connect.noAdb
class _Translations$connect$noAdb$ru extends Translations$connect$noAdb$en {
	_Translations$connect$noAdb$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'ADB в вашей системе не найден.';
	@override String get adbIsRequired => 'Для подключения вашего устройства Android™ к этому приложению требуется ADB (Android Debug Bridge).';
	@override late final _Translations$connect$noAdb$methods$ru methods = _Translations$connect$noAdb$methods$ru._(_root);
}

// Path: connect.noShizuku
class _Translations$connect$noShizuku$ru extends Translations$connect$noShizuku$en {
	_Translations$connect$noShizuku$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'Невозможно соединиться с Shizuku.';
	@override String get whatIsShizuku => 'Shizuku — это проект с открытым исходным кодом, который позволяет управлять другими приложениями без помощи компьютера или получения root-прав.';
	@override String get followTheseSteps => 'Выполните следующие шаги, чтобы начать.';
	@override late final _Translations$connect$noShizuku$steps$ru steps = _Translations$connect$noShizuku$steps$ru._(_root);
	@override late final _Translations$connect$noShizuku$useRoot$ru useRoot = _Translations$connect$noShizuku$useRoot$ru._(_root);
}

// Path: apps.filter
class _Translations$apps$filter$ru extends Translations$apps$filter$en {
	_Translations$apps$filter$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Показать системные приложения';
	@override String get showReviewedApps => 'Показать обработанные приложения';
}

// Path: apps.title
class _Translations$apps$title$ru extends Translations$apps$title$en {
	_Translations$apps$title$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get searchYourApps => 'Поиск в ваших приложениях';
	@override String get yourApps => 'Ваши приложения';
}

// Path: apps.archive
class _Translations$apps$archive$ru extends Translations$apps$archive$en {
	_Translations$apps$archive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Архив';
	@override String get archived => 'Архивированные';
	@override String get unarchive => 'Запросить разархивацию';
	@override String notSupported({required Object installer}) => 'Архивирование не поддерживается, поскольку приложение было установлено с помощью "${installer}".';
}

// Path: apps.menu
class _Translations$apps$menu$ru extends Translations$apps$menu$en {
	_Translations$apps$menu$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'Копировать отображаемое имя';
	@override String get copyPackageName => 'Скопировать имя пакета';
	@override String get viewAppInfo => 'О приложении';
	@override String get viewAppInfoDesktop => 'О приложении (на устройстве)';
	@override String viewOnInstaller({required Object installer}) => 'Посмотреть в ${installer}';
	@override late final _Translations$apps$menu$runInBackground$ru runInBackground = _Translations$apps$menu$runInBackground$ru._(_root);
	@override late final _Translations$apps$menu$backgroundData$ru backgroundData = _Translations$apps$menu$backgroundData$ru._(_root);
}

// Path: apps.permissions
class _Translations$apps$permissions$ru extends Translations$apps$permissions$en {
	_Translations$apps$permissions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Работа в фоне';
	@override String get backgroundData => 'Фоновые данные';
	@override String get more => 'Больше';
}

// Path: apps.review
class _Translations$apps$review$ru extends Translations$apps$review$en {
	_Translations$apps$review$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Обработано';
	@override String get restore => 'Восстановить проверенные разрешения';
}

// Path: connect.noAdb.methods
class _Translations$connect$noAdb$methods$ru extends Translations$connect$noAdb$methods$en {
	_Translations$connect$noAdb$methods$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get summary => 'Существует несколько способов установки ADB. После установки ADB перезапустите это приложение.';
	@override late final _Translations$connect$noAdb$methods$packageManager$ru packageManager = _Translations$connect$noAdb$methods$packageManager$ru._(_root);
	@override late final _Translations$connect$noAdb$methods$androidStudio$ru androidStudio = _Translations$connect$noAdb$methods$androidStudio$ru._(_root);
	@override late final _Translations$connect$noAdb$methods$standalone$ru standalone = _Translations$connect$noAdb$methods$standalone$ru._(_root);
}

// Path: connect.noShizuku.steps
class _Translations$connect$noShizuku$steps$ru extends Translations$connect$noShizuku$steps$en {
	_Translations$connect$noShizuku$steps$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$downloadShizuku$ru downloadShizuku = _Translations$connect$noShizuku$steps$downloadShizuku$ru._(_root);
	@override late final _Translations$connect$noShizuku$steps$setupShizuku$ru setupShizuku = _Translations$connect$noShizuku$steps$setupShizuku$ru._(_root);
	@override late final _Translations$connect$noShizuku$steps$allowAccess$ru allowAccess = _Translations$connect$noShizuku$steps$allowAccess$ru._(_root);
}

// Path: connect.noShizuku.useRoot
class _Translations$connect$noShizuku$useRoot$ru extends Translations$connect$noShizuku$useRoot$en {
	_Translations$connect$noShizuku$useRoot$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Устройство имеет root-доступ?';
	@override String get alternativeToShizuku => 'Устройствам с root-правами для доступа к системным API не требуется Shizuku.';
	@override String get checkBoxToEnable => 'Поставьте галочку в поле ниже, чтобы предоставить root-права, и дайте необходимые разрешения при запросе.';
	@override String get useRoot => 'Использовать root';
	@override String get experimental => 'ЭКСПЕРИМЕНТАЛЬНО';
}

// Path: apps.menu.runInBackground
class _Translations$apps$menu$runInBackground$ru extends Translations$apps$menu$runInBackground$en {
	_Translations$apps$menu$runInBackground$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get reduced => 'Уменьшить фоновую активность';
	@override String get auto => 'Разрешить фоновую активность по умолчанию';
	@override String get unrestricted => 'Разрешить фоновую активность без ограничений';
	@override String get title => 'Стандартные элементы управления батареей Android';
	@override String get explanation => 'Это хорошее начало, но не совсем эффективно.';
}

// Path: apps.menu.backgroundData
class _Translations$apps$menu$backgroundData$ru extends Translations$apps$menu$backgroundData$en {
	_Translations$apps$menu$backgroundData$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Контроль фоновых данных';
	@override String get explanation => 'Это влияет только на использование мобильных данных в фоновом режиме. Wi-Fi и использование в активном режиме не затронуты.';
	@override String get restricted => 'Включить фоновое использование мобильных данных';
}

// Path: connect.noAdb.methods.packageManager
class _Translations$connect$noAdb$methods$packageManager$ru extends Translations$connect$noAdb$methods$packageManager$en {
	_Translations$connect$noAdb$methods$packageManager$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Установка ADB через менеджер пакетов';
	@override String get useFollowingCommand => 'Вы можете установить ADB, используя следующую команду в терминале:';
	@override String get grantFlatpakPermission => 'Затем предоставьте NoMoreBackground доступ к ADB вашей системы:';
}

// Path: connect.noAdb.methods.androidStudio
class _Translations$connect$noAdb$methods$androidStudio$ru extends Translations$connect$noAdb$methods$androidStudio$en {
	_Translations$connect$noAdb$methods$androidStudio$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Установка ADB через Android Studio';
	@override String get installPlatformTools => 'Если у вас установлена Android Studio, вы можете использовать её менеджер SDK для установки пакета Android SDK Platform Tools, который включает ADB.';
}

// Path: connect.noAdb.methods.standalone
class _Translations$connect$noAdb$methods$standalone$ru extends Translations$connect$noAdb$methods$standalone$en {
	_Translations$connect$noAdb$methods$standalone$ru._(TranslationsRu root) : this._root = root, super.internal(root);

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
class _Translations$connect$noShizuku$steps$downloadShizuku$ru extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	_Translations$connect$noShizuku$steps$downloadShizuku$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Скачать Shizuku';
	@override String get description => 'Скачайте Shizuku из Google Play или другого официального источника.';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => 'Другие источники';
}

// Path: connect.noShizuku.steps.setupShizuku
class _Translations$connect$noShizuku$steps$setupShizuku$ru extends Translations$connect$noShizuku$steps$setupShizuku$en {
	_Translations$connect$noShizuku$steps$setupShizuku$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройте Shizuku';
	@override String get description => 'Настройте Shizuku, следуя инструкциям в руководстве пользователя.\nРекомендуемый метод: "Запуск через отладку по Wi-Fi".';
	@override String get userManual => 'Руководство пользователя';
}

// Path: connect.noShizuku.steps.allowAccess
class _Translations$connect$noShizuku$steps$allowAccess$ru extends Translations$connect$noShizuku$steps$allowAccess$en {
	_Translations$connect$noShizuku$steps$allowAccess$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Разрешить доступ';
	@override String get description => 'Нажмите кнопку ниже и, когда появится соответствующий запрос, разрешите NoMoreBackground доступ к Shizuku.';
	@override String get requestAccess => 'Запросить доступ';
}
