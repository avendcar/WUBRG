import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(1920, 1080));
    //Sets minimum resolution to 1080p
    WindowManager.instance.setMaximumSize(const Size(2650, 1440));
    //Sets maximum resolution to 1440p
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WUBRG',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      scrollBehavior: MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown
      }),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
