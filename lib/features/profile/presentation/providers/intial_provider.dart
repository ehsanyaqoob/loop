import 'package:flutter/material.dart';
import 'dart:math' as math;

class InitialProvider with ChangeNotifier {
  AnimationController? _rotationController;
  bool _isInitialized = false;

  AnimationController? get rotationController => _rotationController;
  bool get isInitialized => _isInitialized;

  void initAnimation(TickerProvider vsync) {
    if (_isInitialized) return;
    
    _rotationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    _isInitialized = true;
    notifyListeners();
  }

  void disposeController() {
    _rotationController?.dispose();
    _rotationController = null;
    _isInitialized = false;
  }

  Offset getOrbitOffset(double radius, double angleDegrees) {
    final angle = angleDegrees * (math.pi / 180);
    final dx = radius * math.cos(angle);
    final dy = radius * math.sin(angle);
    return Offset(dx, dy);
  }
}