import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppBackground {
  static const _channel = MethodChannel('com.annalouangamat.subliminal/app');

  /// Sends the app to background (like pressing Home button).
  /// The overlay keeps running independently.
  static Future<void> moveToBackground() async {
    try {
      await _channel.invokeMethod('moveToBackground');
    } catch (e) {
      debugPrint('moveToBackground error: $e');
    }
  }
}