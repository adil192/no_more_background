import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:yaru/yaru.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  List<AdbDevice> devices = const [];

  Timer? autoRefreshTimer;

  final refreshMutex = Mutex();
  Future<void> refreshDevices() async {
    if (refreshMutex.isLocked) return;

    autoRefreshTimer?.cancel();
    await refreshMutex.protect(() async {
      if (mounted) setState(() {});
      await Future.wait([
        Adb.getDevices().then((value) => devices = value),
        Future.delayed(const Duration(seconds: 2)),
      ]);
      debugPrint('Refreshed devices: $devices');
    });
    if (mounted) setState(() {});

    if (mounted) {
      autoRefreshTimer?.cancel();
      autoRefreshTimer = Timer(const Duration(seconds: 5), refreshDevices);
    }
  }

  @override
  void initState() {
    super.initState();
    autoRefreshTimer?.cancel();
    autoRefreshTimer = Timer(const Duration(milliseconds: 100), refreshDevices);
  }

  @override
  void dispose() {
    autoRefreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            YaruInfoBox(
              yaruInfoType: YaruInfoType.danger,
              title: Text('No adb found'),
              subtitle: Text(
                'Please ensure you have adb installed and added to PATH.',
              ),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                if (index >= devices.length) return null;
                final device = devices[index];
                return _DeviceTile(device: device);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({required this.device});

  final AdbDevice device;

  @override
  Widget build(BuildContext context) {
    return YaruTile(
      title: Text(device.model ?? device.serial),
      subtitle: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          _Chip(
            title: device.state,
            yaruInfoType: device.isUsable ? null : YaruInfoType.warning,
          ),
          _Chip(title: device.state),
          _Chip(title: device.serial),
          if (device.device != null) _Chip(title: device.device!),
          if (device.product != null) _Chip(title: device.product!),
          if (device.usb != null) _Chip(title: 'USB ${device.usb}'),
        ],
      ),
      leading: Icon(YaruIcons.smartphone),
      trailing: device.isUsable
          ? YaruIconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppsPage(device: device),
                  ),
                );
              },
              icon: Icon(YaruIcons.go_next),
            )
          : YaruIconButton(onPressed: null, icon: Icon(YaruIcons.warning)),
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

class _Chip extends StatelessWidget {
  const _Chip({required this.title, this.yaruInfoType});

  final String title;
  final YaruInfoType? yaruInfoType;

  @override
  Widget build(BuildContext context) {
    return YaruInfoBadge(
      title: Text(title),
      yaruInfoType: yaruInfoType ?? YaruInfoType.information,
      color: yaruInfoType == null ? Colors.grey.shade700 : null,
    );
  }
}
