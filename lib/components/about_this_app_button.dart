import 'package:flutter/material.dart';
import 'package:no_more_background/data/is_this_a_test.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutThisAppButton extends StatelessWidget {
  const AboutThisAppButton({super.key});

  static final Future<String?> _versionFuture = isThisATest
      ? Future.value()
      : PackageInfo.fromPlatform().then((packageInfo) => packageInfo.version);

  @override
  Widget build(BuildContext context) {
    _versionFuture; // static initialization
    return TextButton(
      onPressed: () => showDialog(context),
      child: Text(t.connect.about),
    );
  }

  static void showDialog(BuildContext context) async {
    final version = await _versionFuture;
    if (!context.mounted) return;
    return showAdaptiveAboutDialog(
      context: context,
      applicationName: 'NoMoreBackground',
      applicationIcon: Image.asset(
        'assets/icon/icon.png',
        width: 64,
        height: 64,
      ),
      applicationVersion: version,
      applicationLegalese:
          'Copyright  © 2026  Adil Hanney\n'
          'This program comes with ABSOLUTELY NO WARRANTY.\n'
          'This is free software, and you are welcome to redistribute it under certain conditions.\n'
          'See the no_more_background license with the button below for more details.',
      children: [
        SizedBox(height: 32),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              launchUrl(
                Uri.parse(
                  'https://github.com/adil192/no_more_background/blob/main/privacy_policy.md',
                ),
              );
            },
            child: Text(
              t.connect.viewPrivacyPolicy,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
