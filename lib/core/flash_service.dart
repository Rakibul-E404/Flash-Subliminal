import 'dart:io';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:subliminal/main.dart';
import 'package:subliminal/models/settings_model.dart';

class FlashService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    tz.initializeTimeZones();

    // v21: initialize() requires named parameter 'settings'
    await _notifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestSoundPermission: false,
          requestBadgePermission: false,
        ),
      ),
    );
    _initialized = true;
  }

  static Future<void> startAndMinimize(SettingsModel settings) async {
    final intervalMs = _parseInterval(settings.showEvery);
    if (Platform.isAndroid) {
      await _startAndroid(intervalMs);
    } else if (Platform.isIOS) {
      await _startIOS(intervalMs);
    }
    await SystemNavigator.pop();
  }

  // ─── Android ──────────────────────────────────────────────────
  static Future<void> _startAndroid(int intervalMs) async {
    if (!await DashBubble.instance.hasOverlayPermission()) {
      await DashBubble.instance.requestOverlayPermission();
      if (!await DashBubble.instance.hasOverlayPermission()) return;
    }
    if (!await DashBubble.instance.hasPostNotificationsPermission()) {
      await DashBubble.instance.requestPostNotificationsPermission();
    }
    await DashBubble.instance.startBubble(
      bubbleOptions: BubbleOptions(
        bubbleIcon: 'ic_launcher',
        startLocationX: 0,
        startLocationY: 200,
        bubbleSize: 60,
        opacity: 0.0,
        enableClose: true,
        closeBehavior: CloseBehavior.following,
        distanceToClose: 100,
        enableAnimateToEdge: true,
        enableBottomShadow: false,
        keepAliveWhenAppExit: true,
      ),
      notificationOptions: NotificationOptions(
        id: 1,
        title: 'Soulminimal Flash',
        body: 'Flash session is running',
        channelId: 'flash_channel',
        channelName: 'Flash Notifications',
      ),
      onTap: () {},
    );
    startFlashTimer(intervalMs);
  }

  // ─── iOS ──────────────────────────────────────────────────────
  static Future<void> _startIOS(int intervalMs) async {
    await _notifications.cancelAll();

    final iOSPlugin = _notifications
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    await iOSPlugin?.requestPermissions(
      alert: true,
      sound: false,
      badge: false,
    );

    const notifDetails = NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: false,
        presentBadge: false,
        interruptionLevel: InterruptionLevel.timeSensitive,
      ),
    );

    final now = tz.TZDateTime.now(tz.local);

    for (int i = 1; i <= 60; i++) {
      final fireAt = now.add(Duration(milliseconds: intervalMs * i));

      // v21: all named parameters as shown in IDE
      await _notifications.zonedSchedule(
        id: i,
        scheduledDate: fireAt,
        notificationDetails: notifDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  // ─── Stop ─────────────────────────────────────────────────────
  static Future<void> stop() async {
    stopFlashTimer();
    if (Platform.isAndroid) {
      await DashBubble.instance.stopBubble();
    } else {
      await _notifications.cancelAll();
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────
  static int _parseInterval(String showEvery) {
    switch (showEvery) {
      case '300 ms':
        return 300;
      case '1 s':
        return 1000;
      case '3 s':
        return 3000;
      case '5s':
        return 5000;
      default:
        return 3000;
    }
  }
}