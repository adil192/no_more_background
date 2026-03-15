import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/delta_icons.dart';

const _appIconSize = 40.0;

/// Shows an app's icon.
///
/// On Android, this uses icons taken directly from the system via a platform
/// view.
///
/// On other platforms, we use icons from DeltaIcons.
class AppIcon extends StatelessWidget {
  const AppIcon(this.app, {super.key});

  final AdbApp app;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(dimension: _appIconSize, child: _BestAppIcon(app));
  }
}

class _BestAppIcon extends StatelessWidget {
  const _BestAppIcon(this.app);

  final AdbApp app;

  @override
  Widget build(BuildContext context) {
    final deltaIcon = DeltaIcons.getIcon(app.packageName);

    /// Android doesn't give us the icon for archived/uninstalled apps.
    /// If we have a Delta icon, use it instead.
    final deltaHasIconButAndroidDoesnt = deltaIcon != null && app.isUninstalled;

    if (Platform.isAndroid && !deltaHasIconButAndroidDoesnt) {
      // Opacity is handled by the platform view.
      return AndroidView(
        viewType: 'AppIconPlatformView',
        hitTestBehavior: .transparent,
        creationParams: {"packageName": app.packageName},
        creationParamsCodec: const StandardMessageCodec(),
        clipBehavior: .none,
      );
    } else if (deltaIcon == null) {
      return Center(
        child: Opacity(opacity: 0.3, child: Icon(Icons.android, size: 24)),
      );
    } else {
      return Opacity(
        opacity: app.isUninstalled ? 0.3 : 1.0,
        child: Image(
          image: deltaIcon,
          width: _appIconSize,
          height: _appIconSize,
        ),
      );
    }
  }
}
