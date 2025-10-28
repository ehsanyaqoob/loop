import 'package:flutter/material.dart';
import 'package:loop/export.dart';
import 'package:loop/widget/common/dot-loader.dart';

class MyButtonWithIcon extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onTap;
  final ValueChanged<String>? onTapWithParam;
  final String? param;
  final double? height, width;
  final double radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor, backgroundColor, outlineColor, iconColor;
  final double iconSize;
  final bool hasShadow, hasGradient, isActive, isLoading;
  final double mTop, mBottom, mHoriz;
  final Color? loaderColor;
  final double loaderSize;
  final double loaderDotSize;
  final bool useLoaderContainer;
  final Color? loaderContainerColor;
  final double loaderContainerPadding;

  const MyButtonWithIcon({
    super.key,
    this.onTap,
    this.onTapWithParam,
    required this.text,
    required this.iconPath,
    this.param,
    this.height = 50,
    this.width,
    this.radius = 16.0,
    this.fontSize,
    this.fontColor,
    this.backgroundColor,
    this.outlineColor,
    this.hasShadow = false,
    this.hasGradient = false,
    this.isActive = true,
    this.mTop = 0,
    this.mBottom = 0,
    this.mHoriz = 0,
    this.fontWeight,
    this.isLoading = false,
    this.loaderColor,
    this.iconColor,
    this.iconSize = 18,
    this.loaderSize = 20,
    this.loaderDotSize = 4,
    this.useLoaderContainer = true,
    this.loaderContainerColor,
    this.loaderContainerPadding = 4,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? backgroundColor ?? context.buttonBackground
        : context.buttonDisabled;

    final txtColor = fontColor ?? context.buttonText;
    final Color effectiveLoaderColor =
        loaderColor ?? _getLoaderColorForButton(bgColor, context);

    return Container(
      margin: EdgeInsets.only(
        top: mTop,
        bottom: mBottom,
        left: mHoriz,
        right: mHoriz,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: hasGradient ? null : bgColor,
        gradient: hasGradient ? _getPrimaryGradient(context) : null,
        border: Border.all(color: outlineColor ?? context.border),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: context.shadow,
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: isLoading
              ? null
              : () {
                  if (onTap != null) {
                    onTap!();
                  } else if (onTapWithParam != null && param != null) {
                    onTapWithParam!(param!);
                  }
                },
          child: Center(
            child: isLoading
                ? _buildLoader(effectiveLoaderColor, bgColor, context)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getIconFromPath(iconPath),
                        size: iconSize,
                        color: iconColor ?? txtColor,
                      ),
                      const SizedBox(width: 8),
                      MyText(
                        text: text,
                        fontFamily: AppFonts.Inter,
                        size: fontSize ?? 16,
                        letterSpacing: 0.5,
                        color: txtColor,
                        weight: fontWeight ?? FontWeight.w600,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(Color loaderColor, Color bgColor, BuildContext context) {
    // Use DotLoader if available, otherwise use LoopLoader
    try {
      return LoopLoader(
        size: loaderSize,
        dotSize: loaderDotSize,
        color: loaderColor,
        useContainer: useLoaderContainer,
        containerColor: loaderContainerColor ?? 
            _getLoaderContainerColor(bgColor, context),
        containerPadding: loaderContainerPadding,
      );
    } catch (e) {
      // Fallback to LoopLoader if DotLoader is not available
      return LoopLoader(
        size: loaderSize,
        color: loaderColor,
      );
    }
  }

  IconData _getIconFromPath(String path) {
    final iconMap = {
      'add': Icons.add,
      'edit': Icons.edit,
      'delete': Icons.delete,
      'share': Icons.share,
      'favorite': Icons.favorite,
      'search': Icons.search,
      'arrow_forward': Icons.arrow_forward,
    };
    return iconMap[path] ?? Icons.help_outline;
  }

  LinearGradient _getPrimaryGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        // context.primary,
        // context.primary.withOpacity(0.8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Color _getLoaderColorForButton(Color buttonBgColor, BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(buttonBgColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  Color _getLoaderContainerColor(Color buttonBgColor, BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(buttonBgColor);
    return brightness == Brightness.dark
        ? Colors.white.withOpacity(0.2)
        : Colors.black.withOpacity(0.1);
  }
}

class MyButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onTapWithParam;
  final String? param;
  final double? height;
  final double? width;
  final double radius;
  final double? fontSize;
  final Color? outlineColor;
  final bool hasIcon, isLeft, hasShadow, hasGradient, isActive;
  final Color? backgroundColor, fontColor;
  final String? choiceIcon;
  final double mTop, mBottom, mHoriz;
  final FontWeight? fontWeight;
  final bool isLoading;
  final Color? loaderColor;
  final double loaderSize;
  final double loaderDotSize;
  final bool useLoaderContainer;
  final Color? loaderContainerColor;
  final double loaderContainerPadding;

  const MyButton({
    super.key,
    this.onTap,
    this.onTapWithParam,
    required this.buttonText,
    this.height = 50,
    this.width,
    this.backgroundColor,
    this.fontColor,
    this.fontSize,
    this.outlineColor,
    this.radius = 16.0,
    this.choiceIcon,
    this.isLeft = false,
    this.mHoriz = 0,
    this.hasIcon = false,
    this.hasShadow = false,
    this.mBottom = 0,
    this.hasGradient = false,
    this.isActive = true,
    this.mTop = 0,
    this.fontWeight,
    this.isLoading = false,
    this.loaderColor,
    this.param,
    this.loaderSize = 20,
    this.loaderDotSize = 4,
    this.useLoaderContainer = true,
    this.loaderContainerColor,
    this.loaderContainerPadding = 4,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? backgroundColor ?? context.buttonBackground
        : context.buttonDisabled;

    final txtColor = fontColor ?? context.buttonText;
    final Color effectiveLoaderColor =
        loaderColor ?? _getLoaderColorForButton(bgColor, context);

    return Container(
      margin: EdgeInsets.only(
        top: mTop,
        bottom: mBottom,
        left: mHoriz,
        right: mHoriz,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: hasGradient ? null : bgColor,
        gradient: hasGradient ? _getPrimaryGradient(context) : null,
        border: Border.all(color: outlineColor ?? context.border),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: context.shadow,
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: isLoading
              ? null
              : () {
                  if (onTap != null) {
                    onTap!();
                  } else if (onTapWithParam != null && param != null) {
                    onTapWithParam!(param!);
                  }
                },
          child: Center(
            child: isLoading
                ? _buildLoader(effectiveLoaderColor, bgColor, context)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (hasIcon && choiceIcon != null && isLeft)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            _getIconFromPath(choiceIcon!),
                            size: 18,
                            color: txtColor,
                          ),
                        ),
                      MyText(
                        text: buttonText,
                        fontFamily: AppFonts.Inter,
                        size: fontSize ?? 16,
                        letterSpacing: 0.5,
                        color: txtColor,
                        weight: fontWeight ?? FontWeight.w600,
                      ),
                      if (hasIcon && choiceIcon != null && !isLeft)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            _getIconFromPath(choiceIcon!),
                            size: 18,
                            color: txtColor,
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(Color loaderColor, Color bgColor, BuildContext context) {
    try {
      return LoopLoader(
        size: loaderSize,
        dotSize: loaderDotSize,
        color: loaderColor,
        useContainer: useLoaderContainer,
        containerColor: loaderContainerColor ?? 
            _getLoaderContainerColor(bgColor, context),
        containerPadding: loaderContainerPadding,
      );
    } catch (e) {
      return LoopLoader(
        size: loaderSize,
        color: loaderColor,
      );
    }
  }

  IconData _getIconFromPath(String path) {
    final iconMap = {
      'add': Icons.add,
      'edit': Icons.edit,
      'delete': Icons.delete,
      'share': Icons.share,
      'favorite': Icons.favorite,
      'search': Icons.search,
      'arrow_forward': Icons.arrow_forward,
    };
    return iconMap[path] ?? Icons.help_outline;
  }

  LinearGradient _getPrimaryGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        // context.primary,
        // context.primary.withOpacity(0.8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Color _getLoaderColorForButton(Color buttonBgColor, BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(buttonBgColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  Color _getLoaderContainerColor(Color buttonBgColor, BuildContext context) {
    final brightness = ThemeData.estimateBrightnessForColor(buttonBgColor);
    return brightness == Brightness.dark
        ? Colors.white.withOpacity(0.2)
        : Colors.black.withOpacity(0.1);
  }
}