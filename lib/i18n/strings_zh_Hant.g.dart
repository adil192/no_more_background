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
	@override late final Translations$connect$zh_Hant connect = Translations$connect$zh_Hant.internal(_root);
	@override late final Translations$apps$zh_Hant apps = Translations$apps$zh_Hant.internal(_root);
	@override late final Translations$logs$zh_Hant logs = Translations$logs$zh_Hant.internal(_root);
}

// Path: connect
class Translations$connect$zh_Hant extends Translations$connect$en {
	Translations$connect$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final Translations$connect$header$zh_Hant header = Translations$connect$header$zh_Hant.internal(_root);
	@override late final Translations$connect$adb$zh_Hant adb = Translations$connect$adb$zh_Hant.internal(_root);
	@override String get refresh => '重新整理';
	@override String get about => '關於此應用';
	@override String get aboutShortened => '關於';
	@override String get viewPrivacyPolicy => '瀏覽隱私政策';
	@override late final Translations$connect$noAdb$zh_Hant noAdb = Translations$connect$noAdb$zh_Hant.internal(_root);
	@override late final Translations$connect$noShizuku$zh_Hant noShizuku = Translations$connect$noShizuku$zh_Hant.internal(_root);
	@override String get viewLogsShortened => '日誌';
	@override String get viewLogs => '查看日誌';
}

// Path: apps
class Translations$apps$zh_Hant extends Translations$apps$en {
	Translations$apps$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final Translations$apps$filter$zh_Hant filter = Translations$apps$filter$zh_Hant.internal(_root);
	@override late final Translations$apps$title$zh_Hant title = Translations$apps$title$zh_Hant.internal(_root);
	@override late final Translations$apps$archive$zh_Hant archive = Translations$apps$archive$zh_Hant.internal(_root);
	@override late final Translations$apps$menu$zh_Hant menu = Translations$apps$menu$zh_Hant.internal(_root);
	@override late final Translations$apps$permissions$zh_Hant permissions = Translations$apps$permissions$zh_Hant.internal(_root);
	@override late final Translations$apps$review$zh_Hant review = Translations$apps$review$zh_Hant.internal(_root);
}

// Path: logs
class Translations$logs$zh_Hant extends Translations$logs$en {
	Translations$logs$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '日誌';
}

// Path: connect.header
class Translations$connect$header$zh_Hant extends Translations$connect$header$en {
	Translations$connect$header$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '連線到您的裝置';
	@override String subtitle({required Object n}) => '已發現 ${n} 個裝置';
}

// Path: connect.adb
class Translations$connect$adb$zh_Hant extends Translations$connect$adb$en {
	Translations$connect$adb$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get fake => '偽造 ADB';
	@override String get real => '真正的 ADB';
}

// Path: connect.noAdb
class Translations$connect$noAdb$zh_Hant extends Translations$connect$noAdb$en {
	Translations$connect$noAdb$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => '我們未在您的系統內搜尋到ADB。';
	@override String get adbIsRequired => '需要用ADB (Android Debug Bridge)將Android™裝置連線到此應用。';
	@override late final Translations$connect$noAdb$methods$zh_Hant methods = Translations$connect$noAdb$methods$zh_Hant.internal(_root);
}

// Path: connect.noShizuku
class Translations$connect$noShizuku$zh_Hant extends Translations$connect$noShizuku$en {
	Translations$connect$noShizuku$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => '我們未能連線到Shizuku。';
	@override late final Translations$connect$noShizuku$steps$zh_Hant steps = Translations$connect$noShizuku$steps$zh_Hant.internal(_root);
	@override late final Translations$connect$noShizuku$useRoot$zh_Hant useRoot = Translations$connect$noShizuku$useRoot$zh_Hant.internal(_root);
	@override String get whatIsShizuku => 'Shizuku 是一個開源專案，它讓我們無需電腦或 root 權限就能控制其他應用程式。';
	@override String get followTheseSteps => '請遵循以下步驟開始。';
}

