import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:no_more_background/components/connect_page_content_no_adb.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:yaru/yaru.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => ConnectPageState();

  /// Scanning devices is usually very quick, which makes the UI change
  /// abruptly. Setting a 1s minimum resolves this and doesn't noticibly
  /// slow down the user.
  @visibleForTesting
  static bool slowDownDeviceScanning = true;
}

@visibleForTesting
class ConnectPageState extends State<ConnectPage> {
  List<AdbDevice> devices = const [];

  Timer? autoRefreshTimer;
  static const _refreshInterval = Duration(seconds: 5);

  final refreshMutex = Mutex();
  Future<void> refreshDevices() async {
    if (refreshMutex.isLocked) return;

    autoRefreshTimer?.cancel();
    await refreshMutex.protect(() async {
      if (mounted) setState(() {});
      await Future.wait([
        Adb.getDevices().then((value) => devices = value),
        if (ConnectPage.slowDownDeviceScanning)
          Future.delayed(const Duration(seconds: 1)),
      ]);
      debugPrint('Refreshed devices: $devices');
    });
    if (mounted) setState(() {});

    if (mounted) {
      autoRefreshTimer?.cancel();
      autoRefreshTimer = Timer(_refreshInterval, refreshDevices);
    }
  }

  @override
  void initState() {
    super.initState();
    if (Adb.impl != null) {
      refreshDevices();
      autoRefreshTimer?.cancel();
      autoRefreshTimer = Timer(_refreshInterval, refreshDevices);
    }
  }

  @override
  void dispose() {
    autoRefreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(
              numDevices: devices.length,
              refresh: refreshDevices,
              isRefreshing: refreshMutex.isLocked,
            ),
            const SizedBox(height: 32),

            if (Adb.impl == null)
              const Expanded(child: ConnectPageContentNoAdb())
            else
              Expanded(
                child: _ConnectPageContentDevices(
                  devices: devices,
                  refreshMutex: refreshMutex,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ConnectPageContentDevices extends StatelessWidget {
  const _ConnectPageContentDevices({
    required this.devices,
    required this.refreshMutex,
  });

  final List<AdbDevice> devices;
  final Mutex refreshMutex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        if (index >= devices.length) return null;
        final device = devices[index];
        final onPressed = device.isUsable
            ? () => refreshMutex.protect(() {
                // mutex is locked until we return to this page
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppsPage(device: device),
                  ),
                );
              })
            : null;
        return InkWell(
          onTap: onPressed,
          child: DeviceTile(
            device: device,
            trailing: YaruIconButton(
              onPressed: onPressed,
              icon: Icon(
                device.isUsable ? YaruIcons.go_next : YaruIcons.warning,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.numDevices,
    required this.refresh,
    required this.isRefreshing,
  });

  final int numDevices;
  final VoidCallback refresh;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Connect your device',
                style: TextTheme.of(context).headlineMedium,
              ),
              Text(
                '$numDevices devices found',
                style: TextTheme.of(context).titleMedium,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: isRefreshing ? null : refresh,
          child: isRefreshing ? _TextSizedProgressIndicator() : Text('Refresh'),
        ),
      ],
    );
  }
}

class _TextSizedProgressIndicator extends StatelessWidget {
  const _TextSizedProgressIndicator();

  @override
  Widget build(BuildContext context) {
    final textTheme = DefaultTextStyle.of(context).style;
    final height = textTheme.fontSize! * textTheme.height!;
    return SizedBox(
      width: height * 2.5,
      height: height,
      child: Center(
        child: SizedBox(
          width: height,
          height: height,
          child: YaruCircularProgressIndicator(),
        ),
      ),
    );
  }
}
