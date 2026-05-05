import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_manager/components/about_this_app_button.dart';
import 'package:app_manager/components/device_tile.dart';
import 'package:app_manager/components/how_to_install_adb.dart';
import 'package:app_manager/components/how_to_install_shizuku.dart';
import 'package:app_manager/compute/adb.dart';
import 'package:app_manager/data/adb_device.dart';
import 'package:app_manager/data/constants.dart';
import 'package:app_manager/data/is_this_a_test.dart';
import 'package:app_manager/data/stows.dart';
import 'package:app_manager/data/workers.dart';
import 'package:app_manager/i18n/strings.g.dart';
import 'package:app_manager/pages/apps_page.dart';
import 'package:app_manager/pages/logs_page.dart';
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
    final isManuallyRefreshing = useState(false);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        minimum: .symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(
              numDevices: devices.length,
              manuallyRefresh: () async {
                isManuallyRefreshing.value = true;
                try {
                  Adb.impl ??= await Adb.findAdb();
                  await deviceScanner.requestPoll();
                  await Future.delayed(deviceScanner.interval);
                } finally {
                  isManuallyRefreshing.value = false;
                }
              },
              isManuallyRefreshing: isManuallyRefreshing.value,
            ),
            const SizedBox(height: 32),

            if (Adb.impl == null)
              if (theme.platform == .android)
                const Expanded(child: HowToInstallShizuku())
              else
                const Expanded(child: HowToInstallAdb())
            else if (devices.isEmpty)
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/cocomaterial/read_tap_smartphone_man.svg',
                    colorFilter: .mode(
                      theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      .srcIn,
                    ),
                    width: min(256, screenSize.shortestSide / 2),
                  ),
                ),
              )
            else
              Expanded(child: _ConnectPageContentDevices(devices: devices)),

            Row(
              children: [
                const AboutThisAppButton(),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogsPage()),
                    );
                  },
                  child: Text(t.connect.viewLogs),
                ),
              ],
            ),
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
        const iconSize = 28.0;
        return InkWell(
          onTap: onPressed,
          child: DeviceTile(
            device.serial,
            trailing: YaruIconButton(
              onPressed: onPressed,
              iconSize: iconSize,
              icon: Icon(switch (device.state) {
                'unauthorized' => Symbols.mobile_alert,
                'disconnected' => Symbols.usb_off,
                _ =>
                  device.isUsable ? Symbols.chevron_forward : Symbols.warning,
              }, size: iconSize),
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
    required this.manuallyRefresh,
    required this.isManuallyRefreshing,
  });

  final int numDevices;
  final VoidCallback manuallyRefresh;
  final bool isManuallyRefreshing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: 4,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: .scaleDown,
                child: Text(
                  t.connect.header.title,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              Text(
                t.connect.header.subtitle(n: numDevices),
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        if (!kReleaseMode && !isThisATest)
          ValueListenableBuilder<bool>(
            valueListenable: stows.useFakeAdb,
            builder: (context, useFakeAdb, setState) {
              return Column(
                children: [
                  Text(useFakeAdb ? t.connect.adb.fake : t.connect.adb.real),
                  Switch.adaptive(
                    value: useFakeAdb,
                    onChanged: (useFakeAdb) async {
                      if (kReleaseMode) return;
                      stows.useFakeAdb.value = useFakeAdb;
                      Adb.impl = await Adb.findAdb();
                      manuallyRefresh();
                    },
                  ),
                ],
              );
            },
          ),
        FilledButton(
          onPressed: isManuallyRefreshing ? null : manuallyRefresh,
          child: isManuallyRefreshing
              ? _TextSizedProgressIndicator()
              : Text(t.connect.refresh),
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
      width: height * 2.58,
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
