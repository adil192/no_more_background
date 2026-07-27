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
class TranslationsAr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$connect$ar connect = _Translations$connect$ar._(_root);
	@override late final _Translations$apps$ar apps = _Translations$apps$ar._(_root);
	@override late final _Translations$logs$ar logs = _Translations$logs$ar._(_root);
}

// Path: connect
class _Translations$connect$ar extends Translations$connect$en {
	_Translations$connect$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$header$ar header = _Translations$connect$header$ar._(_root);
	@override late final _Translations$connect$adb$ar adb = _Translations$connect$adb$ar._(_root);
	@override String get refresh => 'إعادة إنعاش';
	@override String get about => 'بخصوص هذا التطبيق';
	@override String get aboutShortened => 'بخصوص';
	@override String get viewPrivacyPolicy => 'عرض سياسة الخصوصية';
	@override late final _Translations$connect$noAdb$ar noAdb = _Translations$connect$noAdb$ar._(_root);
	@override late final _Translations$connect$noShizuku$ar noShizuku = _Translations$connect$noShizuku$ar._(_root);
	@override String get viewLogsShortened => 'سجلات';
	@override String get viewLogs => 'عرض السجلات';
}

// Path: apps
class _Translations$apps$ar extends Translations$apps$en {
	_Translations$apps$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$filter$ar filter = _Translations$apps$filter$ar._(_root);
	@override late final _Translations$apps$title$ar title = _Translations$apps$title$ar._(_root);
	@override late final _Translations$apps$archive$ar archive = _Translations$apps$archive$ar._(_root);
	@override late final _Translations$apps$menu$ar menu = _Translations$apps$menu$ar._(_root);
	@override late final _Translations$apps$permissions$ar permissions = _Translations$apps$permissions$ar._(_root);
	@override late final _Translations$apps$review$ar review = _Translations$apps$review$ar._(_root);
}

// Path: logs
class _Translations$logs$ar extends Translations$logs$en {
	_Translations$logs$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سجلات';
}

// Path: connect.header
class _Translations$connect$header$ar extends Translations$connect$header$en {
	_Translations$connect$header$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'وصل جهازك';
	@override String subtitle({required Object n}) => 'تم إيجاد ${n} من الأجهزة';
}

// Path: connect.adb
class _Translations$connect$adb$ar extends Translations$connect$adb$en {
	_Translations$connect$adb$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get fake => 'ADB مزيف';
	@override String get real => 'ADB حقيقي';
}

// Path: connect.noAdb
class _Translations$connect$noAdb$ar extends Translations$connect$noAdb$en {
	_Translations$connect$noAdb$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'لا يمكننا إيجاد ADB على نظامك.';
	@override String get adbIsRequired => 'ADB (جسر تصحيح الأندرويد) هو يوصل جهاز الأندرويد™ بهاذا التطبيق.';
	@override late final _Translations$connect$noAdb$methods$ar methods = _Translations$connect$noAdb$methods$ar._(_root);
}

// Path: connect.noShizuku
class _Translations$connect$noShizuku$ar extends Translations$connect$noShizuku$en {
	_Translations$connect$noShizuku$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get noShizukuFound => 'لا يمكننا أن نتصل بShizuku.';
	@override String get whatIsShizuku => 'Shizuku هو مشروع مفتوح المصدر يذرنا نتحكم بالتطبيقات الأخرى دون الحاجة لحاسوب أو صلاحيات الroot (جذر).';
	@override String get followTheseSteps => 'إتبع هذه التعليمات لتبدأ.';
	@override late final _Translations$connect$noShizuku$steps$ar steps = _Translations$connect$noShizuku$steps$ar._(_root);
	@override late final _Translations$connect$noShizuku$useRoot$ar useRoot = _Translations$connect$noShizuku$useRoot$ar._(_root);
}

