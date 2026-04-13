#!/usr/bin/env dart
// Run `dart scripts/translate_changelogs.dart` to generate the changelogs.

// ignore_for_file: avoid_print

import 'dart:io';

import 'src/get_native_name.dart';
import 'src/lms_translator.dart';

late final int buildNumber;

void copyChangelogForFdroid(String localeCode) async {
  final normal = File('metadata/$localeCode/changelogs/$buildNumber.txt');
  final fdroid = File('metadata/$localeCode/changelogs/${buildNumber}3.txt');
  normal.copySync(fdroid.path);
}

void main() async {
  buildNumber = int.parse(
    await Process.runSync('grep', [
      '-oP',
      r'version:\s*\d+\.\d+\.\d+\+\K\d+',
      'pubspec.yaml',
    ]).stdout,
  );

  final englishChangelog = File(
    'metadata/en-US/changelogs/$buildNumber.txt',
  ).readAsStringSync();
  print('English changelog for $buildNumber:');
  print(englishChangelog);

  if (englishChangelog.length > 500) {
    print(
      'Warning: The English changelog has length ${englishChangelog.length}, '
      'but Google Play only allows 500 characters.',
    );
    print('Please shorten the changelog and try again.');
    return;
  }

  final localeCodes = Directory('lib/i18n')
      .listSync()
      .whereType<File>()
      .map((f) => f.uri.pathSegments.last)
      .where((name) => name.endsWith('.i18n.yaml'))
      .map((name) => name.replaceFirst('.i18n.yaml', ''))
      .toList();

  late final translator = LmsTranslator.create();

  var someTranslationsFailed = false;
  for (var i = 0; i < localeCodes.length; i++) {
    final localeCode = localeCodes[i];
    late final localeName = getNativeName(localeCode);

    /// The step number and total number of steps.
    /// e.g. 1/10
    final stepPrefix = '${(i + 1).toString().padLeft(2)}/${localeCodes.length}';

    if (localeCode == 'en') {
      copyChangelogForFdroid('en-US');
      continue;
    }

    final file = File('metadata/$localeCode/changelogs/$buildNumber.txt');
    if (file.existsSync()) {
      continue;
    } else {
      print('$stepPrefix. Translating to $localeName ($localeCode)...');
    }

    var translatedChangelog = (await translator).translate(
      englishChangelog,
      to: '$localeName ($localeCode)',
    );

    if (!translatedChangelog.endsWith('\n')) {
      // translations sometimes don't end with a newline
      translatedChangelog += '\n';
    }

    const bullet = '•';
    if (englishChangelog.contains(bullet) &&
        !translatedChangelog.contains(bullet)) {
      print('${' ' * stepPrefix.length}  ! Translation invalid, skipping...');
      someTranslationsFailed = true;
      continue;
    }

    if (translatedChangelog.length > 500) {
      final oldLength = translatedChangelog.length;
      const suffix = '\n...\n';
      var linesRemoved = -1; // -1 to account for removing the trailing newline
      while (translatedChangelog.length > 500 - suffix.length) {
        final lastNewlineIndex = translatedChangelog.lastIndexOf('\n');
        translatedChangelog = translatedChangelog.substring(
          0,
          lastNewlineIndex,
        );
        linesRemoved++;
      }
      translatedChangelog += suffix;
      print(
        '${' ' * stepPrefix.length}  ! Removed $linesRemoved lines to '
        'shorten the changelog from $oldLength to '
        '${translatedChangelog.length} characters (max 500).',
      );
    }

    await file.create(recursive: true);
    await file.writeAsString(translatedChangelog);
    copyChangelogForFdroid(localeCode);
  }

  if (someTranslationsFailed) {
    print('\nSome translations failed: please re-run this script.');
    exit(1);
  } else {
    print('\nAll translations succeeded!');
    exit(0);
  }
}
