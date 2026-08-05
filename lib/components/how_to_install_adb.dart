import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:platform_linux/platform.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Instructions for installing ADB.
/// Desktop only. Mobile should use [HowToInstallShizuku].
class HowToInstallAdb extends StatelessWidget {
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

  const HowToInstallAdb({super.key});

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
          'assets/cocomaterial/device_desktop_working_code.svg',
          colorFilter: .mode(theme.colorScheme.onSurface, .srcIn),
          width: min(256, screenSize.shortestSide / 4),
        ),
        Center(
          child: Text(
            t.connect.noAdb.noAdbFound,
            style: theme.textTheme.headlineSmall,
            textAlign: .center,
          ),
        ),
        const SizedBox(height: 8),
        Center(child: Text(t.connect.noAdb.adbIsRequired, textAlign: .center)),
        const SizedBox(height: 8),
        Center(
          child: Text(t.connect.noAdb.methods.summary, textAlign: .center),
        ),
        if (installAdbCommand != null) ...[
          const SizedBox(height: 48),
          Text(
            t.connect.noAdb.methods.packageManager.title,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(t.connect.noAdb.methods.packageManager.useFollowingCommand),
          const SizedBox(height: 8),
          _TerminalCommand(installAdbCommand!),
          if (theme.platform == .linux) ...[
            const SizedBox(height: 8),
            Text(t.connect.noAdb.methods.packageManager.grantFlatpakPermission),
            const SizedBox(height: 8),
            const _TerminalCommand(
              'flatpak override --filesystem=host-os:ro com.adilhanney.no_more_background',
            ),
          ],
        ],
        const SizedBox(height: 48),
        Text(
          t.connect.noAdb.methods.androidStudio.title,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(t.connect.noAdb.methods.androidStudio.installPlatformTools),
        const SizedBox(height: 48),
        Text(
          t.connect.noAdb.methods.standalone.title,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        command,
        style: const TextStyle(fontFamily: 'packages/yaru/UbuntuMono', fontSize: 14),
      ),
    );
  }
}