// Path: apps.filter
class Translations$apps$filter$zh_Hant extends Translations$apps$filter$en {
	Translations$apps$filter$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => '顯示系統應用程式';
	@override String get showReviewedApps => '顯示已審核的應用程式';
}

// Path: apps.title
class Translations$apps$title$zh_Hant extends Translations$apps$title$en {
	Translations$apps$title$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get searchYourApps => '搜尋您的應用程式';
	@override String get yourApps => '您的應用程式';
}

// Path: apps.archive
class Translations$apps$archive$zh_Hant extends Translations$apps$archive$en {
	Translations$apps$archive$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get archive => '檔案';
	@override String get archived => '已歸檔';
	@override String get unarchive => '請求解封';
	@override String notSupported({required Object installer}) => '由於應用程式是由 "${installer}" 安裝的，因此不支援歸檔。';
}

// Path: apps.menu
class Translations$apps$menu$zh_Hant extends Translations$apps$menu$en {
	Translations$apps$menu$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final Translations$apps$menu$runInBackground$zh_Hant runInBackground = Translations$apps$menu$runInBackground$zh_Hant.internal(_root);
	@override late final Translations$apps$menu$backgroundData$zh_Hant backgroundData = Translations$apps$menu$backgroundData$zh_Hant.internal(_root);
	@override String get copyDisplayName => '複製顯示名稱';
	@override String get copyPackageName => '複製套件名稱';
	@override String viewOnInstaller({required Object installer}) => '關於 ${installer} 的看法';
	@override String get viewAppInfo => '查看應用程式資訊';
	@override String get viewAppInfoDesktop => '查看應用程式資訊（在裝置上）';
}

// Path: apps.permissions
class Translations$apps$permissions$zh_Hant extends Translations$apps$permissions$en {
	Translations$apps$permissions$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => '在背景運行';
	@override String get backgroundData => '背景資料';
	@override String get more => '更多';
}

// Path: apps.review
class Translations$apps$review$zh_Hant extends Translations$apps$review$en {
	Translations$apps$review$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get reviewed => '已審閱';
	@override String get restore => '還原已審核的權限';
}

// Path: connect.noAdb.methods
class Translations$connect$noAdb$methods$zh_Hant extends Translations$connect$noAdb$methods$en {
	Translations$connect$noAdb$methods$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get summary => '有幾種方式可以安裝ADB。安裝完ADB後，請重啟此應用。';
	@override late final Translations$connect$noAdb$methods$packageManager$zh_Hant packageManager = Translations$connect$noAdb$methods$packageManager$zh_Hant.internal(_root);
	@override late final Translations$connect$noAdb$methods$androidStudio$zh_Hant androidStudio = Translations$connect$noAdb$methods$androidStudio$zh_Hant.internal(_root);
	@override late final Translations$connect$noAdb$methods$standalone$zh_Hant standalone = Translations$connect$noAdb$methods$standalone$zh_Hant.internal(_root);
}

// Path: connect.noShizuku.steps
class Translations$connect$noShizuku$steps$zh_Hant extends Translations$connect$noShizuku$steps$en {
	Translations$connect$noShizuku$steps$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override late final Translations$connect$noShizuku$steps$downloadShizuku$zh_Hant downloadShizuku = Translations$connect$noShizuku$steps$downloadShizuku$zh_Hant.internal(_root);
	@override late final Translations$connect$noShizuku$steps$setupShizuku$zh_Hant setupShizuku = Translations$connect$noShizuku$steps$setupShizuku$zh_Hant.internal(_root);
	@override late final Translations$connect$noShizuku$steps$allowAccess$zh_Hant allowAccess = Translations$connect$noShizuku$steps$allowAccess$zh_Hant.internal(_root);
}

