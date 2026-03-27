import 'dart:math';

import 'package:flutter/material.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

/// Instructions for installing Shizuku.
/// Android only. Desktop should use [HowToInstallAdb].
class HowToInstallShizuku extends StatelessWidget {
  const HowToInstallShizuku({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: max(16, (screenWidth - 700) / 2),
      ),
      children: [
        Center(child: Icon(Icons.warning, size: 48)),
        Center(
          child: Text(
            t.connect.noShizuku.noShizukuFound,
            style: theme.textTheme.headlineSmall,
            textAlign: .center,
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(t.connect.noShizuku.whatIsShizuku, textAlign: .center),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(t.connect.noShizuku.followTheseSteps, textAlign: .center),
        ),
        SizedBox(height: 48),

        Text(
          t.connect.noShizuku.steps.downloadShizuku.title,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Text(t.connect.noShizuku.steps.downloadShizuku.description),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton(
              onPressed: () {
                launchUrl(
                  Uri.parse(
                    'https://play.google.com/store/apps/details?id=moe.shizuku.privileged.api',
                  ),
                );
              },
              child: Text(t.connect.noShizuku.steps.downloadShizuku.googlePlay),
            ),
            FilledButton.tonal(
              onPressed: () {
                launchUrl(Uri.parse('https://shizuku.rikka.app/download/'));
              },
              child: Text(
                t.connect.noShizuku.steps.downloadShizuku.otherSources,
              ),
            ),
          ],
        ),
        SizedBox(height: 48),

        Text(
          t.connect.noShizuku.steps.setupShizuku.title,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Text(t.connect.noShizuku.steps.setupShizuku.description),
        SizedBox(height: 8),
        Align(
          alignment: .topStart,
          child: FilledButton(
            onPressed: () {
              launchUrl(Uri.parse('https://shizuku.rikka.app/guide/setup/'));
            },
            child: Text(t.connect.noShizuku.steps.setupShizuku.userManual),
          ),
        ),
        SizedBox(height: 48),

        Text(
          t.connect.noShizuku.steps.allowAccess.title,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Text(t.connect.noShizuku.steps.allowAccess.description),
        SizedBox(height: 8),
        Align(
          alignment: .topStart,
          child: FilledButton(
            onPressed: () async {
              Adb.impl = await Adb.findAdb();
            },
            child: Text(t.connect.noShizuku.steps.allowAccess.requestAccess),
          ),
        ),
        SizedBox(height: 48),
      ],
    );
  }
}
