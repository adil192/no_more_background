import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/components/app_icon.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/app_stores.dart';
import 'package:no_more_background/data/constants.dart';
import 'package:no_more_background/data/fonts.dart';
import 'package:no_more_background/i18n/strings.g.dart';

class ExpandedAppDialog extends StatelessWidget {
  const ExpandedAppDialog({
    super.key,
    required this.app,
    required this.deviceSerial,
    required this.permissions,
    required this.setBackgroundActivity,
    required this.setUnrestrictBackgroundData,
    required this.toggleArchived,
  });

  final AdbApp app;
  final String deviceSerial;
  final AdbAppPermissions permissions;
  final void Function(BackgroundActivity) setBackgroundActivity;
  final void Function(bool unrestricted) setUnrestrictBackgroundData;
  final Future<void> Function() toggleArchived;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final insetPadding = EdgeInsetsDirectional.only(
      top: 24,
      bottom: 24,
      start: 64,
      end: max(16, (screenWidth - kMaxContentWidth) / 2),
    );

    return Dialog(
      insetPadding: insetPadding.resolve(Directionality.of(context)),
      alignment: .centerEnd,
      constraints: BoxConstraints(maxWidth: kMaxContentWidth * 0.6),
      child: Padding(
        padding: .symmetric(vertical: 16, horizontal: 8),
        child: SingleChildScrollView(child: _buildContent(context)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final installer = AppStore.stores[app.installer];
    final theme = Theme.of(context);

    final displayNameStyle = (theme.textTheme.bodyLarge ?? TextStyle())
        .copyWith(height: 1.2, fontSize: 20);
    final displayNameCopyButtonSize = Size.square(
      max(24, displayNameStyle.height! * displayNameStyle.fontSize!),
    );
    final packageNameStyle = (theme.textTheme.labelMedium ?? TextStyle())
        .copyWith(
          fontSize: 14,
          height: 1.2,
          fontFamily: kMonoFont.primary,
          fontFamilyFallback: kMonoFont.fallbacks,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
        );
    final packageNameCopyButtonSize = Size.square(
      max(24, packageNameStyle.height! * packageNameStyle.fontSize!),
    );

    return Column(
      children: [
        AppIcon(app, size: 64),
        SizedBox(height: 4),
        Row(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            Flexible(
              child: Text(
                app.displayName,
                textAlign: .center,
                style: displayNameStyle,
              ),
            ),
            IconButton(
              style: .new(
                tapTargetSize: .shrinkWrap,
                minimumSize: .all(displayNameCopyButtonSize),
                fixedSize: .all(displayNameCopyButtonSize),
                iconSize: .all(displayNameCopyButtonSize.width * 0.8),
                padding: .all(.zero),
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: app.displayName));
              },
              icon: Icon(Icons.copy),
            ),
          ],
        ),
        Row(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            Flexible(
              child: Text(
                app.packageName,
                textAlign: .center,
                style: packageNameStyle,
              ),
            ),
            IconButton(
              style: .new(
                tapTargetSize: .shrinkWrap,
                minimumSize: .all(packageNameCopyButtonSize),
                fixedSize: .all(packageNameCopyButtonSize),
                iconSize: .all(packageNameCopyButtonSize.width * 0.8),
                padding: .all(.zero),
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: app.packageName));
              },
              icon: Icon(Icons.copy),
            ),
          ],
        ),
        SizedBox(height: 4),
        ElevatedButton(
          onPressed: () => Adb.openAppInfo(deviceSerial, app),
          child: Text(
            defaultTargetPlatform == .android
                ? t.apps.menu.viewAppInfo
                : t.apps.menu.viewAppInfoDesktop,
          ),
        ),
        if (installer != null) ...[
          SizedBox(height: 4),
          ElevatedButton(
            onPressed: () => Adb.openAppInfo(deviceSerial, app),
            child: Text(
              t.apps.menu.viewOnInstaller(installer: installer.displayName),
            ),
          ),
        ],

        Divider(height: 32, indent: 16, endIndent: 16),

        StatefulBuilder(
          builder: (context, setState) {
            return RadioGroup<BackgroundActivity>(
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  setBackgroundActivity(value);
                });
              },
              groupValue: permissions.backgroundActivity,
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Padding(
                    padding: .symmetric(horizontal: 16),
                    child: Text(
                      t.apps.menu.runInBackground.title,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: .symmetric(horizontal: 16),
                    child: Text(
                      t.apps.menu.runInBackground.explanation,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.reduced,
                    title: Text(t.apps.menu.runInBackground.reduced),
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.auto,
                    title: Text(t.apps.menu.runInBackground.auto),
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.unrestricted,
                    title: Text(t.apps.menu.runInBackground.unrestricted),
                  ),
                ],
              ),
            );
          },
        ),

        Divider(height: 32, indent: 16, endIndent: 16),

        StatefulBuilder(
          builder: (context, setState) {
            return RadioGroup<bool>(
              onChanged: (unrestricted) {
                if (unrestricted == null) return;
                setState(() => setUnrestrictBackgroundData(unrestricted));
              },
              groupValue: permissions.restrictBackgroundData,
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Padding(
                    padding: .symmetric(horizontal: 16),
                    child: Text(
                      t.apps.menu.backgroundData.title,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: .symmetric(horizontal: 16),
                    child: Text(
                      t.apps.menu.backgroundData.explanation,
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  RadioListTile.adaptive(
                    value: false,
                    title: Text(
                      t.apps.menu.backgroundData.restricted,
                    ),
                  ),
                  RadioListTile.adaptive(
                    value: true,
                    title: Text(
                      t.apps.menu.backgroundData.restricted,
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        Divider(height: 32, indent: 16, endIndent: 16),

        StatefulBuilder(
          builder: (context, setState) {
            return ElevatedButton(
              onPressed: () async {
                await toggleArchived();
                setState(() {});
              },
              child: app.isUninstalled
                  ? Text(t.apps.archive.unarchive)
                  : Text(t.apps.archive.archive),
            );
          },
        ),
      ],
    );
  }
}
