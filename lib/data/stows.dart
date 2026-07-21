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
  final appFilter = PlainStow('appFilter', '', volatile: true);

  final useRoot = PlainStow('useRoot', false);
  final useFakeAdb = PlainStow(
    'useFakeAdb',
    !kReleaseMode && const bool.fromEnvironment('FAKE_ADB'),
    volatile: kReleaseMode,
  );
}
