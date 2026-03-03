import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void setupMockYaruWindow() {
  const channel = MethodChannel('yaru_window');
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
        if (methodCall.method == 'state') {
          return '';
        }
        return null;
      });
}
