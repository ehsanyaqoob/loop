import 'dart:async';
import 'dart:io';
import 'package:loop/export.dart';

class AppToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static const Duration _toastDuration = Duration(seconds: 3);
  static const double _toastBorderRadius = 12.0;
  static const double _toastFontSize = 14.0;
  static const EdgeInsets _toastPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const EdgeInsets _toastMargin = EdgeInsets.only(top: 36);

  static void success(String message, BuildContext context) => _show(message, icon: Icons.check_circle, context: context);
  static void error(String message, BuildContext context) => _show(message, icon: Icons.error, context: context);
  static void warning(String message, BuildContext context) => _show(message, icon: Icons.warning, context: context);
  static void info(String message, BuildContext context) => _show(message, icon: Icons.info, context: context);

  static void _show(String message, {required IconData icon, required BuildContext context}) {
    // Try native toast first
    if (Platform.isAndroid || Platform.isIOS) {
      _showNativeToast(message, context);
    } else {
      _showOverlayToast(message, icon: icon, context: context);
    }
  }

  /// Native Toast - simple black/white based on theme
  static void _showNativeToast(String message, BuildContext context) {
    // Note: You'll need to add fluttertoast package for this
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   backgroundColor: context.text.withOpacity(0.9),
    //   textColor: context.background,
    //   fontSize: _toastFontSize,
    // );
    
    // Fallback to overlay toast if fluttertoast not available
    _showOverlayToast(message, icon: Icons.info, context: context);
  }

  /// Flutter Overlay toast - simple black/white based on theme
  static void _showOverlayToast(String message, {required IconData icon, required BuildContext context}) {
    _removeToast();
    
    final backgroundColor = context.text.withOpacity(0.9);
    final textColor = context.background;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Center(
              child: Container(
                padding: _toastPadding,
                margin: _toastMargin,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(_toastBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: textColor, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MyText(
                        text: message,
                        color: textColor,
                        size: _toastFontSize,
                        weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _timer = Timer(_toastDuration, _removeToast);
  }

  static void _removeToast() {
    _timer?.cancel();
    _timer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}