import 'dart:async';
import 'package:loop/export.dart';

class AppToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static const Duration _toastDuration = Duration(seconds: 2);
  static const double _borderRadius = 12.0;
  static const double _fontSize = 14.0;
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  static void show(String message, BuildContext context) {
    _remove();
    final isDark = context.isDarkMode;
    final backgroundColor = isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.85);
    final textColor = isDark ? Colors.white : Colors.white;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 70,
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: _padding,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
              child: MyText(
                text: message,
                color: textColor,
                size: _fontSize,
                weight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _timer = Timer(_toastDuration, _remove);
  }

  static void _remove() {
    _timer?.cancel();
    _overlayEntry?.remove();
    _timer = null;
    _overlayEntry = null;
  }
}
