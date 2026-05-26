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
	@override late final Translations$connect$zh_Hans connect = Translations$connect$zh_Hans.internal(_root);
	@override late final Translations$apps$zh_Hans apps = Translations$apps$zh_Hans.internal(_root);
	@override late final Translations$logs$zh_Hans logs = Translations$logs$zh_Hans.internal(_root);
}

// Path: connect
class Translations$connect$zh_Hans extends Translations$connect$en {
	Translations$connect$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override late final Translations$connect$header$zh_Hans header = Translations$connect$header$zh_Hans.internal(_root);
	@override late final Translations$connect$adb$zh_Hans adb = Translations$connect$adb$zh_Hans.internal(_root);
	@override String get refresh => '刷新';
	@override String get about => '关于此应用';
	@override String get aboutShortened => '关于';
	@override String get viewPrivacyPolicy => '浏览隐私政策';
	@override late final Translations$connect$noAdb$zh_Hans noAdb = Translations$connect$noAdb$zh_Hans.internal(_root);
	@override late final Translations$connect$noShizuku$zh_Hans noShizuku = Translations$connect$noShizuku$zh_Hans.internal(_root);
	@override String get viewLogsShortened => '日志';
	@override String get viewLogs => '查看日志';
}

// Path: apps
class Translations$apps$zh_Hans extends Translations$apps$en {
	Translations$apps$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override late final Translations$apps$filter$zh_Hans filter = Translations$apps$filter$zh_Hans.internal(_root);
	@override late final Translations$apps$title$zh_Hans title = Translations$apps$title$zh_Hans.internal(_root);
	@override late final Translations$apps$archive$zh_Hans archive = Translations$apps$archive$zh_Hans.internal(_root);
	@override late final Translations$apps$menu$zh_Hans menu = Translations$apps$menu$zh_Hans.internal(_root);
	@override late final Translations$apps$permissions$zh_Hans permissions = Translations$apps$permissions$zh_Hans.internal(_root);
	@override late final Translations$apps$review$zh_Hans review = Translations$apps$review$zh_Hans.internal(_root);
}

// Path: logs
class Translations$logs$zh_Hans extends Translations$logs$en {
	Translations$logs$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '日志';
}

// Path: connect.header
class Translations$connect$header$zh_Hans extends Translations$connect$header$en {
	Translations$connect$header$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '连接到您的设备';
	@override String subtitle({required Object n}) => '已发现 ${n} 台设备';
}

// Path: connect.adb
class Translations$connect$adb$zh_Hans extends Translations$connect$adb$en {
	Translations$connect$adb$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get fake => '假ADB';
	@override String get real => '真ADB';
}

// Path: connect.noAdb
class Translations$connect$noAdb$zh_Hans extends Translations$connect$noAdb$en {
	Translations$connect$noAdb$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => '我们未能在您的系统内找到ADB。';
	@override String get adbIsRequired => '需要用ADB (Android Debug Bridge)将Android™设备连接到此应用。';
	@override late final Translations$connect$noAdb$methods$zh_Hans methods = Translations$connect$noAdb$methods$zh_Hans.internal(_root);
}

// Path: connect.noShizuku
class Translations$connect$noShizuku$zh_Hans extends Translations$connect$noShizuku$en {
	Translations$connect$noShizuku$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => '我们未能连接到Shizuku。';
	@override String get whatIsShizuku => 'Shizuku是一个开放源代码项目。该项目允许此应用在没有电脑与root访问的情况下控制其他应用。';
	@override String get followTheseSteps => '请遵循以下步骤以开始使用。';
	@override late final Translations$connect$noShizuku$steps$zh_Hans steps = Translations$connect$noShizuku$steps$zh_Hans.internal(_root);
	@override late final Translations$connect$noShizuku$useRoot$zh_Hans useRoot = Translations$connect$noShizuku$useRoot$zh_Hans.internal(_root);
}

// Path: apps.filter
class Translations$apps$filter$zh_Hans extends Translations$apps$filter$en {
	Translations$apps$filter$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => '显示系统应用';
	@override String get showReviewedApps => '显示已检查应用';
}

// Path: apps.title
class Translations$apps$title$zh_Hans extends Translations$apps$title$en {
	Translations$apps$title$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => '所有应用';
	@override String get hideSystemApps => '用户应用';
}

// Path: apps.archive
class Translations$apps$archive$zh_Hans extends Translations$apps$archive$en {
	Translations$apps$archive$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get archive => '归档';
	@override String get archived => '已归档';
	@override String get unarchive => '请求取消归档';
	@override String notSupported({required Object installer}) => '不支持归档该应用，因为该应用是由"${installer}"安装的。';
}

// Path: apps.menu
class Translations$apps$menu$zh_Hans extends Translations$apps$menu$en {
	Translations$apps$menu$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => '复制应用名';
	@override String get copyPackageName => '复制包名';
	@override String viewOnInstaller({required Object installer}) => '在${installer}上查看';
}

