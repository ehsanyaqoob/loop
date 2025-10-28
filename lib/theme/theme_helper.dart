import 'package:flutter/material.dart';
import 'package:loop/theme/colors.dart';

// Core theme detection
bool kIsDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

// Comprehensive theme-aware color getters
class ThemeColors {
  
  // ========== CORE BACKGROUND COLORS ==========
  static Color background(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkBackground : AppColors.background;

  static Color scaffoldBackground(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkBackground : AppColors.background;

  // ========== SURFACE COLORS ==========
  static Color surface(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkSurface : AppColors.surface;

  static Color card(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkSurface : AppColors.surface;

  // ========== TEXT COLORS ==========
  static Color text(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextPrimary : AppColors.textPrimary;

  static Color subtitle(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextSecondary : AppColors.textSecondary;

  static Color hint(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextDisabled : AppColors.textDisabled;

  // ========== ICON COLORS ==========
  static Color icon(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextPrimary : AppColors.textPrimary;

  // ========== BORDER & DIVIDER COLORS ==========
  static Color border(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.borderDark : AppColors.borderLight;

  static Color divider(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.borderDark : AppColors.borderLight;

  // ========== INTERACTIVE ELEMENTS ==========
  static Color buttonBackground(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.primaryDark : AppColors.primary;

  static Color buttonText(BuildContext context) => Colors.white;

  static Color buttonDisabled(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextDisabled : AppColors.textDisabled;

  // ========== STATUS COLORS ==========
  static Color success(BuildContext context) => AppColors.success;
  static Color error(BuildContext context) => AppColors.error;
  static Color warning(BuildContext context) => AppColors.warning;
  static Color info(BuildContext context) => AppColors.info;

  // ========== INPUT FIELD COLORS ==========
  static Color inputBackground(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkSurface : AppColors.surface;

  static Color inputBorder(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.borderDark : AppColors.borderLight;

  static Color inputHint(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextDisabled : AppColors.textDisabled;

  // ========== APP BAR COLORS ==========
  static Color appBarBackground(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkSurface : AppColors.surface;

  static Color appBarText(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextPrimary : AppColors.textPrimary;

  // ========== NAVIGATION COLORS ==========
  static Color navigationBarBackground(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkSurface : AppColors.surface;

  static Color navigationBarSelected(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.primaryLight : AppColors.primary;

  static Color navigationBarUnselected(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.darkTextDisabled : AppColors.textDisabled;

  // ========== OVERLAY & SHADOW COLORS ==========
  static Color overlay(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.overlayDark : AppColors.overlayLight;

  static Color shadow(BuildContext context) =>
      kIsDarkMode(context) ? AppColors.shadowDark : AppColors.shadowLight;

  // ========== STATE COLORS ==========
  static Color focused(BuildContext context) => AppColors.focused;
  static Color pressed(BuildContext context) => AppColors.pressed;
  static Color hovered(BuildContext context) => AppColors.hovered;
  static Color disabled(BuildContext context) => AppColors.disabled;

  // ========== UTILITY METHODS ==========
  static Color custom(BuildContext context, {Color? light, Color? dark}) =>
      kIsDarkMode(context) 
          ? dark ?? AppColors.darkTextPrimary 
          : light ?? AppColors.textPrimary;

  static Color fromColorScheme(BuildContext context, Color light, Color dark) =>
      kIsDarkMode(context) ? dark : light;
}

// Extension for super clean widget usage
extension ThemeContextExtensions on BuildContext {
  // Core properties
  bool get isDarkMode => kIsDarkMode(this);
  
  // Background colors
  Color get background => ThemeColors.background(this);
  Color get scaffoldBackground => ThemeColors.scaffoldBackground(this);
  
  // Surface colors
  Color get surface => ThemeColors.surface(this);
  Color get card => ThemeColors.card(this);
  
  // Text colors
  Color get text => ThemeColors.text(this);
  Color get subtitle => ThemeColors.subtitle(this);
  Color get hint => ThemeColors.hint(this);
  
  // Icon colors
  Color get icon => ThemeColors.icon(this);
  
  // Border & divider colors
  Color get border => ThemeColors.border(this);
  Color get divider => ThemeColors.divider(this);
  
  // Status colors
  Color get success => ThemeColors.success(this);
  Color get error => ThemeColors.error(this);
  Color get warning => ThemeColors.warning(this);
  Color get info => ThemeColors.info(this);
  
  // Interactive colors
  Color get buttonBackground => ThemeColors.buttonBackground(this);
  Color get buttonText => ThemeColors.buttonText(this);
  Color get buttonDisabled => ThemeColors.buttonDisabled(this);
  
  // App bar colors
  Color get appBarBackground => ThemeColors.appBarBackground(this);
  Color get appBarText => ThemeColors.appBarText(this);
  
  // Input colors
  Color get inputBackground => ThemeColors.inputBackground(this);
  Color get inputBorder => ThemeColors.inputBorder(this);
  Color get inputHint => ThemeColors.inputHint(this);
  
  // State colors
  Color get focused => ThemeColors.focused(this);
  Color get pressed => ThemeColors.pressed(this);
  Color get hovered => ThemeColors.hovered(this);
  Color get disabled => ThemeColors.disabled(this);
  
  // Utility colors
  Color get overlay => ThemeColors.overlay(this);
  Color get shadow => ThemeColors.shadow(this);
}