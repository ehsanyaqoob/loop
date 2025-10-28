import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loop/theme/theme_helper.dart';
import 'package:provider/provider.dart';
import 'package:loop/theme/theme_provider.dart';
import 'package:loop/theme/colors.dart';

class LoopLoader extends StatefulWidget {
  static const int dotCount = 6;
  static const double defaultSize = 36;
  static const double defaultDotSize = 8;

  final Color? color;
  final double? size;
  final double? dotSize;
  final bool useContainer;
  final Color? containerColor;
  final double containerPadding;
  final Duration duration;
  final Curve curve;

  const LoopLoader({
    super.key, 
    this.color,
    this.size,
    this.dotSize,
    this.useContainer = false,
    this.containerColor,
    this.containerPadding = 8,
    this.duration = const Duration(milliseconds: 1200),
    this.curve = Curves.easeInOutSine,
  });

  @override
  State<LoopLoader> createState() => _LoopLoaderState();
}

class _LoopLoaderState extends State<LoopLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Use theme-aware loader color
        final Color loaderColor = widget.color ?? ThemeColors.buttonBackground(context);

        final double size = widget.size ?? LoopLoader.defaultSize;
        final double dotSize = widget.dotSize ?? LoopLoader.defaultDotSize;

        final loaderWidget = SizedBox(
          width: size,
          height: size,
          child: AnimatedBuilder(
            animation: CurvedAnimation(
              parent: _controller,
              curve: widget.curve,
            ),
            builder: (_, __) => CustomPaint(
              painter: _DotsPainter(
                progress: _controller.value,
                color: loaderColor,
                dotSize: dotSize,
                size: size,
              ),
            ),
          ),
        );

        // Return with container if requested
        if (widget.useContainer) {
          return Container(
            padding: EdgeInsets.all(widget.containerPadding),
            decoration: BoxDecoration(
              color: widget.containerColor ?? Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: loaderWidget,
          );
        }

        return loaderWidget;
      },
    );
  }
}

class _DotsPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double dotSize;
  final double size;

  _DotsPainter({
    required this.progress,
    required this.color,
    required this.dotSize,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = this.size / 2.4;

    for (int i = 0; i < LoopLoader.dotCount; i++) {
      final double angleStep = 2 * pi / LoopLoader.dotCount;
      final double angle = (progress * 2 * pi) + (i * angleStep);

      // Make pulse-like opacity transition
      final double fade = 0.5 + 0.5 * sin(progress * 2 * pi + i * 0.8);
      final Paint dotPaint = Paint()
        ..color = color.withOpacity(fade.clamp(0.3, 1.0));

      final Offset offset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawCircle(offset, dotSize / 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DotsPainter oldDelegate) =>
      oldDelegate.progress != progress || 
      oldDelegate.color != color ||
      oldDelegate.dotSize != dotSize ||
      oldDelegate.size != size;
}

// ========== CONVENIENCE LOADER VARIANTS ==========

extension LoopLoaderVariants on LoopLoader {
  // Small loader for buttons
  static LoopLoader small({Color? color, bool useContainer = false}) => LoopLoader(
    size: 24,
    dotSize: 6,
    color: color,
    useContainer: useContainer,
    duration: const Duration(milliseconds: 800),
  );

  // Medium loader for general use
  static LoopLoader medium({Color? color, bool useContainer = false}) => LoopLoader(
    size: 36,
    dotSize: 8,
    color: color,
    useContainer: useContainer,
  );

  // Large loader for full screen
  static LoopLoader large({Color? color, bool useContainer = false}) => LoopLoader(
    size: 48,
    dotSize: 10,
    color: color,
    useContainer: useContainer,
    duration: const Duration(milliseconds: 1500),
  );

  // Primary colored loader
  static LoopLoader primary({bool useContainer = false}) => LoopLoader(
    color: AppColors.primary,
    useContainer: useContainer,
  );

  // Success colored loader
  static LoopLoader success({bool useContainer = false}) => LoopLoader(
    color: AppColors.success,
    useContainer: useContainer,
  );

  // Error colored loader
  static LoopLoader error({bool useContainer = false}) => LoopLoader(
    color: AppColors.error,
    useContainer: useContainer,
  );

  // Warning colored loader
  static LoopLoader warning({bool useContainer = false}) => LoopLoader(
    color: AppColors.warning,
    useContainer: useContainer,
  );

  // With container background
  static LoopLoader withContainer({
    Color? color,
    Color? containerColor,
    double size = 36,
  }) => LoopLoader(
    color: color,
    size: size,
    useContainer: true,
    containerColor: containerColor,
  );

  // Fast loader for quick actions
  static LoopLoader fast({Color? color}) => LoopLoader(
    color: color,
    duration: const Duration(milliseconds: 600),
  );

  // Slow loader for dramatic effect
  static LoopLoader slow({Color? color}) => LoopLoader(
    color: color,
    duration: const Duration(milliseconds: 2000),
  );
}