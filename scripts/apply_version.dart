#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:intl/intl.dart';

late final String newVersionName;
late final int newVersionCode;
const String editor = 'zed';

const dummyChangelog = 'Release_notes_will_be_added_here';

Future<void> main(List<String> args) async {
  if (args.length != 2) {
    throw ArgumentError('Usage: ./scripts/bump_version.dart v1.2.3 102030');
  }
  newVersionName = args[0];
  newVersionCode = int.parse(args[1]);
  await updateAllFiles();
}

Future<void> updateAllFiles() async {
  // update pubspec
  await File('pubspec.yaml').replace({
    // e.g. version: 5.5.0+5050
    RegExp(r'version: .+'): 'version: $newVersionName+$newVersionCode',
  });

  // create metadata changelog
  final changelogFile = File('metadata/en-US/changelogs/$newVersionCode.txt');
  if (changelogFile.existsSync()) {
    print('Changelog file already exists');
  } else {
    print('Creating a blank changelog file');
    await changelogFile.writeAsString('• $dummyChangelog\n');
  }

  // update flatpak changelog
  final flatpakFile = File(
    'flatpak/com.adilhanney.no_more_background.metainfo.xml',
  );
  if (await flatpakFile.contains(RegExp(RegExp.escape(newVersionName)))) {
    print('<release> tag already exists in flatpak file');
  } else {
    print('Adding a new <release> tag to flatpak file');
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now().toUtc());
    final releaseTag =
        '''
        <release version="$newVersionName" date="$date">
            <description>
                <ul>
                    <li>$dummyChangelog</li>
                </ul>
            </description>
        </release>''';
    final flatpakLines = await flatpakFile.readAsLines();
    final index =
        flatpakLines.indexWhere((line) => line.contains('<releases>')) + 1;
    flatpakLines.insert(index, releaseTag);
    if (flatpakLines.last.isNotEmpty) flatpakLines.add('');
    await flatpakFile.writeAsString(flatpakLines.join('\n'));
  }

  print('');
  print('Make sure to update the changelog files:');
  print('  - ${changelogFile.path}');
  print('  - ${flatpakFile.path}');
  print('And then run:');
  print('  - ./scripts/translate_changelogs.dart');

  // open changelog files in editor
  await Process.run(editor, [changelogFile.path], runInShell: true);
  await Process.run(editor, [flatpakFile.path], runInShell: true);
}

extension on File {
  Future<bool> contains(RegExp pattern) async {
    final content = await readAsString();
    return pattern.hasMatch(content);
  }

  Future<void> replace(Map<RegExp, String> replacements) async {
    var matches = 0;
    final lines = await readAsLines();
    for (var i = 0; i < lines.length; i++) {
      for (final pattern in replacements.keys) {
        if (pattern.hasMatch(lines[i])) {
          matches++;
          lines[i] = lines[i].replaceFirst(pattern, replacements[pattern]!);
        }
      }
    }
    if (lines.last.isNotEmpty) lines.add('');
    await writeAsString(lines.join('\n'));

    if (matches >= replacements.length) {
      print('Updated $path with all $matches replacements');
    } else {
      print(
        'Updated $path with $matches out of ${replacements.length} '
        'replacements (${replacements.length - matches} missed)',
      );
    }
  }
}
