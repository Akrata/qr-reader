import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/themes/app_theme.dart';

import 'screen/screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScanListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR_Reader',
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomeScreen(),
          'mapa': (context) => const MapaScreen()
        },
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
