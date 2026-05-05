import 'dart:io';

import 'package:flutter/foundation.dart';

@pragma('vm:platform-const-if', !kDebugMode)
final isThisATest =
    kDebugMode && Platform.environment.containsKey('FLUTTER_TEST');
