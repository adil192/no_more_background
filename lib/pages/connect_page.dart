import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:yaru/widgets.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  List<AdbDevice> devices = const [];

  final refreshMutex = Mutex();
  Future<void> refreshDevices() async {
    if (refreshMutex.isLocked) return;
    await refreshMutex.protect(() async {
      if (mounted) setState(() {});
      devices = await Adb.getDevices();
      print(devices);
    });
    if (mounted) setState(() {});
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

          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                if (index >= devices.length) return null;
                final device = devices[index];
                return YaruTile(
                  title: Text(device.id),
                  subtitle: Text(device.state),
                );
              },
            ),
          ),
        ],
      ),
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
          child: isRefreshing ? CircularProgressIndicator() : Text('Refresh'),
        ),
      ],
    );
  }
}
