import 'package:flutter/material.dart';
import 'package:no_more_background/compute/adb.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({super.key, required this.device});

  final AdbDevice device;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(device.toString()));
  }
}
