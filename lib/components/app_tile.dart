import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/adb_permissions.dart';
import 'package:no_more_background/data/app_stores.dart';
import 'package:no_more_background/data/is_this_a_test.dart';
import 'package:no_more_background/data/reviewed_app.dart';
import 'package:no_more_background/data/stows.dart';
import 'package:super_context_menu/super_context_menu.dart';
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
  ReviewStatus get reviewStatus {
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
    await _setRunAnyInBackground(reviewedApp.permissions.runAnyInBackground);
    await _setUnrestrictBackgroundData(
      !reviewedApp.permissions.restrictBackgroundData,
    );
  }

  Future<void> _setRunAnyInBackground(bool value) async {
    final permissions = widget.permissions;
    if (permissions == null) return;
    if (permissions.runAnyInBackground == value) return;

    // Optimistically update UI
    permissions.runAnyInBackground = value;
    if (mounted) setState(() {});

    await Adb.setRunAnyInBackground(widget.deviceSerial, widget.app, value);

    permissions.runAnyInBackground = await Adb.getRunAnyInBackground(
      widget.deviceSerial,
      widget.app,
    );
    if (mounted) setState(() {});
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
    if (mounted) setState(() {});
  }

  Future<void> _toggleArchived() async {
    if (widget.app.installer != 'com.android.vending') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Archiving not supported since app was installed by "${widget.app.installer}".',
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

  Menu? _menuProvider([MenuRequest? _]) {
    if (widget.permissions == null) return null;

    return Menu(
      title: widget.app.displayName,
      children: [
        MenuAction(
          title: widget.app.isUninstalled ? 'Request unarchive' : 'Archive',
          callback: _toggleArchived,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final showSystemApps = useValueListenable(stows.showSystemApps);
    final showReviewedApps = useValueListenable(stows.showReviewedApps);
    final showArchivedApps = useValueListenable(stows.showArchivedApps);

    final titleOpacityController = useAnimationController(
      duration: Duration(milliseconds: 70),
    );
    final titleOpacity = useMemoized(
      () => titleOpacityController.drive(CurveTween(curve: Curves.easeOutQuad)),
      [titleOpacityController],
    );
    final hovered = useState(false);
    useMemoized(
      hovered.value
          ? titleOpacityController.forward
          : titleOpacityController.reverse,
      [hovered.value],
    );

    final reviewStatus = this.reviewStatus;
    if (reviewStatus == .accepted && !showReviewedApps) {
      return SizedBox(width: .infinity);
    }
    if (widget.app.isSystemApp && !showSystemApps) {
      return SizedBox(width: .infinity);
    }
    if (widget.app.isUninstalled && !showArchivedApps) {
      return SizedBox(width: .infinity);
    }

    final showAppListing =
        AppStore.stores[widget.app.installer]?.showAppListing;

    final theme = Theme.of(context);
    const appIconSize = 40.0;
    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: _MaybeContextMenuWidget(
        menuProvider: _menuProvider,
        hitTestBehavior: .opaque,
        child: ColoredBox(
          color: widget.app.isSystemApp
              ? theme.colorScheme.warning.withValues(alpha: 0.05)
              : Colors.transparent,
          child: DecoratedBoxTransition(
            decoration: titleOpacity.drive(
              DecorationTween(
                begin: BoxDecoration(color: Colors.transparent),
                end: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: _AppTileScaffold(
              title: widget.app.displayName ?? '',
              subtitle: widget.app.packageName,
              textOpacity: widget.app.isUninstalled
                  ? titleOpacity.drive(Tween(begin: 0.5, end: 1.0))
                  : null,
              icon: SizedBox.square(
                dimension: appIconSize,
                child: Opacity(
                  opacity: (widget.app.icon == null || widget.app.isUninstalled)
                      ? 0.3
                      : 1.0,
                  child: widget.app.icon != null
                      ? Image(
                          image: widget.app.icon!,
                          width: appIconSize,
                          height: appIconSize,
                        )
                      : Icon(Icons.android, size: 24),
                ),
              ),
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
              showAppListing: showAppListing != null
                  ? () => showAppListing(widget.app.packageName)
                  : null,
              controls: widget.app.isUninstalled
                  ? [
                      _ArchiveIconButton(
                        app: widget.app,
                        titleOpacity: titleOpacity,
                      ),
                    ]
                  : [
                      _LabelledSwitch(
                        title: 'Run in bg',
                        titleOpacity: titleOpacity,
                        value: widget.permissions?.runAnyInBackground ?? false,
                        onChanged:
                            widget.permissions != null &&
                                !widget.app.isUninstalled
                            ? _setRunAnyInBackground
                            : null,
                        thumbIcon: Icons.update,
                      ),
                      _LabelledSwitch(
                        title: 'Bg data',
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
                    ],
            ),
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
    // TODO(adil192): Show "Archive" button in a right-click menu
    return _LabelledWidget(
      title: app.isUninstalled ? 'Archived' : 'Archive',
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
      title: 'Reviewed',
      titleOpacity: titleOpacity,
      child: Row(
        children: [
          YaruCheckbox(value: reviewStatus == .accepted, onChanged: onChanged),
          if (reviewStatus == .deviated)
            IconButton(
              onPressed: restoreDeviatedPermissions,
              tooltip: 'Restore reviewed permissions',
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
    required this.onChanged,
    required this.thumbIcon,
  });

  final String title;
  final Animation<double>? titleOpacity;
  final bool value;
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
      Theme.of(context).textTheme.labelMedium!.copyWith(height: 0.5);

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(title, style: textStyleOf(context));
    return Column(
      children: [
        titleOpacity != null
            ? FadeTransition(opacity: titleOpacity!, child: titleWidget)
            : titleWidget,
        SizedBox(height: 40, child: Center(child: child)),
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
    this.showAppListing,
    required this.controls,
  });

  final String title;
  final String subtitle;
  final Animation<double>? textOpacity;
  final Widget icon;
  final Widget review;
  final VoidCallback? showAppListing;
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
                  TextButton(
                    onPressed: showAppListing,
                    style: TextButton.styleFrom(
                      padding: .zero,
                      tapTargetSize: .shrinkWrap,
                      enabledMouseCursor: SystemMouseCursors.click,
                    ),
                    child: Text(title, style: theme.textTheme.bodyLarge),
                  ),
                  Text(subtitle, style: theme.textTheme.labelMedium),
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

class _MaybeContextMenuWidget extends StatelessWidget {
  const _MaybeContextMenuWidget({
    required this.menuProvider,
    required this.hitTestBehavior,
    required this.child,
  });

  final MenuProvider menuProvider;
  final HitTestBehavior hitTestBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (isThisATest) {
      // Native context menus don't work in test environment.
      return child;
    }
    return ContextMenuWidget(
      menuProvider: menuProvider,
      hitTestBehavior: hitTestBehavior,
      child: child,
    );
  }
}