// Path: apps.filter
class _Translations$apps$filter$ar extends Translations$apps$filter$en {
	_Translations$apps$filter$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'عرض تطبيقات النظام';
	@override String get showReviewedApps => 'عرض التطبيقات التي تمت مراجعتها';
}

// Path: apps.title
class _Translations$apps$title$ar extends Translations$apps$title$en {
	_Translations$apps$title$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get searchYourApps => 'ابحث في تطبيقاتك';
	@override String get yourApps => 'تطبيقاتك';
}

// Path: apps.archive
class _Translations$apps$archive$ar extends Translations$apps$archive$en {
	_Translations$apps$archive$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get archive => 'أرشفة';
	@override String get archived => 'المؤرشفة';
	@override String get unarchive => 'طلب إلغاء الأرشفة';
	@override String notSupported({required Object installer}) => 'الأرشفة غير مدعومة لأن التطبيق تم تثبيته بواسطة "${installer}".';
}

// Path: apps.menu
class _Translations$apps$menu$ar extends Translations$apps$menu$en {
	_Translations$apps$menu$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get copyDisplayName => 'نسخ إسم العرض';
	@override String get copyPackageName => 'نسخ إسم الحزمة';
	@override String get viewAppInfo => 'عرض معلومات التطبيق';
	@override String get viewAppInfoDesktop => 'عرض معلومات التطبيق (على الجهاز)';
	@override String viewOnInstaller({required Object installer}) => 'عرض على ${installer}';
	@override late final _Translations$apps$menu$background$ar background = _Translations$apps$menu$background$ar._(_root);
}

// Path: apps.permissions
class _Translations$apps$permissions$ar extends Translations$apps$permissions$en {
	_Translations$apps$permissions$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'شغل في bg';
	@override String get backgroundData => 'بيانات bg';
	@override String get more => 'المزيد';
}

// Path: apps.review
class _Translations$apps$review$ar extends Translations$apps$review$en {
	_Translations$apps$review$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'تمت مراجعته';
	@override String get restore => 'إستعادة إذن الذي تمت مراجعته';
}

// Path: connect.noAdb.methods
class _Translations$connect$noAdb$methods$ar extends Translations$connect$noAdb$methods$en {
	_Translations$connect$noAdb$methods$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get summary => 'هناك كثير من الطرق لتثبيت ADB. بعد تثبيت ADB، أعد تشغيل التطبيق.';
	@override late final _Translations$connect$noAdb$methods$packageManager$ar packageManager = _Translations$connect$noAdb$methods$packageManager$ar._(_root);
	@override late final _Translations$connect$noAdb$methods$androidStudio$ar androidStudio = _Translations$connect$noAdb$methods$androidStudio$ar._(_root);
	@override late final _Translations$connect$noAdb$methods$standalone$ar standalone = _Translations$connect$noAdb$methods$standalone$ar._(_root);
}

// Path: connect.noShizuku.steps
class _Translations$connect$noShizuku$steps$ar extends Translations$connect$noShizuku$steps$en {
	_Translations$connect$noShizuku$steps$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$downloadShizuku$ar downloadShizuku = _Translations$connect$noShizuku$steps$downloadShizuku$ar._(_root);
	@override late final _Translations$connect$noShizuku$steps$setupShizuku$ar setupShizuku = _Translations$connect$noShizuku$steps$setupShizuku$ar._(_root);
	@override late final _Translations$connect$noShizuku$steps$allowAccess$ar allowAccess = _Translations$connect$noShizuku$steps$allowAccess$ar._(_root);
}

// Path: connect.noShizuku.useRoot
class _Translations$connect$noShizuku$useRoot$ar extends Translations$connect$noShizuku$useRoot$en {
	_Translations$connect$noShizuku$useRoot$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'هل أنت متجذر؟';
	@override String get alternativeToShizuku => 'لا تحتاج الأجهزة المتجذرة إلى Shizuku للوصول إلى واجهات برمجة تطبيقات النظام.';
	@override String get checkBoxToEnable => 'ضع علامة في الصندوق أدناه لتمكين صلاحيات الroot (جذر)، وامنح الإذن عند الطلب.';
	@override String get useRoot => 'إستخدم الroot (جذر)';
	@override String get experimental => 'تجريبي';
}

