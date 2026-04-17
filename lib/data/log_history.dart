import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

abstract class LogHistory {
  static void start() {
    Logger.root.level = Level.FINE;
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });

    final flutterErrorLog = Logger('FlutterError');
    FlutterError.onError = (details) {
      flutterErrorLog.severe(
        details.exceptionAsString(),
        details.exception,
        details.stack,
      );
      FlutterError.presentError(details);
    };

    final platformErrorLog = Logger('PlatformError');
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      platformErrorLog.severe(error, stackTrace);
      return false;
    };
  }
}
