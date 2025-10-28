import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  bool _isLoading = true;
  
  bool get isLoading => _isLoading;

  SplashProvider() {
    _startSplash();
  }

  void _startSplash() {
    // Simple 4-second total delay, then navigate
    Timer(const Duration(seconds: 4), () {
      _isLoading = false;
      notifyListeners();
      _navigateToHome();
    });
  }

  void _navigateToHome() {
    print('🏠 Navigating to Home');
    // Navigator.of(context).pushReplacementNamed('/home');
  }
}