import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:url_launcher/url_launcher.dart';

/// Instructions for installing Shizuku.
/// Android only. Desktop should use [HowToInstallAdb].
class HowToInstallShizuku extends StatelessWidget {
  const HowToInstallShizuku({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.sizeOf(context);
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: max(16, (screenSize.width - 700) / 2),
      ),
      children: [
        SvgPicture.asset(
          'assets/cocomaterial/create_3.svg',
          colorFilter: .mode(theme.colorScheme.onSurface, .srcIn),
          width: min(256, screenSize.shortestSide / 3),
        ),
        Center(
          child: Text(
            t.connect.noShizuku.noShizukuFound,
            style: theme.textTheme.headlineSmall,
            textAlign: .center,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(t.connect.noShizuku.whatIsShizuku, textAlign: .center),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(t.connect.noShizuku.followTheseSteps, textAlign: .center),
        ),
        const SizedBox(height: 48),

        Text(
          t.connect.noShizuku.steps.downloadShizuku.title,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(t.connect.noShizuku.steps.downloadShizuku.description),
        const SizedBox(height: 8),
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
        const SizedBox(height: 48),

        Text(
          t.connect.noShizuku.steps.setupShizuku.title,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(t.connect.noShizuku.steps.setupShizuku.description),
        const SizedBox(height: 8),
        Align(
          alignment: .topStart,
          child: FilledButton(
            onPressed: () {
              launchUrl(Uri.parse('https://shizuku.rikka.app/guide/setup/'));
            },
            child: Text(t.connect.noShizuku.steps.setupShizuku.userManual),
          ),
        ),
        const SizedBox(height: 48),

        Text(
          t.connect.noShizuku.steps.allowAccess.title,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(t.connect.noShizuku.steps.allowAccess.description),
        const SizedBox(height: 8),
        Align(
          alignment: .topStart,
          child: FilledButton(
            onPressed: () async {
              Adb.impl = await Adb.findAdb();
            },
            child: Text(t.connect.noShizuku.steps.allowAccess.requestAccess),
          ),
        ),
        const SizedBox(height: 48),

        Center(
          child: Text(
            t.connect.noShizuku.useRoot.areYouRooted,
            style: theme.textTheme.titleLarge,
            textAlign: .center,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            t.connect.noShizuku.useRoot.alternativeToShizuku,
            textAlign: .center,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            t.connect.noShizuku.useRoot.checkBoxToEnable,
            textAlign: .center,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: ListenableBuilder(
            listenable: stows.useRoot,
            builder: (context, child) {
              return OutlinedButton.icon(
                onPressed: () async {
                  stows.useRoot.value = !stows.useRoot.value;
                  Adb.impl = await Adb.findAdb();
                },
                icon: Checkbox.adaptive(
                  value: stows.useRoot.value,
                  onChanged: (value) async {
                    stows.useRoot.value = value!;
                    Adb.impl = await Adb.findAdb();
                  },
                ),
                label: child!,
              );
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: const .all(.circular(2)),
                  ),
                  padding: const .symmetric(horizontal: 2),
                  child: Text(
                    t.connect.noShizuku.useRoot.experimental,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 8,
                      letterSpacing: 0,
                      fontWeight: .w800,
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
                Text(t.connect.noShizuku.useRoot.useRoot),
              ],
            ),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
