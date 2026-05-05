
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

class TranslationsZhHant extends Translations with BaseTranslations<AppLocale, Translations> {
	TranslationsZhHant({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhHant,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsZhHant _root = this; // ignore: unused_field

	@override 
	TranslationsZhHant $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhHant(meta: meta ?? this.$meta);

	@override late final _TranslationsConnectZhHant connect = _TranslationsConnectZhHant._(_root);
	@override late final _TranslationsAppsZhHant apps = _TranslationsAppsZhHant._(_root);
	@override late final _TranslationsLogsZhHant logs = _TranslationsLogsZhHant._(_root);
}

class _TranslationsConnectZhHant extends TranslationsConnectEn {
	_TranslationsConnectZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override late final _TranslationsConnectHeaderZhHant header = _TranslationsConnectHeaderZhHant._(_root);
	@override late final _TranslationsConnectAdbZhHant adb = _TranslationsConnectAdbZhHant._(_root);
	@override String get refresh => '重新整理';
	@override String get about => '關於此應用';
	@override String get aboutShortened => '關於';
	@override String get viewPrivacyPolicy => '瀏覽隱私政策';
	@override late final _TranslationsConnectNoAdbZhHant noAdb = _TranslationsConnectNoAdbZhHant._(_root);
	@override late final _TranslationsConnectNoShizukuZhHant noShizuku = _TranslationsConnectNoShizukuZhHant._(_root);
	@override String get viewLogsShortened => '日誌';
	@override String get viewLogs => '查看日誌';
}

class _TranslationsAppsZhHant extends TranslationsAppsEn {
	_TranslationsAppsZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override late final _TranslationsAppsFilterZhHant filter = _TranslationsAppsFilterZhHant._(_root);
	@override late final _TranslationsAppsTitleZhHant title = _TranslationsAppsTitleZhHant._(_root);
	@override late final _TranslationsAppsArchiveZhHant archive = _TranslationsAppsArchiveZhHant._(_root);
	@override late final _TranslationsAppsMenuZhHant menu = _TranslationsAppsMenuZhHant._(_root);
	@override late final _TranslationsAppsPermissionsZhHant permissions = _TranslationsAppsPermissionsZhHant._(_root);
	@override late final _TranslationsAppsReviewZhHant review = _TranslationsAppsReviewZhHant._(_root);
}

class _TranslationsLogsZhHant extends TranslationsLogsEn {
	_TranslationsLogsZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '日誌';
}

class _TranslationsConnectHeaderZhHant extends TranslationsConnectHeaderEn {
	_TranslationsConnectHeaderZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '連線到您的裝置';
	@override String subtitle({required Object n}) => '已發現 ${n} 個裝置';
}

class _TranslationsConnectAdbZhHant extends TranslationsConnectAdbEn {
	_TranslationsConnectAdbZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get fake => '偽造 ADB';
	@override String get real => '真正的 ADB';
}

class _TranslationsConnectNoAdbZhHant extends TranslationsConnectNoAdbEn {
	_TranslationsConnectNoAdbZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get noAdbFound => '我們未在您的系統內搜尋到ADB。';
	@override String get adbIsRequired => '需要用ADB (Android Debug Bridge)將Android™裝置連線到此應用。';
	@override late final _TranslationsConnectNoAdbMethodsZhHant methods = _TranslationsConnectNoAdbMethodsZhHant._(_root);
}

class _TranslationsConnectNoShizukuZhHant extends TranslationsConnectNoShizukuEn {
	_TranslationsConnectNoShizukuZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get noShizukuFound => '我們未能連線到Shizuku。';
	@override late final _TranslationsConnectNoShizukuStepsZhHant steps = _TranslationsConnectNoShizukuStepsZhHant._(_root);
	@override late final _TranslationsConnectNoShizukuUseRootZhHant useRoot = _TranslationsConnectNoShizukuUseRootZhHant._(_root);
	@override String get whatIsShizuku => 'Shizuku 是一個開源專案，它讓我們無需電腦或 root 權限就能控制其他應用程式。';
	@override String get followTheseSteps => '請遵循以下步驟開始。';
}

class _TranslationsAppsFilterZhHant extends TranslationsAppsFilterEn {
	_TranslationsAppsFilterZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get showSystemApps => '顯示系統應用程式';
	@override String get showReviewedApps => '顯示已審核的應用程式';
}

class _TranslationsAppsTitleZhHant extends TranslationsAppsTitleEn {
	_TranslationsAppsTitleZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get showSystemApps => '所有應用程式';
	@override String get hideSystemApps => '使用者應用程式';
}

class _TranslationsAppsArchiveZhHant extends TranslationsAppsArchiveEn {
	_TranslationsAppsArchiveZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get archive => '檔案';
	@override String get archived => '已歸檔';
	@override String get unarchive => '請求解封';
	@override String notSupported({required Object installer}) => '由於應用程式是由 "${installer}" 安裝的，因此不支援歸檔。';
}

class _TranslationsAppsMenuZhHant extends TranslationsAppsMenuEn {
	_TranslationsAppsMenuZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get copyDisplayName => '複製顯示名稱';
	@override String get copyPackageName => '複製套件名稱';
	@override String viewOnInstaller({required Object installer}) => '關於 ${installer} 的看法';
}

class _TranslationsAppsPermissionsZhHant extends TranslationsAppsPermissionsEn {
	_TranslationsAppsPermissionsZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get runInBackground => '在背景運行';
	@override String get backgroundData => '背景資料';
}

class _TranslationsAppsReviewZhHant extends TranslationsAppsReviewEn {
	_TranslationsAppsReviewZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get reviewed => '已審閱';
	@override String get restore => '還原已審核的權限';
}

class _TranslationsConnectNoAdbMethodsZhHant extends TranslationsConnectNoAdbMethodsEn {
	_TranslationsConnectNoAdbMethodsZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get summary => '有幾種方式可以安裝ADB。安裝完ADB後，請重啟此應用。';
	@override late final _TranslationsConnectNoAdbMethodsPackageManagerZhHant packageManager = _TranslationsConnectNoAdbMethodsPackageManagerZhHant._(_root);
	@override late final _TranslationsConnectNoAdbMethodsAndroidStudioZhHant androidStudio = _TranslationsConnectNoAdbMethodsAndroidStudioZhHant._(_root);
	@override late final _TranslationsConnectNoAdbMethodsStandaloneZhHant standalone = _TranslationsConnectNoAdbMethodsStandaloneZhHant._(_root);
}

class _TranslationsConnectNoShizukuStepsZhHant extends TranslationsConnectNoShizukuStepsEn {
	_TranslationsConnectNoShizukuStepsZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override late final _TranslationsConnectNoShizukuStepsDownloadShizukuZhHant downloadShizuku = _TranslationsConnectNoShizukuStepsDownloadShizukuZhHant._(_root);
	@override late final _TranslationsConnectNoShizukuStepsSetupShizukuZhHant setupShizuku = _TranslationsConnectNoShizukuStepsSetupShizukuZhHant._(_root);
	@override late final _TranslationsConnectNoShizukuStepsAllowAccessZhHant allowAccess = _TranslationsConnectNoShizukuStepsAllowAccessZhHant._(_root);
}

class _TranslationsConnectNoShizukuUseRootZhHant extends TranslationsConnectNoShizukuUseRootEn {
	_TranslationsConnectNoShizukuUseRootZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get areYouRooted => '你被 Root 了嗎？';
	@override String get alternativeToShizuku => '已植入的設備不需要使用 Shizuku 才能存取系統 API。';
	@override String get checkBoxToEnable => '請勾選下方的方框以啟用 root，並在被要求時授予權限。';
	@override String get useRoot => '使用根';
	@override String get experimental => '實驗性';
}

class _TranslationsConnectNoAdbMethodsPackageManagerZhHant extends TranslationsConnectNoAdbMethodsPackageManagerEn {
	_TranslationsConnectNoAdbMethodsPackageManagerZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '透過包管理器安裝ADB';
	@override String get useFollowingCommand => '您可以在終端內透過以下命令安裝ADB：';
	@override String get grantFlatpakPermission => '然後，授予NoMoreBackground 訪問系統adb：';
}

class _TranslationsConnectNoAdbMethodsAndroidStudioZhHant extends TranslationsConnectNoAdbMethodsAndroidStudioEn {
	_TranslationsConnectNoAdbMethodsAndroidStudioZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '透過Android Studio安裝ADB';
	@override String get installPlatformTools => '如果您有Android Studio，您可使用SDK manager 來安裝 Android SDK Platform Tools 包（該包包括了ADB）。';
}

class _TranslationsConnectNoAdbMethodsStandaloneZhHant extends TranslationsConnectNoAdbMethodsStandaloneEn {
	_TranslationsConnectNoAdbMethodsStandaloneZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '單獨安裝ADB';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: '您可以透過官方 Android 開發者網站：'),
		link,
		const TextSpan(text: ' 下載單獨的platform-tools。'),
	]);
	@override String get extractAndAddToPath => '下載該檔案後，解壓該檔案並將platform-tools 目錄新增到您系統的PATH環境變數。';
}

