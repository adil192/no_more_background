import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:no_more_background/components/app_icon.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/app_stores.dart';
import 'package:no_more_background/data/fonts.dart';
import 'package:no_more_background/data/reviewed_app.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:no_more_background/i18n/strings.g.dart';
import 'package:no_more_background/pages/expanded_app_dialog.dart';
import 'package:yaru/yaru.dart';

class AppTile extends StatefulHookWidget {
  const AppTile({
    super.key,
    required this.app,
    required this.deviceSerial,
    required this.permissions,
  });

  final AdbApp app;
  final String deviceSerial;
  final AdbAppPermissions? permissions;

  @override
  State<AppTile> createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> {
  late var reviewedApp = stows.reviewedAppsBySerial.value[widget.deviceSerial]
      ?.firstWhereOrNull(
        (reviewedApp) => reviewedApp.packageName == widget.app.packageName,
      );
  ReviewStatus getReviewStatus() {
    if (widget.app.isUninstalled) return .accepted;
    final reviewedApp = this.reviewedApp;
    if (reviewedApp == null) return .none;
    if (reviewedApp.permissions == widget.permissions) return .accepted;
    return .deviated;
  }

  set isReviewed(bool isReviewed) {
    if (!isReviewed) {
      reviewedApp = null;
      stows.reviewedAppsBySerial.value[widget.deviceSerial]?.removeWhere(
        (reviewedApp) => reviewedApp.packageName == widget.app.packageName,
      );
    } else if (widget.permissions != null) {
      (stows.reviewedAppsBySerial.value[widget.deviceSerial] ??= [])
        ..removeWhere(
          (reviewedApp) => reviewedApp.packageName == widget.app.packageName,
        )
        ..add(
          reviewedApp = ReviewedApp(
            packageName: widget.app.packageName,
            permissions: widget.permissions!.copy(),
          ),
        );
    }
    stows.reviewedAppsBySerial.notifyListeners();
  }

  void restoreDeviatedPermissions() async {
    final reviewedApp = this.reviewedApp;
    if (reviewedApp == null) return;
    await _setBackgroundActivity(reviewedApp.permissions.backgroundActivity);
    await _setUnrestrictBackgroundData(
      !reviewedApp.permissions.restrictBackgroundData,
    );
  }

  Future<void> _setBackgroundActivity(BackgroundActivity value) async {
    final permissions = widget.permissions;
    if (permissions == null) return;
    if (permissions.backgroundActivity == value) return;

    // Optimistically update UI
    permissions.backgroundActivity = value;
    if (mounted) setState(() {});

    await Adb.setBackgroundActivity(widget.deviceSerial, widget.app, value);
  }

  Future<void> _setUnrestrictBackgroundData(bool unrestricted) async {
    final permissions = widget.permissions;
    if (permissions == null) return;
    if (permissions.restrictBackgroundData == !unrestricted) return;

    // Optimistically update UI
    permissions.restrictBackgroundData = !unrestricted;
    if (mounted) setState(() {});

    await Adb.setRestrictBackgroundData(
      widget.deviceSerial,
      widget.app,
      !unrestricted,
    );
  }

  Future<void> _toggleArchived() async {
    final appStore = AppStore.stores[widget.app.installer];
    if (appStore?.supportsArchiving != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.apps.archive.notSupported(
              installer: appStore?.displayName ?? widget.app.installer,
            ),
          ),
        ),
      );
      return;
    }

    if (widget.app.isUninstalled) {
      await Adb.requestUnarchiveApp(widget.deviceSerial, widget.app);
      widget.app.isUninstalled = false;
    } else {
      await Adb.archiveApp(widget.deviceSerial, widget.app);
      widget.app.isUninstalled = true;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final showSystemApps = useValueListenable(stows.showSystemApps);
    final showReviewedApps = useValueListenable(stows.showReviewedApps);

    final hovered = useState(false);
    final Animation<double>? titleOpacity;
    if (theme.platform == .android) {
      // no hovering on Android, always show title
      titleOpacity = null;
    } else {
      final titleOpacityController = useAnimationController(
        duration: Duration(milliseconds: 70),
      );
      useMemoized(
        hovered.value
            ? titleOpacityController.forward
            : titleOpacityController.reverse,
        [hovered.value],
      );
      titleOpacity = useMemoized(
        () =>
            titleOpacityController.drive(CurveTween(curve: Curves.easeOutQuad)),
        [titleOpacityController],
      );
    }

    final lowercaseAppNames = useMemoized(
      () =>
          '${widget.app.displayName.toLowerCase()} ${widget.app.packageName.toLowerCase()}',
      [widget.app.displayName, widget.app.packageName],
    );
    final includedInAppFilter = useListenableSelector(
      stows.appFilter,
      () => lowercaseAppNames.contains(stows.appFilter.value),
    );

    final reviewStatus = getReviewStatus();
    if (reviewStatus == .accepted && !showReviewedApps) {
      return SizedBox(width: .infinity);
    }
    if (widget.app.isSystemApp && !showSystemApps) {
      return SizedBox(width: .infinity);
    }
    if (!includedInAppFilter) {
      return SizedBox(width: .infinity);
    }

    final openExpandedAppDialog = widget.permissions == null
        ? null
        : () {
            if (widget.permissions == null) return;
            showDialog(
              context: context,
              builder: (context) => ExpandedAppDialog(
                app: widget.app,
                deviceSerial: widget.deviceSerial,
                permissions: widget.permissions!,
                setBackgroundActivity: _setBackgroundActivity,
                setUnrestrictBackgroundData: _setUnrestrictBackgroundData,
                toggleArchived: _toggleArchived,
              ),
            );
          };

    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: InkWell(
        onTap: openExpandedAppDialog,
        onSecondaryTap: openExpandedAppDialog,
        child: ColoredBox(
          color: widget.app.isSystemApp
              ? theme.colorScheme.warning.withValues(alpha: 0.05)
              : Colors.transparent,
          child: _AppTileScaffold(
            title: widget.app.displayName,
            subtitle: widget.app.packageName,
            textOpacity: widget.app.isUninstalled
                ? titleOpacity?.drive(Tween(begin: 0.5, end: 1.0)) ??
                      AlwaysStoppedAnimation(0.5)
                : null,
            icon: AppIcon(widget.app),
            review: _Review(
              titleOpacity: titleOpacity,
              reviewStatus: reviewStatus,
              onChanged:
                  (widget.permissions == null || widget.app.isUninstalled)
                  ? null
                  : (value) => setState(() => isReviewed = value!),
              restoreDeviatedPermissions:
                  (widget.permissions == null || widget.app.isUninstalled)
                  ? null
                  : restoreDeviatedPermissions,
            ),
            controls: widget.app.isUninstalled
                ? [
                    _ArchiveIconButton(
                      app: widget.app,
                      titleOpacity: titleOpacity,
                    ),
                  ]
                : [
                    Builder(
                      builder: (context) {
                        final backgroundActivity =
                            widget.permissions?.backgroundActivity ?? .auto;
                        return _LabelledSwitch(
                          title: t.apps.permissions.runInBackground,
                          titleOpacity: titleOpacity,
                          value: switch (backgroundActivity) {
                            .reduced => false,
                            .auto => true,
                            .unrestricted => true,
                          },
                          danger: backgroundActivity == .unrestricted,
                          onChanged:
                              widget.permissions != null &&
                                  !widget.app.isUninstalled
                              ? (allowed) {
                                  switch (backgroundActivity) {
                                    case .reduced || .auto:
                                      _setBackgroundActivity(
                                        allowed ? .auto : .reduced,
                                      );
                                    case .unrestricted:
                                      _setBackgroundActivity(
                                        allowed ? .unrestricted : .auto,
                                      );
                                  }
                                }
                              : null,
                          thumbIcon: switch (backgroundActivity) {
                            .unrestricted => Symbols.mode_heat,
                            .reduced || .auto => Symbols.autoplay,
                          },
                        );
                      },
                    ),
                    _LabelledSwitch(
                      title: t.apps.permissions.backgroundData,
                      titleOpacity: titleOpacity,
                      value:
                          !(widget.permissions?.restrictBackgroundData ??
                              false),
                      onChanged:
                          widget.permissions != null &&
                              !widget.app.isUninstalled
                          // Note: This is inverted from restrictBackgroundData
                          ? _setUnrestrictBackgroundData
                          : null,
                      thumbIcon: Icons.cell_tower,
                    ),
                    _LabelledWidget(
                      title: t.apps.permissions.more,
                      titleOpacity: titleOpacity,
                      child: IconButton(
                        iconSize: 24,
                        icon: Icon(Symbols.tune),
                        onPressed: openExpandedAppDialog,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

class _ArchiveIconButton extends StatelessWidget {
  const _ArchiveIconButton({required this.app, this.titleOpacity});

  final AdbApp app;
  final Animation<double>? titleOpacity;

  @override
  Widget build(BuildContext context) {
    return _LabelledWidget(
      title: app.isUninstalled
          ? t.apps.archive.archived
          : t.apps.archive.archive,
      titleOpacity: titleOpacity,
      child: IconButton(
        onPressed: null,
        icon: Icon(
          app.isUninstalled ? Icons.cloud_download : Icons.cloud_upload,
        ),
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({
    required this.titleOpacity,
    required this.reviewStatus,
    required this.onChanged,
    required this.restoreDeviatedPermissions,
  });

  final Animation<double>? titleOpacity;
  final ReviewStatus reviewStatus;
  final void Function(bool? isReviewed)? onChanged;
  final void Function()? restoreDeviatedPermissions;

  @override
  Widget build(BuildContext context) {
    return _LabelledWidget(
      title: t.apps.review.reviewed,
      titleOpacity: titleOpacity,
      child: Row(
        children: [
          YaruCheckbox(value: reviewStatus == .accepted, onChanged: onChanged),
          if (reviewStatus == .deviated)
            IconButton(
              onPressed: restoreDeviatedPermissions,
              tooltip: t.apps.review.restore,
              icon: const Icon(Icons.restore),
            ),
        ],
      ),
    );
  }
}

enum ReviewStatus {
  /// The user has chosen and accepted these permissions.
  accepted,

  /// The user previously chose and accepted some permissions,
  /// but the app's permissions have since changed.
  /// We should let the user restore the accepted permissions.
  deviated,

  /// The user has not reviewed this app's permissions yet.
  none,
}

class _LabelledSwitch extends StatelessWidget {
  const _LabelledSwitch({
    required this.title,
    this.titleOpacity,
    required this.value,
    this.danger = false,
    required this.onChanged,
    required this.thumbIcon,
  });

  final String title;
  final Animation<double>? titleOpacity;
  final bool value;
  final bool danger;
  final ValueChanged<bool>? onChanged;
  final IconData thumbIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCupertino = theme.platform == .iOS || theme.platform == .macOS;
    final colorScheme = theme.colorScheme;
    return _LabelledWidget(
      title: title,
      titleOpacity: titleOpacity,
      child: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeTrackColor: danger
            ? colorScheme.error.withValues(alpha: 0.5)
            : null,
        thumbIcon: .resolveWith((states) {
          // We have to manually set the icon color due to this bug:
          // https://github.com/ubuntu/yaru.dart/issues/1065
          final Color color;
          if (states.contains(WidgetState.disabled) && !isCupertino) {
            color = colorScheme.brightness == .dark
                ? colorScheme.onSurface
                : colorScheme.onInverseSurface;
          } else {
            final alpha = states.contains(WidgetState.selected) ? 1.0 : 0.9;
            final fg = colorScheme.brightness == .dark
                ? colorScheme.onInverseSurface
                : colorScheme.onSurface;
            color = fg.withValues(alpha: alpha);
          }

          return Icon(thumbIcon, color: color);
        }),
      ),
    );
  }
}

class _LabelledWidget extends StatelessWidget {
  const _LabelledWidget({
    required this.title,
    required this.titleOpacity,
    required this.child,
  });

  final String title;
  final Animation<double>? titleOpacity;
  final Widget child;

  static TextStyle textStyleOf(BuildContext context) =>
      TextTheme.of(context).labelMedium!.copyWith(height: 1, letterSpacing: 0);

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      title,
      style: textStyleOf(context),
      textAlign: .center,
    );
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 64),
          child: titleOpacity != null
              ? FadeTransition(opacity: titleOpacity!, child: titleWidget)
              : titleWidget,
        ),
        SizedBox(height: 36, child: Center(child: child)),
      ],
    );
  }
}

class _AppTileScaffold extends StatelessWidget {
  const _AppTileScaffold({
    required this.title,
    required this.subtitle,
    this.textOpacity,
    required this.icon,
    required this.review,
    required this.controls,
  });

  final String title;
  final String subtitle;
  final Animation<double>? textOpacity;
  final Widget icon;
  final Widget review;
  final List<Widget> controls;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 8),
      child: Row(
        spacing: 4,
        children: [
          review,
          icon,
          Expanded(
            child: FadeTransition(
              opacity: textOpacity ?? const AlwaysStoppedAnimation(1.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.2),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 13,
                      height: 1.2,
                      fontFamily: kMonoFont.primary,
                      fontFamilyFallback: kMonoFont.fallbacks,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...controls,
        ],
      ),
    );
  }
}
