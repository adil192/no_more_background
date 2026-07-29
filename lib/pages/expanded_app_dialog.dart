import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/components/app_icon.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/app_stores.dart';
import 'package:no_more_background/data/fonts.dart';
import 'package:no_more_background/i18n/strings.g.dart';

class ExpandedAppDialog extends StatelessWidget {
  const ExpandedAppDialog({
    super.key,
    required this.app,
    required this.deviceSerial,
    required this.permissions,
    required this.setBackgroundActivity,
    required this.toggleArchived,
  });

  final AdbApp app;
  final String deviceSerial;
  final AdbAppPermissions permissions;
  final void Function(BackgroundActivity) setBackgroundActivity;
  final Future<void> Function() toggleArchived;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: .symmetric(vertical: 16, horizontal: 8),
        child: SingleChildScrollView(child: _buildContent(context)),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final installer = AppStore.stores[app.installer];
    final theme = Theme.of(context);

    const copyBtnSize = Size.square(24);
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
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.2,
                  fontSize: 20,
                ),
              ),
            ),
            IconButton(
              style: .new(
                tapTargetSize: .shrinkWrap,
                minimumSize: .all(copyBtnSize),
                fixedSize: .all(copyBtnSize),
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
                style: theme.textTheme.labelMedium?.copyWith(
                  fontSize: 14,
                  height: 1.2,
                  fontFamily: kMonoFont.primary,
                  fontFamilyFallback: kMonoFont.fallbacks,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),
            IconButton(
              style: .new(
                tapTargetSize: .shrinkWrap,
                minimumSize: .all(copyBtnSize),
                fixedSize: .all(copyBtnSize),
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

        Divider(height: 32, indent: 32, endIndent: 32),

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
                children: [
                  RadioListTile.adaptive(
                    value: BackgroundActivity.reduced,
                    title: Text(t.apps.menu.background.reduced),
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.auto,
                    title: Text(t.apps.menu.background.auto),
                  ),
                  RadioListTile.adaptive(
                    value: BackgroundActivity.unrestricted,
                    title: Text(t.apps.menu.background.unrestricted),
                  ),
                ],
              ),
            );
          },
        ),

        Divider(height: 32, indent: 32, endIndent: 32),

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
