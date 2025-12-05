import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/data/icon_pack.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([Adb.ensureInitialized(), IconPack.init()]);
  _addLicenses();
  runApp(const MyApp());
}

void _addLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'Delta-Icons',
    ], await rootBundle.loadString('assets/Delta-Icons-License.txt'));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _appKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, _) {
        return MaterialApp(
          key: _appKey,
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/connect',
          routes: {'/connect': (context) => const ConnectPage()},
        );
      },
    );
  }
}
