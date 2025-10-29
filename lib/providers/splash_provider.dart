import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loop/export.dart';

class SplashProvider with ChangeNotifier {
  bool _showLoader = false;
  bool _isInitialized = false;
  Timer? _loaderTimer;
  Timer? _navigationTimer;

  bool get showLoader => _showLoader;
  bool get isInitialized => _isInitialized;

  /// Initialize splash screen with proper timing
  Future<void> initializeSplash(BuildContext context) async {
    if (_isInitialized) return;

    _isInitialized = true;

    // Show loader after initial animation completes
    _loaderTimer = Timer(const Duration(milliseconds: 1500), () {
      _showLoader = true;
      notifyListeners();
    });

    // Perform any initialization tasks
    await _performInitialization();

    // Navigate to next screen after minimum splash duration (3-4 seconds total)
    _navigationTimer = Timer(const Duration(milliseconds: 3500), () {
      _navigateToInitialScreen(context);
    });
  }

  /// Perform any app initialization tasks here
  Future<void> _performInitialization() async {
    try {
      // Add your initialization logic here:
      // - Load user preferences
      // - Check authentication status
      // - Fetch initial data
      // - Initialize services

      // Simulate some initialization work
      await Future.delayed(const Duration(milliseconds: 500));

      // Example initialization tasks:
      // await _loadUserPreferences();
      // await _checkAuthStatus();
      // await _initializeServices();
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
  }

  /// Navigate to the appropriate initial screen
  void _navigateToInitialScreen(BuildContext context) {
    if (!context.mounted) return;

 Navigate.toInitial();
  }

  /// Cancel all active timers
  void _cancelTimers() {
    _loaderTimer?.cancel();
    _navigationTimer?.cancel();
    _loaderTimer = null;
    _navigationTimer = null;
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }
}
