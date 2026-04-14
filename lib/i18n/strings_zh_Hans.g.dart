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
class TranslationsZhHans extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhHans({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhHans,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <zh-Hans>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsZhHans _root = this; // ignore: unused_field

	@override 
	TranslationsZhHans $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhHans(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsConnectZhHans connect = _TranslationsConnectZhHans._(_root);
	@override late final _TranslationsAppsZhHans apps = _TranslationsAppsZhHans._(_root);
}

// Path: connect
class _TranslationsConnectZhHans extends TranslationsConnectEn {
	_TranslationsConnectZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectHeaderZhHans header = _TranslationsConnectHeaderZhHans._(_root);
	@override late final _TranslationsConnectAdbZhHans adb = _TranslationsConnectAdbZhHans._(_root);
	@override String get refresh => '刷新';
	@override String get about => '关于此应用';
	@override String get aboutShortened => '关于';
	@override String get viewPrivacyPolicy => '浏览隐私政策';
	@override late final _TranslationsConnectNoAdbZhHans noAdb = _TranslationsConnectNoAdbZhHans._(_root);
	@override late final _TranslationsConnectNoShizukuZhHans noShizuku = _TranslationsConnectNoShizukuZhHans._(_root);
}

// Path: apps
class _TranslationsAppsZhHans extends TranslationsAppsEn {
	_TranslationsAppsZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAppsFilterZhHans filter = _TranslationsAppsFilterZhHans._(_root);
	@override late final _TranslationsAppsTitleZhHans title = _TranslationsAppsTitleZhHans._(_root);
	@override late final _TranslationsAppsArchiveZhHans archive = _TranslationsAppsArchiveZhHans._(_root);
	@override late final _TranslationsAppsMenuZhHans menu = _TranslationsAppsMenuZhHans._(_root);
	@override late final _TranslationsAppsPermissionsZhHans permissions = _TranslationsAppsPermissionsZhHans._(_root);
	@override late final _TranslationsAppsReviewZhHans review = _TranslationsAppsReviewZhHans._(_root);
}

// Path: connect.header
class _TranslationsConnectHeaderZhHans extends TranslationsConnectHeaderEn {
	_TranslationsConnectHeaderZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '连接到您的设备';
	@override String subtitle({required Object n}) => '已发现 ${n} 台设备';
}

// Path: connect.adb
class _TranslationsConnectAdbZhHans extends TranslationsConnectAdbEn {
	_TranslationsConnectAdbZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get fake => '假ADB';
	@override String get real => '真ADB';
}

// Path: connect.noAdb
class _TranslationsConnectNoAdbZhHans extends TranslationsConnectNoAdbEn {
	_TranslationsConnectNoAdbZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => '我们未能在您的系统内找到ADB。';
	@override String get adbIsRequired => '需要用ADB (Android Debug Bridge)将Android™设备连接到此应用。';
	@override late final _TranslationsConnectNoAdbMethodsZhHans methods = _TranslationsConnectNoAdbMethodsZhHans._(_root);
}

// Path: connect.noShizuku
class _TranslationsConnectNoShizukuZhHans extends TranslationsConnectNoShizukuEn {
	_TranslationsConnectNoShizukuZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => '我们未能连接到Shizuku。';
	@override String get whatIsShizuku => 'Shizuku是一个开源项目。该项目允许此应用在没有电脑与root权限的情况下控制其他应用。';
	@override String get followTheseSteps => '请遵循以下步骤以开始使用。';
	@override late final _TranslationsConnectNoShizukuStepsZhHans steps = _TranslationsConnectNoShizukuStepsZhHans._(_root);
	@override late final _TranslationsConnectNoShizukuUseRootZhHans useRoot = _TranslationsConnectNoShizukuUseRootZhHans._(_root);
}

// Path: apps.filter
class _TranslationsAppsFilterZhHans extends TranslationsAppsFilterEn {
	_TranslationsAppsFilterZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => '显示系统应用';
	@override String get showReviewedApps => '显示已检查应用';
}

// Path: apps.title
class _TranslationsAppsTitleZhHans extends TranslationsAppsTitleEn {
	_TranslationsAppsTitleZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => '所有应用';
	@override String get hideSystemApps => '用户应用';
}

// Path: apps.archive
class _TranslationsAppsArchiveZhHans extends TranslationsAppsArchiveEn {
	_TranslationsAppsArchiveZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get archive => '归档';
	@override String get archived => '已归档';
	@override String get unarchive => '请求取消归档';
	@override String notSupported({required Object installer}) => '不支持归档该应用，因为该应用是由"${installer}"安装的。';
}

// Path: apps.menu
class _TranslationsAppsMenuZhHans extends TranslationsAppsMenuEn {
	_TranslationsAppsMenuZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => '复制应用名';
	@override String get copyPackageName => '复制包名';
	@override String viewOnInstaller({required Object installer}) => '在${installer}上查看';
}

// Path: apps.permissions
class _TranslationsAppsPermissionsZhHans extends TranslationsAppsPermissionsEn {
	_TranslationsAppsPermissionsZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => '后台运行';
	@override String get backgroundData => '后台数据';
}

// Path: apps.review
class _TranslationsAppsReviewZhHans extends TranslationsAppsReviewEn {
	_TranslationsAppsReviewZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get reviewed => '检查';
	@override String get restore => '还原已检查的权限';
}

// Path: connect.noAdb.methods
class _TranslationsConnectNoAdbMethodsZhHans extends TranslationsConnectNoAdbMethodsEn {
	_TranslationsConnectNoAdbMethodsZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get summary => '有几种方式可以安装ADB。安装完ADB后，请重启此应用。';
	@override late final _TranslationsConnectNoAdbMethodsPackageManagerZhHans packageManager = _TranslationsConnectNoAdbMethodsPackageManagerZhHans._(_root);
	@override late final _TranslationsConnectNoAdbMethodsAndroidStudioZhHans androidStudio = _TranslationsConnectNoAdbMethodsAndroidStudioZhHans._(_root);
	@override late final _TranslationsConnectNoAdbMethodsStandaloneZhHans standalone = _TranslationsConnectNoAdbMethodsStandaloneZhHans._(_root);
}

// Path: connect.noShizuku.steps
class _TranslationsConnectNoShizukuStepsZhHans extends TranslationsConnectNoShizukuStepsEn {
	_TranslationsConnectNoShizukuStepsZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsConnectNoShizukuStepsDownloadShizukuZhHans downloadShizuku = _TranslationsConnectNoShizukuStepsDownloadShizukuZhHans._(_root);
	@override late final _TranslationsConnectNoShizukuStepsSetupShizukuZhHans setupShizuku = _TranslationsConnectNoShizukuStepsSetupShizukuZhHans._(_root);
	@override late final _TranslationsConnectNoShizukuStepsAllowAccessZhHans allowAccess = _TranslationsConnectNoShizukuStepsAllowAccessZhHans._(_root);
}

// Path: connect.noShizuku.useRoot
class _TranslationsConnectNoShizukuUseRootZhHans extends TranslationsConnectNoShizukuUseRootEn {
	_TranslationsConnectNoShizukuUseRootZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => '您的设备root了吗？';
	@override String get alternativeToShizuku => '已经root的设备无需通过Shizuku来访问系统API。';
	@override String get checkBoxToEnable => '勾选下方复选框以启用root模式，若root管理器弹出请求，请授予权限。';
	@override String get useRoot => '使用root';
	@override String get experimental => '实验性功能';
}

// Path: connect.noAdb.methods.packageManager
class _TranslationsConnectNoAdbMethodsPackageManagerZhHans extends TranslationsConnectNoAdbMethodsPackageManagerEn {
	_TranslationsConnectNoAdbMethodsPackageManagerZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '通过包管理器安装ADB';
	@override String get useFollowingCommand => '您可以在终端内通过以下命令安装ADB：';
	@override String get grantFlatpakPermission => '然后，授予NoMoreBackground 对您系统的adb的访问：';
}

// Path: connect.noAdb.methods.androidStudio
class _TranslationsConnectNoAdbMethodsAndroidStudioZhHans extends TranslationsConnectNoAdbMethodsAndroidStudioEn {
	_TranslationsConnectNoAdbMethodsAndroidStudioZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '使用Android Studio安装ADB';
	@override String get installPlatformTools => '如果您有Android Studio，您可使用SDK manager 来安装 Android SDK Platform Tools 包（该包包括了ADB）。';
}

// Path: connect.noAdb.methods.standalone
class _TranslationsConnectNoAdbMethodsStandaloneZhHans extends TranslationsConnectNoAdbMethodsStandaloneEn {
	_TranslationsConnectNoAdbMethodsStandaloneZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '单独安装ADB';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: '您可以通过官方 Android 开发者网站：'),
		link,
		const TextSpan(text: ' 下载单独的platform-tools。'),
	]);
	@override String get extractAndAddToPath => '下载该文件后，解压该压缩包并将platform-tools 目录添加到您系统的PATH 环境变量。';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _TranslationsConnectNoShizukuStepsDownloadShizukuZhHans extends TranslationsConnectNoShizukuStepsDownloadShizukuEn {
	_TranslationsConnectNoShizukuStepsDownloadShizukuZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '下载Shizuku';
	@override String get description => '从Google Play 或者其他官方来源下载Shizuku。';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => '其他来源';
}

// Path: connect.noShizuku.steps.setupShizuku
class _TranslationsConnectNoShizukuStepsSetupShizukuZhHans extends TranslationsConnectNoShizukuStepsSetupShizukuEn {
	_TranslationsConnectNoShizukuStepsSetupShizukuZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '建立Shizuku环境';
	@override String get description => '根据用户手册中的步骤即可建立Shizuku环境。\n我推荐采用“通过无线调试启动”方法建立环境。';
	@override String get userManual => '用户手册';
}

// Path: connect.noShizuku.steps.allowAccess
class _TranslationsConnectNoShizukuStepsAllowAccessZhHans extends TranslationsConnectNoShizukuStepsAllowAccessEn {
	_TranslationsConnectNoShizukuStepsAllowAccessZhHans._(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问';
	@override String get description => '当出现弹窗时，点击下方按键并允许NoMoreBackground 访问Shizuku。';
	@override String get requestAccess => '请求访问';
}