// Path: apps.menu.background
class _Translations$apps$menu$background$ar extends Translations$apps$menu$background$en {
	_Translations$apps$menu$background$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get reduced => 'تقليل النشاط في الخلفية';
	@override String get auto => 'السماح بالنشاط الإفتراضي في الخلفية';
	@override String get unrestricted => 'السماح بالنشاط الغير مقيد في الخلفية';
}

// Path: connect.noAdb.methods.packageManager
class _Translations$connect$noAdb$methods$packageManager$ar extends Translations$connect$noAdb$methods$packageManager$en {
	_Translations$connect$noAdb$methods$packageManager$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ثبت ADB عبر مدير الحزم';
	@override String get useFollowingCommand => 'يمكنك تثبيت ADB بأن تضع الأمر التالي في الطرفية:';
	@override String get grantFlatpakPermission => 'حينها إمنح "لا مزيد من تطبيقات الخلفية" حق الوصول إلى adb في نظامك:';
}

// Path: connect.noAdb.methods.androidStudio
class _Translations$connect$noAdb$methods$androidStudio$ar extends Translations$connect$noAdb$methods$androidStudio$en {
	_Translations$connect$noAdb$methods$androidStudio$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تثبيت ADB عبر أستوديو أندرويد';
	@override String get installPlatformTools => 'إذا كان لديك أستوديو أندرويد، يمكنك استخدام مدير SDK لتثبيت حزمه ادوات منصة SDK للأندرويد (ويأتي معها ADB).';
}

// Path: connect.noAdb.methods.standalone
class _Translations$connect$noAdb$methods$standalone$ar extends Translations$connect$noAdb$methods$standalone$en {
	_Translations$connect$noAdb$methods$standalone$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تثبيت ADB مستقل';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'يمكنك تحميل أدوات المنصة المستقلة من موقع مبرمجي أندرويد الرسمي:'),
		link,
		const TextSpan(text: '.'),
	]);
	@override String get extractAndAddToPath => 'بعد التحميل، إستخرج الملف المؤرشف وأضف دليل platform-tools إلى متغير بيئة PATH الخاص بنظامك.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _Translations$connect$noShizuku$steps$downloadShizuku$ar extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	_Translations$connect$noShizuku$steps$downloadShizuku$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'حمل Shizuku';
	@override String get description => 'حمل Shizuku من متجر play أو من مصادر رسمية.';
	@override String get googlePlay => 'متجر play';
	@override String get otherSources => 'مصادر أخرى';
}

// Path: connect.noShizuku.steps.setupShizuku
class _Translations$connect$noShizuku$steps$setupShizuku$ar extends Translations$connect$noShizuku$steps$setupShizuku$en {
	_Translations$connect$noShizuku$steps$setupShizuku$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'ضع Shizuku';
	@override String get description => 'ضع Shizuku عن طريق اتباع التعليمات في دليل المستخدم.\n أوصي باستخدام طريقة "البدء عبر تصحيح الأخطاء اللا سلكي".';
	@override String get userManual => 'دليل المستخدم';
}

// Path: connect.noShizuku.steps.allowAccess
class _Translations$connect$noShizuku$steps$allowAccess$ar extends Translations$connect$noShizuku$steps$allowAccess$en {
	_Translations$connect$noShizuku$steps$allowAccess$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'السماح بالوصول';
	@override String get description => 'إضغط على الزر أدناه واسمح ل"لا مزيد من تطبيقات الخلفية" أن يصل لShizuku عند الطلب.';
	@override String get requestAccess => 'طلب الوصول';
}
