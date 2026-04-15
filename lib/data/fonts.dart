import 'package:flutter/foundation.dart';
import 'package:no_more_background/data/is_this_a_test.dart';

@pragma('vm:platform-const-if', !kDebugMode)
final kMonoFont = (
  primary: isThisATest ? 'packages/yaru/UbuntuMono' : 'Adwaita Mono',
  fallbacks: const [
    'Lilex',
    'Noto Sans Mono',
    'Ubuntu Mono',
    'packages/yaru/UbuntuMono',
  ],
);
