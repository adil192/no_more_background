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
class TranslationsEl extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.el,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <el>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final TranslationsEl _root = this; // ignore: unused_field

	@override 
	TranslationsEl $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEl(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$connect$el connect = _Translations$connect$el._(_root);
	@override late final _Translations$apps$el apps = _Translations$apps$el._(_root);
	@override late final _Translations$logs$el logs = _Translations$logs$el._(_root);
}

// Path: connect
class _Translations$connect$el extends Translations$connect$en {
	_Translations$connect$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$header$el header = _Translations$connect$header$el._(_root);
	@override late final _Translations$connect$adb$el adb = _Translations$connect$adb$el._(_root);
	@override String get refresh => 'Επαναφόρτωση';
	@override String get about => 'Σχετικά με αυτήν την εφαρμογή';
	@override String get aboutShortened => 'Σχετικά';
	@override String get viewPrivacyPolicy => 'Προβολή πολιτικής απορρήτου';
	@override late final _Translations$connect$noAdb$el noAdb = _Translations$connect$noAdb$el._(_root);
	@override late final _Translations$connect$noShizuku$el noShizuku = _Translations$connect$noShizuku$el._(_root);
	@override String get viewLogsShortened => 'Αρχεία καταγραφής';
	@override String get viewLogs => 'Προβολή καταγραφών';
}

// Path: apps
class _Translations$apps$el extends Translations$apps$en {
	_Translations$apps$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$filter$el filter = _Translations$apps$filter$el._(_root);
	@override late final _Translations$apps$title$el title = _Translations$apps$title$el._(_root);
	@override late final _Translations$apps$archive$el archive = _Translations$apps$archive$el._(_root);
	@override late final _Translations$apps$menu$el menu = _Translations$apps$menu$el._(_root);
	@override late final _Translations$apps$permissions$el permissions = _Translations$apps$permissions$el._(_root);
	@override late final _Translations$apps$review$el review = _Translations$apps$review$el._(_root);
}

// Path: logs
class _Translations$logs$el extends Translations$logs$en {
	_Translations$logs$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Αρχεία καταγραφής';
}

// Path: connect.header
class _Translations$connect$header$el extends Translations$connect$header$en {
	_Translations$connect$header$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Συνδέστε τη συσκευή σας';
	@override String subtitle({required Object n}) => '${n} συσκευές βρέθηκαν';
}

// Path: connect.adb
class _Translations$connect$adb$el extends Translations$connect$adb$en {
	_Translations$connect$adb$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get fake => 'Ψεύτικο ADB';
	@override String get real => 'Αληθινό ADB';
}

// Path: connect.noAdb
class _Translations$connect$noAdb$el extends Translations$connect$noAdb$en {
	_Translations$connect$noAdb$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get noAdbFound => 'Δεν μπορούμε να βρούμε το ADB στο σύστημά σας.';
	@override late final _Translations$connect$noAdb$methods$el methods = _Translations$connect$noAdb$methods$el._(_root);
	@override String get adbIsRequired => 'Το ADB (Android Debug Bridge) απαιτείται για να συνδέσετε τη συσκευή σας Android™ με αυτή την εφαρμογή.';
}

// Path: connect.noShizuku
class _Translations$connect$noShizuku$el extends Translations$connect$noShizuku$en {
	_Translations$connect$noShizuku$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$el steps = _Translations$connect$noShizuku$steps$el._(_root);
	@override late final _Translations$connect$noShizuku$useRoot$el useRoot = _Translations$connect$noShizuku$useRoot$el._(_root);
	@override String get noShizukuFound => 'Δεν μπορούμε να συνδεθούμε στο Shizuku.';
	@override String get whatIsShizuku => 'Η Shizuku είναι ένα ανοιχτό έργο που μας επιτρέπει να ελέγξουμε άλλες εφαρμογές χωρίς να χρειάζεται υπολογιστής ή πρόσβαση root.';
	@override String get followTheseSteps => 'Ακολουθήστε αυτά τα βήματα για να ξεκινήσετε.';
}

// Path: apps.filter
class _Translations$apps$filter$el extends Translations$apps$filter$en {
	_Translations$apps$filter$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get showSystemApps => 'Εμφάνιση εφαρμογών του συστήματος';
	@override String get showReviewedApps => 'Εμφάνιση αξιολογημένων εφαρμογών';
}

