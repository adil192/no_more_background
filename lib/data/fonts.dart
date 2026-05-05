import 'package:flutter/foundation.dart';
import 'package:app_manager/data/is_this_a_test.dart';

@pragma('vm:platform-const-if', !kDebugMode)
final kMonoFont = (
  primary: isThisATest ? 'packages/yaru/UbuntuMono' : 'Adwaita Mono',
  fallbacks: const [
    'Ubuntu Mono',
    'Google Sans Code',
    'Noto Sans Mono',
    'Roboto Mono',
    'packages/yaru/UbuntuMono',
  ],
);
