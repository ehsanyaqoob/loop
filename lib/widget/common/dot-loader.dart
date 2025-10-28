import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loop/theme/colors.dart';

class LoopLoader extends StatelessWidget {
  final Color? color;
  final double size;
  final double dotSize;
  final Duration duration;
  final bool useContainer;
  final Color? containerColor;
  final double containerPadding;

  const LoopLoader({
    super.key,
    this.color,
    this.size = 20,
    this.dotSize = 4,
    this.duration = const Duration(milliseconds: 600),
    this.useContainer = false,
    this.containerColor,
    this.containerPadding = 4,
  });

  @override
  Widget build(BuildContext context) {
    final loader = _DotLoaderWidget(
      color: color ?? AppColors.primary,
      size: size,
      dotSize: dotSize,
      duration: duration,
    );

    if (useContainer) {
      return Container(
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          color: containerColor ?? Colors.grey.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: loader,
      );
    }

    return loader;
  }
}

class _DotLoaderWidget extends StatefulWidget {
  final Color color;
  final double size;
  final double dotSize;
  final Duration duration;

  const _DotLoaderWidget({
    required this.color,
    required this.size,
    required this.dotSize,
    required this.duration,
  });

  @override
  State<_DotLoaderWidget> createState() => _DotLoaderWidgetState();
}

class _DotLoaderWidgetState extends State<_DotLoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _DotLoaderPainter(
              progress: _controller.value,
              color: widget.color,
              dotSize: widget.dotSize,
            ),
          );
        },
      ),
    );
  }
}

class _DotLoaderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double dotSize;

  _DotLoaderPainter({
    required this.progress,
    required this.color,
    required this.dotSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - dotSize;

    // Draw 3 dots that animate around a circle
    for (int i = 0; i < 3; i++) {
      final angle = 2 * pi * (progress + i / 3);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      
      // Calculate opacity based on position
      final dotProgress = (progress + i / 3) % 1.0;
      final opacity = dotProgress < 0.5 ? dotProgress * 2 : (1 - dotProgress) * 2;
      
      canvas.drawCircle(
        Offset(x, y),
        dotSize,
        paint..color = color.withOpacity(opacity.clamp(0.3, 1.0)),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DotLoaderPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        color != oldDelegate.color ||
        dotSize != oldDelegate.dotSize;
  }
}

// Extension for convenient loader variants
extension DotLoaderVariants on LoopLoader {
  static LoopLoader small({Color? color}) => LoopLoader(
        size: 16,
        dotSize: 3,
        color: color,
      );

  static LoopLoader medium({Color? color}) => LoopLoader(
        size: 20,
        dotSize: 4,
        color: color,
      );

  static LoopLoader large({Color? color}) => LoopLoader(
        size: 24,
        dotSize: 5,
        color: color,
      );

  static LoopLoader primary() => LoopLoader(color: AppColors.primary);
  static LoopLoader white() => LoopLoader(color: Colors.white);
  static LoopLoader error() => LoopLoader(color: AppColors.error);
}