class _TranslationsConnectNoShizukuStepsDownloadShizukuZhHant extends TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	_TranslationsConnectNoShizukuStepsDownloadShizukuZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '下載 Shizuku';
	@override String get description => '從 Google Play 或其他官方來源下載 Shizuku。';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => '其他來源';
}

class _TranslationsConnectNoShizukuStepsSetupShizukuZhHant extends TranslationsConnectNoShizukuStepsSetupShizukuEn {
	_TranslationsConnectNoShizukuStepsSetupShizukuZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '設定 Shizuku';
	@override String get description => '按照用戶手冊的說明設置 Shizuku。我推薦使用「通過無線除錯開始」的方法。';
	@override String get userManual => '使用者手冊';
}

class _TranslationsConnectNoShizukuStepsAllowAccessZhHant extends TranslationsConnectNoShizukuStepsAllowAccessEn {
	_TranslationsConnectNoShizukuStepsAllowAccessZhHant._(TranslationsZhHant root) : this._root = root, super.internal(root);

	final TranslationsZhHant _root; // ignore: unused_field

	@override String get title => '允許存取';
	@override String get description => '請點擊下方的按鈕，並在提示時允許 NoMoreBackground 存取 Shizuku。';
	@override String get requestAccess => '請求存取權限';
}
