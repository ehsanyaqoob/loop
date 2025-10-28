import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loop/widget/common/toasts.dart';

class BackPressHandler {
  static const MethodChannel _channel = MethodChannel('app.channel.lifecycle');
  static DateTime? _lastPressed;

  static Future<bool> handleBackPress(BuildContext context) async {
    final now = DateTime.now();

    // Step 1: Handle double back press
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      AppToast.show('Press back again to exit', context);
      return false;
    }

    // Step 2: Handle exit behavior per platform/mode
    if (Platform.isAndroid) {
      if (kDebugMode) {
        // 👇 In debug mode: just move the app to background
        try {
          await _channel.invokeMethod('moveTaskToBack');
        } on PlatformException catch (e) {
          debugPrint("⚠️ Failed to move app to background: $e");
        }
      } else {
        // 👇 In release mode: close gracefully, app stays in recents
        await SystemNavigator.pop();
      }
    }

    return true;
  }
}


