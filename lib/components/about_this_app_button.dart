import 'package:flutter/material.dart';
import 'package:no_more_background/data/is_this_a_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutThisAppButton extends StatelessWidget {
  const AboutThisAppButton({super.key});

  static final Future<String?> _versionFuture = isThisATest
      ? Future.value()
      : PackageInfo.fromPlatform().then(
          (packageInfo) => _version = packageInfo.version,
        );
  static String? _version;

  @override
  Widget build(BuildContext context) {
    _versionFuture; // static initialization
    return TextButton(
      onPressed: () => showDialog(context),
      child: Text('About This App'),
    );
  }

  void showDialog(BuildContext context) {
    showAdaptiveAboutDialog(
      context: context,
      applicationName: 'NoMoreBackground',
      applicationIcon: Image.asset(
        'assets/icon/icon.png',
        width: 64,
        height: 64,
      ),
      applicationVersion: _version,
      applicationLegalese:
          'Copyright  © 2026  Adil Hanney\n'
          'This program comes with ABSOLUTELY NO WARRANTY.\n'
          'This is free software, and you are welcome to redistribute it under certain conditions.\n'
          'See the no_more_background license with the button below for more details.',
    );
  }
}