// Path: connect.noShizuku.useRoot
class Translations$connect$noShizuku$useRoot$zh_Hant extends Translations$connect$noShizuku$useRoot$en {
	Translations$connect$noShizuku$useRoot$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => '你被 Root 了嗎？';
	@override String get alternativeToShizuku => '已植入的設備不需要使用 Shizuku 才能存取系統 API。';
	@override String get checkBoxToEnable => '請勾選下方的方框以啟用 root，並在被要求時授予權限。';
	@override String get useRoot => '使用根';
	@override String get experimental => '實驗性';
}

// Path: apps.menu.runInBackground
class Translations$apps$menu$runInBackground$zh_Hant extends Translations$apps$menu$runInBackground$en {
	Translations$apps$menu$runInBackground$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => 'Android 的標準電池控制';
	@override String get reduced => '減少背景活動';
	@override String get auto => '允許預設背景活動';
	@override String get unrestricted => '允許無限制的背景活動';
	@override String get explanation => '這些是一個好的開始，但還不完全有效。';
}

// Path: apps.menu.backgroundData
class Translations$apps$menu$backgroundData$zh_Hant extends Translations$apps$menu$backgroundData$en {
	Translations$apps$menu$backgroundData$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '背景資料控制';
	@override String get explanation => '這僅影響背景的行動數據使用量。\nWi-Fi 和前台使用不受影響。';
	@override String get restricted => '啟用行動數據的背景使用';
}

// Path: connect.noAdb.methods.packageManager
class Translations$connect$noAdb$methods$packageManager$zh_Hant extends Translations$connect$noAdb$methods$packageManager$en {
	Translations$connect$noAdb$methods$packageManager$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '透過包管理器安裝ADB';
	@override String get useFollowingCommand => '您可以在終端內透過以下命令安裝ADB：';
	@override String get grantFlatpakPermission => '然後，授予NoMoreBackground 訪問系統adb：';
}

// Path: connect.noAdb.methods.androidStudio
class Translations$connect$noAdb$methods$androidStudio$zh_Hant extends Translations$connect$noAdb$methods$androidStudio$en {
	Translations$connect$noAdb$methods$androidStudio$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '透過Android Studio安裝ADB';
	@override String get installPlatformTools => '如果您有Android Studio，您可使用SDK manager 來安裝 Android SDK Platform Tools 包（該包包括了ADB）。';
}

// Path: connect.noAdb.methods.standalone
class Translations$connect$noAdb$methods$standalone$zh_Hant extends Translations$connect$noAdb$methods$standalone$en {
	Translations$connect$noAdb$methods$standalone$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

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

// Path: connect.noShizuku.steps.downloadShizuku
class Translations$connect$noShizuku$steps$downloadShizuku$zh_Hant extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	Translations$connect$noShizuku$steps$downloadShizuku$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '下載 Shizuku';
	@override String get description => '從 Google Play 或其他官方來源下載 Shizuku。';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => '其他來源';
}

// Path: connect.noShizuku.steps.setupShizuku
class Translations$connect$noShizuku$steps$setupShizuku$zh_Hant extends Translations$connect$noShizuku$steps$setupShizuku$en {
	Translations$connect$noShizuku$steps$setupShizuku$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '設定 Shizuku';
	@override String get description => '按照用戶手冊的說明設置 Shizuku。我推薦使用「通過無線除錯開始」的方法。';
	@override String get userManual => '使用者手冊';
}

// Path: connect.noShizuku.steps.allowAccess
class Translations$connect$noShizuku$steps$allowAccess$zh_Hant extends Translations$connect$noShizuku$steps$allowAccess$en {
	Translations$connect$noShizuku$steps$allowAccess$zh_Hant.internal(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	// Translations
	@override String get title => '允許存取';
	@override String get description => '請點擊下方的按鈕，並在提示時允許 NoMoreBackground 存取 Shizuku。';
	@override String get requestAccess => '請求存取權限';
}
