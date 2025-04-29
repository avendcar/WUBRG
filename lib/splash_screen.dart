import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/main_page.dart';
import 'pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  final List<Color> _wubrgColors = [
    Colors.white,
    Colors.blue,
    Colors.black,
    Colors.red,
    Colors.green,
  ];

  @override
  void initState() {
    super.initState();

    // Animate through WUBRG colors
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _colorAnimation = TweenSequence<Color?>(
      List.generate(_wubrgColors.length - 1, (i) {
        return TweenSequenceItem(
          tween: ColorTween(begin: _wubrgColors[i], end: _wubrgColors[i + 1]),
          weight: 1.0,
        );
      }),
    ).animate(_controller);

    _startTransition();
  }

  Future<void> _startTransition() async {
    // Ensures splash shows for at least 2 seconds
    await Future.delayed(const Duration(seconds: 3));

    final user = FirebaseAuth.instance.currentUser;

    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => user != null ? const MainPage() : const HomePage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value ?? Colors.black,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Replace with your app logo if you have one
                Image.asset(
                  'images/wubrg-logo2.png', // <-- Make sure this exists in your assets folder
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "",
                  style: TextStyle(
                    fontFamily: "Belwe",
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
