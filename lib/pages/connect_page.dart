import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:no_more_background/components/about_this_app_button.dart';
import 'package:no_more_background/components/connect_page_content_no_adb.dart';
import 'package:no_more_background/components/device_tile.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/adb_device.dart';
import 'package:no_more_background/data/constants.dart';
import 'package:no_more_background/data/workers.dart';
import 'package:no_more_background/pages/apps_page.dart';
import 'package:yaru/yaru.dart';

class ConnectPage extends HookWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceScanner = useListenable(workers.deviceScanner);
    final devices = useMemoized(() {
      final devices = deviceScanner.value?.toList();
      if (devices == null) return const <AdbDevice>[];
      final connectedDevices = devices
          .where((device) => device.state != 'disconnected')
          .toList();
      if (connectedDevices.isNotEmpty) {
        return connectedDevices;
      } else {
        return devices;
      }
    }, [deviceScanner.value]);
    final isPolling = useValueListenable(deviceScanner.isPolling);

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(
              numDevices: devices.length,
              refresh: deviceScanner.requestPoll,
              isRefreshing: isPolling,
            ),
            const SizedBox(height: 32),

            if (Adb.impl == null)
              const Expanded(child: ConnectPageContentNoAdb())
            else
              Expanded(child: _ConnectPageContentDevices(devices: devices)),

            const AboutThisAppButton(),
          ],
        ),
      ),
    );
  }
}

class _ConnectPageContentDevices extends StatelessWidget {
  const _ConnectPageContentDevices({required this.devices});

  final List<AdbDevice> devices;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ListView.builder(
      padding: .symmetric(
        horizontal: max(0, (screenWidth - kMaxContentWidth) / 2),
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        if (index >= devices.length) return null;
        final device = devices[index];
        final onPressed = device.isUsable
            ? () {
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppsPage(deviceSerial: device.serial),
                  ),
                );
              }
            : null;
        return InkWell(
          onTap: onPressed,
          child: DeviceTile(
            device.serial,
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
