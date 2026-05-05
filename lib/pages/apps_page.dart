import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_manager/components/about_this_app_button.dart';
import 'package:app_manager/components/app_tile.dart';
import 'package:app_manager/components/device_tile.dart';
import 'package:app_manager/compute/adb.dart';
import 'package:app_manager/data/adb_app.dart';
import 'package:app_manager/data/constants.dart';
import 'package:app_manager/data/is_this_a_test.dart';
import 'package:app_manager/data/stows.dart';
import 'package:app_manager/i18n/strings.g.dart';
import 'package:app_manager/pages/logs_page.dart';
import 'package:app_manager/state/use_app_list.dart';
import 'package:app_manager/state/use_app_permissions.dart';
import 'package:yaru/yaru.dart';

class AppsPage extends HookWidget {
  const AppsPage({super.key, required this.deviceSerial});

  final String deviceSerial;

  @override
  Widget build(BuildContext context) {
    final apps = useAppList(deviceSerial);
    final permissionMap = useAppPermissions(deviceSerial, apps);

    final isAndroid = Theme.of(context).platform == .android;
    final isScreenSmall = MediaQuery.sizeOf(context).width < kMaxContentWidth;

    return Scaffold(
      appBar: isAndroid
          ? AppBar(toolbarHeight: 0)
          : AppBar(
              toolbarHeight: 64,
              leading: isThisATest ? const BackButton() : null,
              title: DeviceTile(deviceSerial, imageSize: 48, padding: .zero),
            ),
      body: isScreenSmall
          ? Column(
              children: [
                _Headline(),
                Expanded(
                  child: _AppsList(
                    apps: apps,
                    deviceSerial: deviceSerial,
                    permissionMap: permissionMap,
                  ),
                ),
              ],
            )
          : Center(
              child: YaruSection(
                width: kMaxContentWidth,
                margin: const .all(kYaruPagePadding),
                padding: .zero,
                headlinePadding: .zero,
                headline: _Headline(),
                child: _AppsList(
                  apps: apps,
                  deviceSerial: deviceSerial,
                  permissionMap: permissionMap,
                ),
              ),
            ),
    );
  }
}

class _Headline extends HookWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    useListenable(stows.showSystemApps);
    useListenable(stows.showReviewedApps);
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 16);
    final theme = Theme.of(context);

    return Column(
      spacing: 16,
      crossAxisAlignment: .stretch,
      children: [
        const SizedBox.shrink(), // to add padding
        Padding(
          padding: horizontalPadding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  stows.showSystemApps.value
                      ? t.apps.title.showSystemApps
                      : t.apps.title.hideSystemApps,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogsPage()),
                ),
                tooltip: t.connect.viewLogsShortened,
                icon: Icon(Symbols.receipt_long),
              ),
              if (!Platform.isAndroid)
                IconButton(
                  onPressed: () => _showInstallApkDialog(context),
                  tooltip: t.apps.menu.installApk,
                  icon: Icon(Symbols.install_desktop),
                ),
              if (theme.platform == .android)
                IconButton(
                  onPressed: () => AboutThisAppButton.showDialog(context),
                  tooltip: t.connect.aboutShortened,
                  icon: Icon(Symbols.info),
                ),
            ],
          ),
        ),
        Padding(
          padding: horizontalPadding,
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: _CheckButton(
                  value: stows.showSystemApps.value,
                  onChanged: (value) => stows.showSystemApps.value = value!,
                  label: t.apps.filter.showSystemApps,
                ),
              ),
              Expanded(
                child: _CheckButton(
                  value: stows.showReviewedApps.value,
                  onChanged: (value) => stows.showReviewedApps.value = value!,
                  label: t.apps.filter.showReviewedApps,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final softWrap = MediaQuery.sizeOf(context).width < 360;
    return MergeSemantics(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.tertiary.withValues(
            alpha: value ? 0.3 : 0.01,
          ),
          foregroundColor: colorScheme.onSurface,
          overlayColor: colorScheme.tertiary,
          side: BorderSide(
            color: value ? Colors.transparent : colorScheme.outline,
          ),
          padding: const .all(2),
          tapTargetSize: theme.platform == .android ? null : .shrinkWrap,
        ),

        onPressed: onChanged == null ? null : () => onChanged!(!value),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            YaruCheckbox(value: value, onChanged: onChanged),
            Flexible(
              child: Padding(
                padding: .all(4),
                child: FittedBox(
                  fit: softWrap ? .none : .scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(height: 1.2),
                    softWrap: softWrap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppsList extends StatelessWidget {
  const _AppsList({
    required this.apps,
    required this.deviceSerial,
    required this.permissionMap,
  });

  final List<AdbApp> apps;
  final String deviceSerial;
  final PermissionMap permissionMap;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    return ListView.builder(
      padding: viewPadding.copyWith(top: 0),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return Stack(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuad,
              child: AppTile(
                key: ValueKey(app.packageName),
                deviceSerial: deviceSerial,
                app: app,
                permissions: permissionMap[app],
              ),
            ),
            const Positioned(bottom: 0, left: 0, right: 0, child: Divider()),
          ],
        );
      },
    );
  }
}

Future<void> _showInstallApkDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (dialogContext) => _InstallApkDialog(deviceSerial: dialogContext.findAncestorWidgetOfExactType<AppsPage>()!.deviceSerial),
  );
}

class _InstallApkDialog extends HookWidget {
  const _InstallApkDialog({required this.deviceSerial});

  final String deviceSerial;

  @override
  Widget build(BuildContext context) {
    final isInstalling = useState(false);
    final installResult = useState<String?>(null);

    return AlertDialog(
      title: Text(t.apps.menu.installApk),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (installResult.value != null) ...[
            Icon(
              installResult.value == 'success'
                  ? Icons.check_circle
                  : Icons.error,
              color: installResult.value == 'success'
                  ? Colors.green
                  : Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              installResult.value == 'success'
                  ? t.apps.installApk.success(packageName: '')
                  : t.apps.installApk.failure(error: installResult.value!),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            Text(t.apps.installApk.selectFile),
            const SizedBox(height: 16),
            if (isInstalling.value)
              const CircularProgressIndicator()
            else
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['apk'],
                    );

                    if (result == null || result.files.isEmpty) {
                      return; // User cancelled
                    }

                    final filePath = result.files.single.path;
                    if (filePath == null) {
                      installResult.value = 'error: Unable to get file path';
                      return;
                    }

                    isInstalling.value = true;

                    await Adb.installApk(deviceSerial, filePath);

                    installResult.value = 'success';
                  } catch (e) {
                    installResult.value = 'error: ${e.toString()}';
                  } finally {
                    isInstalling.value = false;
                  }
                },
                icon: const Icon(Icons.upload_file),
                label: Text(t.apps.installApk.selectFile),
              ),
          ],
        ],
      ),
      actions: [
        if (installResult.value != null)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          )
        else
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
      ],
    );
  }
}
