import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:platform_linux/platform.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ConnectPageContentNoAdb extends StatelessWidget {
  static const platform = LocalPlatform();

  @visibleForTesting
  static String? debugInstallAdbCommandOverride;
  static String? get installAdbCommand {
    if (debugInstallAdbCommandOverride != null) {
      return debugInstallAdbCommandOverride;
    }
    if (platform.isMacOS) return 'brew install android-platform-tools';
    if (!platform.isLinux) return null;

    if (platform.isUbuntu || platform.isPopOS || platform.isDebian) {
      return 'sudo apt install adb';
    } else if (platform.isFedora || platform.isAlma) {
      return 'sudo dnf install android-tools';
    } else if (platform.isArch || platform.isManjaro) {
      return 'sudo pacman -S android-tools';
    } else if (platform.isOpenSUSE) {
      return 'sudo zypper install android-tools';
    }
    return null;
  }

  const ConnectPageContentNoAdb({super.key});

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
            'We can\'t find ADB on your system.',
            style: theme.textTheme.headlineSmall,
            textAlign: .center,
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'ADB (Android Debug Bridge) is required to connect your '
            'Android device to this application.',
            textAlign: .center,
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'There are a few ways you can install ADB. '
            'After installing ADB, restart this application.',
            textAlign: .center,
          ),
        ),
        if (installAdbCommand != null) ...[
          SizedBox(height: 48),
          Text(
            'Install ADB via package manager',
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text(
            'You can install ADB using the following command in your terminal:',
          ),
          SizedBox(height: 8),
          _TerminalCommand(installAdbCommand!),
          if (theme.platform == .linux) ...[
            SizedBox(height: 8),
            Text('Then grant NoMoreBackground access to your system\'s adb:'),
            SizedBox(height: 8),
            _TerminalCommand(
              'flatpak override --filesystem=host-os:ro com.adilhanney.no_more_background',
            ),
          ],
        ],
        SizedBox(height: 48),
        Text(
          'Install ADB with Android Studio',
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Text(
          'If you have Android Studio, '
          'you can use its SDK manager to install the '
          'Android SDK Platform Tools package (which includes ADB).',
        ),
        SizedBox(height: 48),
        Text('Install ADB standalone', style: theme.textTheme.titleLarge),
        SizedBox(height: 8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    'You can download the standalone platform tools from the '
                    'official Android developer website: ',
              ),
              TextSpan(
                text:
                    'https://developer.android.com/studio/releases/platform-tools',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrlString(
                      'https://developer.android.com/tools/releases/platform-tools',
                    );
                  },
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  decoration: .underline,
                ),
              ),
              TextSpan(text: '.'),
            ],
          ),
        ),
        Text(
          'After downloading, extract the archive and add the platform-tools '
          'directory to your system\'s PATH environment variable.',
        ),
      ],
    );
  }
}

class _TerminalCommand extends StatelessWidget {
  const _TerminalCommand(this.command);
  final String command;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        command,
        style: TextStyle(
          fontFamily: 'UbuntuMono',
          package: 'yaru',
          fontSize: 14,
        ),
      ),
    );
  }
}
