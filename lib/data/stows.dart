import 'package:flutter/foundation.dart';
import 'package:no_more_background/data/reviewed_app.dart';
import 'package:stow_plain/stow_plain.dart';

final stows = Stows();

class Stows {
  final reviewedAppsBySerial = PlainStow.json(
    'reviewedAppsBySerial',
    <String, List<ReviewedApp>>{},
    fromJson: (json) => (json as Map<String, dynamic>).map((key, value) {
      return MapEntry(
        key,
        (value as List).map((e) => ReviewedApp.fromJson(e)).toList(),
      );
    }),
  );

  final showSystemApps = PlainStow('showSystemApps', false);
  final showReviewedApps = PlainStow('showReviewedApps', true);

  final useFakeAdb = PlainStow(
    'useFakeAdb',
    !kReleaseMode && const bool.fromEnvironment('FAKE_ADB'),
    volatile: kReleaseMode,
  );
  final useRoot = PlainStow(
    'useRoot',
    kDebugMode, // TODO(adil192): Add UI to opt-in to root, and set this to false
  );
}
