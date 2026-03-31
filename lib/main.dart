/**
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:subliminal/visual/main_bottom_nav/main_bottom_nav_screen.dart';
import 'visual/splash/splash_screen.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Free Trial App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      home: const MainBottomNavScreen(),
    );
  }
}*/





///
///
///
///
/// todO:: adding flash
///
///
///



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subliminal/visual/main_bottom_nav/main_bottom_nav_screen.dart';

import 'core/flash_screen.dart';
import 'core/flash_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Timer? flashTimer;

void startFlashTimer(int intervalMs) {
  flashTimer?.cancel();
  flashTimer = Timer.periodic(Duration(milliseconds: intervalMs), (_) {
    navigatorKey.currentState?.push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const FlashScreen(),
      ),
    );
  });
}

void stopFlashTimer() {
  flashTimer?.cancel();
  flashTimer = null;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlashService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Free Trial App',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainBottomNavScreen(),
    );
  }
}