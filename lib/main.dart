import 'package:flutter/material.dart';
import 'package:no_more_background/compute/adb.dart';
import 'package:no_more_background/pages/connect_page.dart';
import 'package:yaru/yaru.dart';

Future<void> main() async {
  await Adb.ensureInitialized();
  runApp(const MyApp());
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
          highContrastTheme: yaruHighContrastLight,
          highContrastDarkTheme: yaruHighContrastDark,
          debugShowCheckedModeBanner: false,
          initialRoute: '/connect',
          routes: {'/connect': (context) => const ConnectPage()},
        );
      },
    );
  }
}