// Path: apps.title
class _Translations$apps$title$el extends Translations$apps$title$en {
	_Translations$apps$title$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get searchYourApps => 'Αναζήτηση στις εφαρμογές σας';
	@override String get yourApps => 'Οι εφαρμογές σας';
}

// Path: apps.archive
class _Translations$apps$archive$el extends Translations$apps$archive$en {
	_Translations$apps$archive$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get archive => 'Αρχείο';
	@override String get archived => 'Αρχειοθετημένο';
	@override String get unarchive => 'Αίτημα μη αρχειοθέτησης';
	@override String notSupported({required Object installer}) => 'Η αρχειοθέτηση δεν υποστηρίζεται επειδή η εφαρμογή εγκαταστάθηκε από τον "${installer}".';
}

// Path: apps.menu
class _Translations$apps$menu$el extends Translations$apps$menu$en {
	_Translations$apps$menu$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$apps$menu$background$el background = _Translations$apps$menu$background$el._(_root);
	@override String get copyDisplayName => 'Αντιγραφή ονομασίας εμφάνισης';
	@override String get copyPackageName => 'Αντιγραφή ονόματος πακέτου';
	@override String get viewAppInfo => 'Προβολή πληροφοριών εφαρμογής';
	@override String get viewAppInfoDesktop => 'Προβολή πληροφοριών εφαρμογής (στο συσκευή)';
	@override String viewOnInstaller({required Object installer}) => 'Προβολή στο ${installer}';
}

// Path: apps.permissions
class _Translations$apps$permissions$el extends Translations$apps$permissions$en {
	_Translations$apps$permissions$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get runInBackground => 'Εκτέλεσε στο background';
	@override String get backgroundData => 'Δεδομένα φόντου';
	@override String get more => 'Περισσότερα';
}

// Path: apps.review
class _Translations$apps$review$el extends Translations$apps$review$en {
	_Translations$apps$review$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get reviewed => 'Εξέταση';
	@override String get restore => 'Επαναφέρει τις ελεγμένες άδειες';
}

// Path: connect.noAdb.methods
class _Translations$connect$noAdb$methods$el extends Translations$connect$noAdb$methods$en {
	_Translations$connect$noAdb$methods$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noAdb$methods$packageManager$el packageManager = _Translations$connect$noAdb$methods$packageManager$el._(_root);
	@override late final _Translations$connect$noAdb$methods$androidStudio$el androidStudio = _Translations$connect$noAdb$methods$androidStudio$el._(_root);
	@override late final _Translations$connect$noAdb$methods$standalone$el standalone = _Translations$connect$noAdb$methods$standalone$el._(_root);
	@override String get summary => 'Υπάρχουν μερικοί τρόποι για να εγκαταστήσετε το ADB. Μετά την εγκατάσταση του ADB, επανεκκινήστε αυτήν την εφαρμογή.';
}

// Path: connect.noShizuku.steps
class _Translations$connect$noShizuku$steps$el extends Translations$connect$noShizuku$steps$en {
	_Translations$connect$noShizuku$steps$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$connect$noShizuku$steps$downloadShizuku$el downloadShizuku = _Translations$connect$noShizuku$steps$downloadShizuku$el._(_root);
	@override late final _Translations$connect$noShizuku$steps$setupShizuku$el setupShizuku = _Translations$connect$noShizuku$steps$setupShizuku$el._(_root);
	@override late final _Translations$connect$noShizuku$steps$allowAccess$el allowAccess = _Translations$connect$noShizuku$steps$allowAccess$el._(_root);
}

// Path: connect.noShizuku.useRoot
class _Translations$connect$noShizuku$useRoot$el extends Translations$connect$noShizuku$useRoot$en {
	_Translations$connect$noShizuku$useRoot$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get areYouRooted => 'Είσαι ριζωμένος;';
	@override String get alternativeToShizuku => 'Οι ριζωμένες συσκευές δεν χρειάζονται το Shizuku για να έχουν πρόσβαση στις API του συστήματος.';
	@override String get checkBoxToEnable => 'Σημεία την κάτω πλατφόρμα για να ενεργοποιήσετε το root και δώστε την άδεια όταν σας ζητηθεί.';
	@override String get useRoot => 'Χρησιμοποιήστε ρίζα';
	@override String get experimental => 'ΕΜΠΕΙΡΙΩΣΗ';
}

