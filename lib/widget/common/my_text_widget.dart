import 'package:loop/export.dart';

class MyText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final Color decorationColor;

  final int? maxLines;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;
  final bool respectSystemFontSize; 

  const MyText({
    super.key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines = 100,
    this.decoration = TextDecoration.none,
    this.color,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.decorationColor = Colors.transparent,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.fontStyle,
    this.respectSystemFontSize = true,
  });

  @override
  Widget build(BuildContext context) {
    // Get system text scale factor with reasonable limits
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final double effectiveTextScaleFactor = _getEffectiveTextScaleFactor(textScaleFactor);
    
    // Calculate final font size
    final double? finalFontSize = size != null 
        ? size! * effectiveTextScaleFactor
        : null;

    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop!,
        left: paddingLeft!,
        right: paddingRight!,
        bottom: paddingBottom!,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: respectSystemFontSize ? finalFontSize : size,
            color: color ?? context.text,
            fontWeight: weight,
            decoration: decoration,
            decorationColor: decorationColor,
            fontFamily: fontFamily ?? AppFonts.Figtree, // Using your font constant
            height: lineHeight ?? 1.5,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing ?? 0,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: textOverflow ?? TextOverflow.ellipsis,
          textScaler: respectSystemFontSize 
              ? const TextScaler.linear(1.0)
              : null,
        ),
      ),
    );
  }

  // Method to apply reasonable limits to text scaling
  double _getEffectiveTextScaleFactor(double systemScaleFactor) {
    const double minScale = 0.8;
    const double maxScale = 1.5;
    return systemScaleFactor.clamp(minScale, maxScale);
  }
}

// ========== PRESET TEXT STYLES ==========

extension MyTextPresets on MyText {
  // Headings with Figtree
  static MyText h1(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 32,
    weight: FontWeight.w700,
    color: color,
    fontFamily: AppFonts.Figtree,
    respectSystemFontSize: responsive,
  );

  static MyText h2(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 28,
    weight: FontWeight.w600,
    color: color,
    fontFamily: AppFonts.Figtree,
    respectSystemFontSize: responsive,
  );

  static MyText h3(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 24,
    weight: FontWeight.w600,
    color: color,
    fontFamily: AppFonts.Figtree,
    respectSystemFontSize: responsive,
  );

  // Body text with Figtree
  static MyText bodyLarge(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 18,
    weight: FontWeight.w400,
    color: color,
    fontFamily: AppFonts.Figtree,
    respectSystemFontSize: responsive,
  );

  static MyText bodyMedium(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 16,
    weight: FontWeight.w400,
    color: color,
    fontFamily: AppFonts.Figtree,
    respectSystemFontSize: responsive,
  );

  static MyText bodySmall(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 14,
    weight: FontWeight.w400,
    color: color,
    fontFamily: AppFonts.Figtree,
    respectSystemFontSize: responsive,
  );

  // Captions with Inter (for variety)
  static MyText caption(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 12,
    weight: FontWeight.w500,
    color: color ?? AppColors.textSecondary,
    fontFamily: AppFonts.Inter,
    respectSystemFontSize: responsive,
  );

  // Buttons with Figtree
  static MyText button(String text, {Color? color, bool responsive = true}) => MyText(
    text: text,
    size: 16,
    weight: FontWeight.w600,
    color: color,
    fontFamily: AppFonts.Figtree,
    respectSystemFontSize: responsive,
  );

  // Special styles
  static MyText link(String text, {VoidCallback? onTap, bool responsive = true}) => MyText(
    text: text,
    size: 14,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
    fontFamily: AppFonts.Figtree,
    onTap: onTap,
    respectSystemFontSize: responsive,
  );
}