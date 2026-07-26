import 'dart:async';

import 'package:no_more_background/compute/adb.dart';

/// An `adb` implementation that records all `adb` commands that would be run.
class RecordingAdbImpl extends AdbImpl {
  RecordingAdbImpl() : super('adb');

  final List<String> records = [];

  @override
  Future<String> runAdb(List<String> args, {bool silent = false}) async {
    records.add(['adb', ...args].join(' '));
    return '';
  }
}
