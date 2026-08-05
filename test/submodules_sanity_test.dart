/// We use lots of PNG assets from our submodules, which are essentially
/// unvetted binary files.
/// This test verifies that they're valid PNGs and of reasonable sizes.
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  final isCi = Platform.environment['CI']?.isNotEmpty ?? false;
  test(
    'Submodules sanity test',
    skip: !isCi,
    timeout: const Timeout(Duration(minutes: 5)),
    () async {
      final hasPngcheck = Process.runSync('which', ['pngcheck']);
      if (hasPngcheck.exitCode != 0) {
        fail('pngcheck not found, please install it!');
      }

      TestWidgetsFlutterBinding.ensureInitialized();
      final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assets = assetManifest.listAssets();
      final assetsFromSubmodules = assets
          .where((asset) => asset.startsWith('submodules'))
          .toList(growable: false);

      var valid = true;
      for (final assetPath in assetsFromSubmodules) {
        if (assetPath.startsWith(
          'submodules/Delta-Icons/app/src/main/res/drawable-nodpi/ic_',
        )) {
          // This will get removed with `./patches/remove_unused_assets.sh`.
          continue;
        }

        switch (p.extension(assetPath)) {
          case '.xml':
            valid &= await _validateXml(assetPath);
          case '.png':
            valid &= await _validatePng(assetPath);
        }
      }

      if (!valid) fail('Some checks failed, they have been logged above.');
    },
  );
}

Future<bool> _validateXml(String assetPath) async {
  final size = File(assetPath).lengthSync();
  const maxSize = 10 * 1024 * 1024; // 10 MiB
  if (size > maxSize) {
    debugPrint('Abnormally large at ${(size / 1024).round()} KB: $assetPath');
    return false;
  }

  // No need to check XML syntax, since the parsing code has test coverage.
  return true;
}

Future<bool> _validatePng(String assetPath) async {
  final pngcheck = await Process.run('pngcheck', ['-q', assetPath]);
  if (pngcheck.exitCode != 0) {
    final pngcheckOutput = (pngcheck.stdout as String).trim().split('\n');
    if (pngcheckOutput.length == 2 &&
        pngcheckOutput[0].endsWith('eXIf after IDAT no longer allowed')) {
      // This is benign, to do with the updated png spec for metadata
    } else {
      debugPrint('pngcheck failed for $assetPath: $pngcheckOutput');
      return false;
    }
  }

  final size = File(assetPath).lengthSync();
  const maxSize = 100 * 1024; // 100 KiB
  if (size > maxSize) {
    debugPrint('Abnormally large at ${(size / 1024).round()} KB: $assetPath');
    return false;
  }

  return true;
}
