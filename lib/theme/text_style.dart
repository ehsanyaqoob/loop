import '../export.dart';

import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Headline Styles
  static const headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  
  static const headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  static const headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  // Title Styles
  static const titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static const titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  // Body Styles
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  // Label Styles
  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static const labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  // Dark Theme Variants
  static TextStyle get headlineLargeDark => headlineLarge.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle get headlineMediumDark => headlineMedium.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle get headlineSmallDark => headlineSmall.copyWith(color: AppColors.darkTextPrimary);
  
  static TextStyle get titleLargeDark => titleLarge.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle get titleMediumDark => titleMedium.copyWith(color: AppColors.darkTextPrimary);
  static TextStyle get titleSmallDark => titleSmall.copyWith(color: AppColors.darkTextPrimary);
  
  static TextStyle get bodyLargeDark => bodyLarge.copyWith(color: AppColors.darkTextSecondary);
  static TextStyle get bodyMediumDark => bodyMedium.copyWith(color: AppColors.darkTextSecondary);
  static TextStyle get bodySmallDark => bodySmall.copyWith(color: AppColors.darkTextSecondary);
}