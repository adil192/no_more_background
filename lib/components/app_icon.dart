import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/data/adb_app.dart';
import 'package:no_more_background/data/delta_icons.dart';

/// Shows an app's icon.
///
/// On Android, this uses icons taken directly from the system via a platform
/// view.
///
/// On other platforms, we use icons from DeltaIcons.
class AppIcon extends StatelessWidget {
  const AppIcon(this.app, {super.key, this.size = 40});

  final AdbApp app;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: _BestAppIcon(app, size: size),
    );
  }
}

class _BestAppIcon extends StatelessWidget {
  const _BestAppIcon(this.app, {required this.size});

  final AdbApp app;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // Opacity is handled by the platform view.
      return AndroidView(
        viewType: 'AppIconPlatformView',
        hitTestBehavior: .transparent,
        creationParams: {"packageName": app.packageName},
        creationParamsCodec: const StandardMessageCodec(),
        clipBehavior: .none,
      );
    }

    final deltaIcon = DeltaIcons.getIcon(app.packageName);
    if (deltaIcon == null) {
      return Center(
        child: Opacity(
          opacity: 0.3,
          child: Icon(Icons.android, size: size * 0.6),
        ),
      );
    } else {
      return Opacity(
        opacity: app.isUninstalled ? 0.3 : 1.0,
        child: Image(image: deltaIcon, width: size, height: size),
      );
    }
  }
}
