import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';
import 'package:flutter_application_3/provider/search_provider.dart';
import 'package:flutter_application_3/pages/personal_profile_page.dart';
import 'package:flutter_application_3/pages/main_page.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final display = await screenRetriever.getPrimaryDisplay();
    final screenSize = display.size;

    final initialWidth = (screenSize.width * 0.9).toDouble();
    final initialHeight = (screenSize.height * 0.9).toDouble();
    final initialSize = Size(initialWidth, initialHeight);

    await windowManager.setMinimumSize(Size(screenSize.width * 0.5, screenSize.height * 0.5));
    await windowManager.setMaximumSize(screenSize);
    await windowManager.setSize(initialSize);
    await windowManager.setPosition(
      Offset(screenSize.width * 0.1, screenSize.height * 0.1),
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/profile': (context) => const PersonalProfilePage(), 
        '/main': (context) => const MainPage(), 
      },
    );
  }
}
