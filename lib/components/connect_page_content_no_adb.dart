import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:no_more_background/i18n/strings.g.dart';
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
            t.connect.noAdb.noAdbFound,
            style: theme.textTheme.headlineSmall,
            textAlign: .center,
          ),
        ),
        SizedBox(height: 8),
        Center(child: Text(t.connect.noAdb.adbIsRequired, textAlign: .center)),
        SizedBox(height: 8),
        Center(
          child: Text(t.connect.noAdb.methods.summary, textAlign: .center),
        ),
        if (installAdbCommand != null) ...[
          SizedBox(height: 48),
          Text(
            t.connect.noAdb.methods.packageManager.title,
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text(t.connect.noAdb.methods.packageManager.useFollowingCommand),
          SizedBox(height: 8),
          _TerminalCommand(installAdbCommand!),
          if (theme.platform == .linux) ...[
            SizedBox(height: 8),
            Text(t.connect.noAdb.methods.packageManager.grantFlatpakPermission),
            SizedBox(height: 8),
            _TerminalCommand(
              'flatpak override --filesystem=host-os:ro com.adilhanney.no_more_background',
            ),
          ],
        ],
        SizedBox(height: 48),
        Text(
          t.connect.noAdb.methods.androidStudio.title,
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Text(t.connect.noAdb.methods.androidStudio.installPlatformTools),
        SizedBox(height: 48),
        Text('Install ADB standalone', style: theme.textTheme.titleLarge),
        SizedBox(height: 8),
        Text.rich(
          t.connect.noAdb.methods.standalone.downloadFromWebsite(
            link: TextSpan(
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
          ),
        ),
        Text(t.connect.noAdb.methods.standalone.extractAndAddToPath),
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
        style: TextStyle(fontFamily: 'packages/yaru/UbuntuMono', fontSize: 14),
      ),
    );
  }
}