// Path: apps.menu.background
class _Translations$apps$menu$background$el extends Translations$apps$menu$background$en {
	_Translations$apps$menu$background$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get reduced => 'Μειώστε τη δραστηριότητα της φόντου';
	@override String get auto => 'Επιτρέψτε την προεπιλεγμένη δραστηριότητα φόντου';
	@override String get unrestricted => 'Επιτρέψτε απεριόριστη δραστηριότητα στο παρασκήνιο';
	@override String get explanation => 'Οι τυπικές εντολές μπαταρίας του Android:';
}

// Path: connect.noAdb.methods.packageManager
class _Translations$connect$noAdb$methods$packageManager$el extends Translations$connect$noAdb$methods$packageManager$en {
	_Translations$connect$noAdb$methods$packageManager$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Εγκατάσταση του ADB μέσω του διαχειριστή πακέτων';
	@override String get useFollowingCommand => 'Μπορείτε να εγκαταστήσετε το ADB χρησιμοποιώντας την ακόλουθη εντολή στο terminal σας:';
	@override String get grantFlatpakPermission => 'Στη συνέχεια, δώστε πρόσβαση NoMoreBackground στο adb του συστήματός σας:';
}

// Path: connect.noAdb.methods.androidStudio
class _Translations$connect$noAdb$methods$androidStudio$el extends Translations$connect$noAdb$methods$androidStudio$en {
	_Translations$connect$noAdb$methods$androidStudio$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Εγκατάσταση του ADB μέσω του Android Studio';
	@override String get installPlatformTools => 'Αν έχετε το Android Studio, μπορείτε να χρησιμοποιήσετε τον διαχειριστή SDK του για να εγκαταστήσετε το πακέτο Android SDK Platform Tools (που περιλαμβάνει το ADB).';
}

// Path: connect.noAdb.methods.standalone
class _Translations$connect$noAdb$methods$standalone$el extends Translations$connect$noAdb$methods$standalone$en {
	_Translations$connect$noAdb$methods$standalone$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Εγκατάσταση ADB αυτόνομα';
	@override TextSpan downloadFromWebsite({required InlineSpan link}) => TextSpan(children: [
		const TextSpan(text: 'Μπορείτε να κατεβάσετε τα αυτόνομα εργαλεία πλατφόρμας από την επίσημη ιστοσελίδα των προγραμματιστων του Android: '),
		link,
		const TextSpan(text: '.'),
	]);
	@override String get extractAndAddToPath => 'Μετά το λήψιμο, εξάγετε το αρχείο και προσθέστε τον κατάλογο platform-tools στη μεταβλητή περιβάλλοντος PATH του συστήματός σας.';
}

// Path: connect.noShizuku.steps.downloadShizuku
class _Translations$connect$noShizuku$steps$downloadShizuku$el extends Translations$connect$noShizuku$steps$downloadShizuku$en {
	_Translations$connect$noShizuku$steps$downloadShizuku$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Κατεβάστε το Shizuku';
	@override String get description => 'Κατεβάστε το Shizuku από το Google Play ή μια άλλη επίσημη πηγή.';
	@override String get googlePlay => 'Google Play';
	@override String get otherSources => 'Άλλες πηγές';
}

// Path: connect.noShizuku.steps.setupShizuku
class _Translations$connect$noShizuku$steps$setupShizuku$el extends Translations$connect$noShizuku$steps$setupShizuku$en {
	_Translations$connect$noShizuku$steps$setupShizuku$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Εγκατάσταση του Shizuku';
	@override String get description => 'Εγκαταστήστε το Shizuku ακολουθώντας τις οδηγίες στο εγχειρίδιο του χρήστη.\nΣυνιστώ τη μέθοδο «Έναρξη μέσω ασύρματης απόப்பை» (Start via wireless debugging).';
	@override String get userManual => 'Εγχειρίδιο χρήστη';
}

// Path: connect.noShizuku.steps.allowAccess
class _Translations$connect$noShizuku$steps$allowAccess$el extends Translations$connect$noShizuku$steps$allowAccess$en {
	_Translations$connect$noShizuku$steps$allowAccess$el._(TranslationsEl root) : this._root = root, super.internal(root);

	final TranslationsEl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Επιτρέψτε πρόσβαση';
	@override String get description => 'Πατήστε το κουμπί παρακάτω και επιτρέψτε στο NoMoreBackground να έχει πρόσβαση στο Shizuku όταν σας ζητηθεί.';
	@override String get requestAccess => 'Αίτημα πρόσβασης';
}
