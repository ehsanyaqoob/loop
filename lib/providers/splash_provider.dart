import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loop/export.dart';

class SplashProvider with ChangeNotifier {
  bool _showLoader = false;
  bool _isInitialized = false;
  Timer? _loaderTimer;

  bool get showLoader => _showLoader;
  bool get isInitialized => _isInitialized;

  Future<void> awaitSplashEnd() async {
    if (_isInitialized) return;

    _isInitialized = true;

    _loaderTimer = Timer(const Duration(milliseconds: 1500), () {
      _showLoader = true;
      notifyListeners();
    });

    await Future.wait([
      Future.delayed(const Duration(milliseconds: 3500)),
      _performInitialization(),
    ]);
    
    _loaderTimer?.cancel();
    _loaderTimer = null;
  }

  Future<void> _performInitialization() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  void _cancelTimers() {
    _loaderTimer?.cancel();
    _loaderTimer = null;
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }
}