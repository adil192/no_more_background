import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/components/app_icon.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_device.dart';
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
  final AdbDeviceSerial deviceSerial;
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
        padding: .symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(child: _buildContent(context)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final appStore = AppStore.stores[app.installer];
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
      crossAxisAlignment: .stretch,
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
        if (appStore != null) ...[
          SizedBox(height: 4),
          ElevatedButton(
            onPressed: () => Adb.openAppInfo(deviceSerial, app),
            child: Text(
              t.apps.menu.viewOnInstaller(installer: appStore.displayName),
            ),
          ),
        ],

        Divider(height: 32),

        StatefulBuilder(
          builder: (context, setState) {
            return RadioGroup<BackgroundActivity>(
              onChanged: (value) {
                if (value == null) return;
                setBackgroundActivity(value);
                setState(() {});
              },
              groupValue: permissions.backgroundActivity,
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    t.apps.menu.runInBackground.title,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    t.apps.menu.runInBackground.explanation,
                    style: theme.textTheme.labelLarge,
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.reduced,
                    contentPadding: .zero,
                    title: Text(t.apps.menu.runInBackground.reduced),
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.auto,
                    contentPadding: .zero,
                    title: Text(t.apps.menu.runInBackground.auto),
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.unrestricted,
                    contentPadding: .zero,
                    title: Text(t.apps.menu.runInBackground.unrestricted),
                  ),
                ],
              ),
            );
          },
        ),

        Divider(height: 32),

        StatefulBuilder(
          builder: (context, setState) {
            return RadioGroup<bool>(
              onChanged: (unrestricted) {
                if (unrestricted == null) return;
                setUnrestrictBackgroundData(unrestricted);
                setState(() {});
              },
              groupValue: !permissions.restrictBackgroundData,
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(
                    t.apps.menu.backgroundData.title,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    t.apps.menu.backgroundData.explanation,
                    style: theme.textTheme.labelLarge,
                  ),
                  RadioListTile.adaptive(
                    value: false,
                    contentPadding: .zero,
                    title: Text(t.apps.menu.backgroundData.restricted),
                  ),
                  RadioListTile.adaptive(
                    value: true,
                    contentPadding: .zero,
                    title: Text(t.apps.menu.backgroundData.unrestricted),
                  ),
                ],
              ),
            );
          },
        ),

        if (appStore?.supportsArchiving ?? false) ...[
          Divider(height: 32),

          Text(t.apps.menu.archive.title, style: theme.textTheme.bodyLarge),
          Text(
            t.apps.menu.archive.explanation,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 4),
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

        Divider(height: 32),

        Text(t.apps.menu.stop.title, style: theme.textTheme.bodyLarge),
        Text(
          t.apps.menu.stop.softStop.explanation,
          style: theme.textTheme.labelLarge,
        ),
        SizedBox(height: 4),
        ElevatedButton(
          onPressed: () {
            Adb.softStop(deviceSerial, app);
          },
          child: Text(t.apps.menu.stop.softStop.button),
        ),
        SizedBox(height: 4),
        Text(
          t.apps.menu.stop.forceStop.explanation,
          style: theme.textTheme.labelLarge,
        ),
        SizedBox(height: 4),
        ElevatedButton(
          onPressed: () {
            Adb.forceStop(deviceSerial, app);
          },
          child: Text(t.apps.menu.stop.forceStop.button),
        ),
      ],
    );
  }
}
