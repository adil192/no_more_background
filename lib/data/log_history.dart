import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

final logHistory = LogHistory([]);

@visibleForTesting
class LogHistory extends ValueNotifier<List<LogRecord>> {
  LogHistory(super.value);

  void start() {
    Logger.root.level = Level.FINE;
    Logger.root.onRecord.listen((record) {
      value.add(record);
      notifyListeners();

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