// Path: apps.permissions
class Translations$apps$permissions$zh_Hans extends Translations$apps$permissions$en {
	Translations$apps$permissions$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => '后台运行';
	@override String get backgroundData => '后台数据';
}

// Path: apps.review
class Translations$apps$review$zh_Hans extends Translations$apps$review$en {
	Translations$apps$review$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get reviewed => '检查';
	@override String get restore => '还原已检查的权限';
}

// Path: connect.noAdb.methods
class Translations$connect$noAdb$methods$zh_Hans extends Translations$connect$noAdb$methods$en {
	Translations$connect$noAdb$methods$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get summary => '有几种方式可以安装ADB。安装完ADB后，请重启此应用。';
	@override late final Translations$connect$noAdb$methods$packageManager$zh_Hans packageManager = Translations$connect$noAdb$methods$packageManager$zh_Hans.internal(_root);
	@override late final Translations$connect$noAdb$methods$androidStudio$zh_Hans androidStudio = Translations$connect$noAdb$methods$androidStudio$zh_Hans.internal(_root);
	@override late final Translations$connect$noAdb$methods$standalone$zh_Hans standalone = Translations$connect$noAdb$methods$standalone$zh_Hans.internal(_root);
}

// Path: connect.noShizuku.steps
class Translations$connect$noShizuku$steps$zh_Hans extends Translations$connect$noShizuku$steps$en {
	Translations$connect$noShizuku$steps$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override late final Translations$connect$noShizuku$steps$downloadShizuku$zh_Hans downloadShizuku = Translations$connect$noShizuku$steps$downloadShizuku$zh_Hans.internal(_root);
	@override late final Translations$connect$noShizuku$steps$setupShizuku$zh_Hans setupShizuku = Translations$connect$noShizuku$steps$setupShizuku$zh_Hans.internal(_root);
	@override late final Translations$connect$noShizuku$steps$allowAccess$zh_Hans allowAccess = Translations$connect$noShizuku$steps$allowAccess$zh_Hans.internal(_root);
}

// Path: connect.noShizuku.useRoot
class Translations$connect$noShizuku$useRoot$zh_Hans extends Translations$connect$noShizuku$useRoot$en {
	Translations$connect$noShizuku$useRoot$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => '您的设备root了吗？';
	@override String get alternativeToShizuku => '已经root的设备无需通过Shizuku来访问系统API。';
	@override String get checkBoxToEnable => '勾选下方复选框以启用root模式，若root管理器弹出请求，请授予权限。';
	@override String get useRoot => '使用root';
	@override String get experimental => '实验性功能';
}

// Path: connect.noAdb.methods.packageManager
class Translations$connect$noAdb$methods$packageManager$zh_Hans extends Translations$connect$noAdb$methods$packageManager$en {
	Translations$connect$noAdb$methods$packageManager$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '通过包管理器安装ADB';
	@override String get useFollowingCommand => '您可以在终端内通过以下命令安装ADB：';
	@override String get grantFlatpakPermission => '然后，授予NoMoreBackground 访问系统adb：';
}

// Path: connect.noAdb.methods.androidStudio
class Translations$connect$noAdb$methods$androidStudio$zh_Hans extends Translations$connect$noAdb$methods$androidStudio$en {
	Translations$connect$noAdb$methods$androidStudio$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '通过Android Studio安装ADB';
	@override String get installPlatformTools => '如果您有Android Studio，您可使用SDK manager 来安装 Android SDK Platform Tools 包（该包包括了ADB）。';
}

// Path: connect.noAdb.methods.standalone
class Translations$connect$noAdb$methods$standalone$zh_Hans extends Translations$connect$noAdb$methods$standalone$en {
	Translations$connect$noAdb$methods$standalone$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

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
class Translations$connect$noShizuku$steps$downloadShizuku$zh_Hans extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	Translations$connect$noShizuku$steps$downloadShizuku$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '下载Shizuku';
	@override String get description => '从Google Play 或者其他官方来源下载Shizuku。';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => '其他来源';
}

// Path: connect.noShizuku.steps.setupShizuku
class Translations$connect$noShizuku$steps$setupShizuku$zh_Hans extends Translations$connect$noShizuku$steps$setupShizuku$en {
	Translations$connect$noShizuku$steps$setupShizuku$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '建立Shizuku环境';
	@override String get description => '根据用户手册中的步骤即可建立Shizuku环境。\n我推荐采用“通过无线调试启动”方法建立环境。';
	@override String get userManual => '用户手册';
}

// Path: connect.noShizuku.steps.allowAccess
class Translations$connect$noShizuku$steps$allowAccess$zh_Hans extends Translations$connect$noShizuku$steps$allowAccess$en {
	Translations$connect$noShizuku$steps$allowAccess$zh_Hans.internal(TranslationsZhHans root) : this._root = root, super.internal(root);

	final TranslationsZhHans _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问';
	@override String get description => '当出现弹窗时，点击下方按键并允许NoMoreBackground 访问Shizuku。';
	@override String get requestAccess => '请求访问';
}
