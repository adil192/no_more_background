import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:no_more_background/components/about_this_app_button.dart';
import 'package:no_more_background/components/app_tile.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/constants.dart';
import 'package:no_more_background/data/is_this_a_test.dart';
import 'package:no_more_background/data/log_history.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:no_more_background/pages/logs_page.dart';
import 'package:no_more_background/state/use_app_list.dart';
import 'package:no_more_background/state/use_app_permissions.dart';
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
          : SafeArea(
              top: !isAndroid,
              child: Center(
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

    final searchActive = useState(false);
    final appFilter = useValueNotifier('');
    final appFilterDebouncer = useRef<Timer?>(null);
    useOnListenableChange(appFilter, () {
      appFilterDebouncer.value?.cancel();
      if (appFilter.value.isEmpty) {
        stows.appFilter.value = '';
        return;
      }
      appFilterDebouncer.value = Timer(const Duration(milliseconds: 100), () {
        stows.appFilter.value = appFilter.value;
      });
    });
    useEffect(() {
      // Cancel Timer on dispose
      return () {
        appFilterDebouncer.value?.cancel();
        stows.appFilter.value = '';
      };
    }, [appFilterDebouncer.value]);

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
                child: YaruSearchTitleField(
                  searchActive: searchActive.value,
                  onChanged: (value) => appFilter.value = value,
                  onSubmitted: (value) => appFilter.value = value ?? '',
                  onSearchActive: () {
                    searchActive.value = !searchActive.value;
                    appFilter.value = '';
                  },
                  onClear: () => appFilter.value = '',
                  text: appFilter.value,
                  hintText: t.apps.title.searchYourApps,
                  title: Text(
                    t.apps.title.yourApps,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              _RedDot(
                child: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogsPage()),
                  ),
                  tooltip: t.connect.viewLogsShortened,
                  icon: Icon(Symbols.receipt_long),
                ),
              ),
              if (theme.platform == .android)
                // Android doesn't use the Connect page which usually contains the About button
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

/// Displays a red dot if there are any errors in the log.
class _RedDot extends HookWidget {
  const _RedDot({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasError = useListenableSelector(logHistory, () {
      final logs = logHistory.value;
      return logs.any((log) => log.level >= Level.SEVERE);
    });
    final textDirection = Directionality.of(context);
    final colorScheme = ColorScheme.of(context);
    const dotSize = 8.0;
    return Stack(
      children: [
        Positioned.directional(
          textDirection: textDirection,
          top: dotSize / 2,
          end: dotSize / 2,
          child: SizedBox.square(
            dimension: dotSize,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: .circle,
                color: hasError ? colorScheme.error : null,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
