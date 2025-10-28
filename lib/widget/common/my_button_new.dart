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
                ? LoopLoader(
                    size: loaderSize,
                    dotSize: loaderDotSize,
                    color: effectiveLoaderColor,
                    useContainer: useLoaderContainer,
                    containerColor: loaderContainerColor ?? 
                        _getLoaderContainerColor(bgColor, context),
                    containerPadding: loaderContainerPadding,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Using Icon instead of SVG for simplicity
                      // Replace with your SVG widget if needed
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

  IconData _getIconFromPath(String path) {
    // Map your icon paths to IconData
    // You can replace this with your SVG widget
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
  final bool hasicon, isleft, hasshadow, hasgrad, isactive;
  final Color? backgroundColor, fontColor;
  final String? choiceIcon;
  final double mTop, mBottom, mhoriz;
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
    this.isleft = false,
    this.mhoriz = 0,
    this.hasicon = false,
    this.hasshadow = false,
    this.mBottom = 0,
    this.hasgrad = false,
    this.isactive = true,
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
    final bgColor = isactive
        ? backgroundColor ?? context.buttonBackground
        : context.buttonDisabled;

    final txtColor = fontColor ?? context.buttonText;
    final Color effectiveLoaderColor =
        loaderColor ?? _getLoaderColorForButton(bgColor, context);

    return Container(
      margin: EdgeInsets.only(
        top: mTop,
        bottom: mBottom,
        left: mhoriz,
        right: mhoriz,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: hasgrad ? null : bgColor,
        gradient: hasgrad ? _getPrimaryGradient(context) : null,
        border: Border.all(color: outlineColor ?? context.border),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: hasshadow
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
                ? LoopLoader(
                    size: loaderSize,
                    dotSize: loaderDotSize,
                    color: effectiveLoaderColor,
                    useContainer: useLoaderContainer,
                    containerColor: loaderContainerColor ??
                        _getLoaderContainerColor(bgColor, context),
                    containerPadding: loaderContainerPadding,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (hasicon && choiceIcon != null)
                        Padding(
                          padding: isleft
                              ? const EdgeInsets.only(left: 10.0)
                              : const EdgeInsets.only(right: 6),
                          child: Icon(
                            _getIconFromPath(choiceIcon!),
                            size: 18,
                            color: txtColor,
                          ),
                        ),
                      MyText(
                        paddingLeft: hasicon ? 8 : 0,
                        text: buttonText,
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