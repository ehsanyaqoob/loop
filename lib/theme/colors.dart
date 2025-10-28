import 'package:flutter/material.dart';

class AppColors {
  // ========== PRIMARY COLORS (iOS Blue Accent) ==========
  static const primary = Color(0xFF007AFF);        // iOS System Blue
  static const primaryDark = Color(0xFF0A84FF);    // iOS Blue (Dark Mode)
  static const primaryLight = Color(0xFF5AC8FA);   // iOS Light Blue
  
  // ========== ACCENT/SECONDARY COLORS (iOS Purple/Pink) ==========
  static const accent = Color(0xFFAF52DE);         // iOS System Purple
  static const accentDark = Color(0xFFBF5AF2);     // iOS Purple (Dark Mode)
  static const accentLight = Color(0xFFFF2D55);    // iOS Pink Accent
  
  // ========== NEUTRAL COLORS - LIGHT THEME ==========
  static const background = Color(0xFFF2F2F7);     // iOS System Background
  static const surface = Color(0xFFFFFFFF);        // iOS Elevated Surface
  static const surfaceSecondary = Color(0xFFF9F9F9); // Subtle elevated surface
  static const onSurface = Color(0xFF000000);
  static const onBackground = Color(0xFF1C1C1E);
  
  // ========== NEUTRAL COLORS - DARK THEME ==========
  static const darkBackground = Color(0xFF000000);    // True black for OLED
  static const darkSurface = Color(0xFF1C1C1E);       // iOS Dark elevated surface
  static const darkSurfaceSecondary = Color(0xFF2C2C2E); // iOS Secondary dark surface
  static const darkOnSurface = Color(0xFFFFFFFF);
  static const darkOnBackground = Color(0xFFE5E5EA);
  
  // ========== SEMANTIC COLORS (iOS Native) ==========
  static const error = Color(0xFFFF3B30);          // iOS System Red
  static const success = Color(0xFF34C759);        // iOS System Green
  static const warning = Color(0xFFFF9500);        // iOS System Orange
  static const info = Color(0xFF007AFF);           // iOS System Blue
  
  // ========== TEXT COLORS - LIGHT THEME ==========
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFF3C3C43);  // iOS Secondary Label
  static const textTertiary = Color(0xFF8E8E93);   // iOS Tertiary Label
  static const textDisabled = Color(0xFFC7C7CC);   // iOS Quaternary Label
  
  // ========== TEXT COLORS - DARK THEME ==========
  static const darkTextPrimary = Color(0xFFFFFFFF);
  static const darkTextSecondary = Color(0xFFEBEBF5); // iOS Dark Secondary
  static const darkTextTertiary = Color(0xFFAEAEB2);  // iOS Dark Tertiary
  static const darkTextDisabled = Color(0xFF636366);  // iOS Dark Quaternary
  
  // ========== BORDER COLORS ==========
  static const borderLight = Color(0xFFD1D1D6);    // iOS Separator
  static const borderDark = Color(0xFF38383A);     // iOS Dark Separator
  
  // ========== OVERLAY & SHADOW COLORS ==========
  static const overlayLight = Color(0x14000000);   // iOS light overlay
  static const overlayDark = Color(0x29FFFFFF);    // iOS dark overlay
  static const shadowLight = Color(0x1A000000);    // Subtle shadow
  static const shadowDark = Color(0x3D000000);     // Stronger shadow for dark mode
  
  // ========== STATE COLORS ==========
  static const focused = Color(0xFF007AFF);        // iOS Blue focus
  static const pressed = Color(0xFF0051D5);        // Darker blue pressed
  static const hovered = Color(0x14007AFF);        // Light blue hover
  static const disabled = Color(0xFFF2F2F7);       // iOS disabled background
  
  // ========== GRADIENT COLORS (Modern iOS Style) ==========
  static const gradientStart = Color(0xFF007AFF);  // Blue
  static const gradientMid = Color(0xFFAF52DE);    // Purple
  static const gradientEnd = Color(0xFFFF2D55);    // Pink
  
  // ========== iOS SYSTEM COLORS (Extended Palette) ==========
  static const systemIndigo = Color(0xFF5856D6);
  static const systemIndigo_dark = Color(0xFF5E5CE6);
  static const systemTeal = Color(0xFF5AC8FA);
  static const systemTeal_dark = Color(0xFF64D2FF);
  static const systemMint = Color(0xFF00C7BE);
  static const systemMint_dark = Color(0xFF63E6E2);
  static const systemCyan = Color(0xFF32ADE6);
  static const systemCyan_dark = Color(0xFF64D2FF);
  
  // ========== SOCIAL BRAND COLORS ==========
  static const googleRed = Color(0xFFDB4437);
  static const facebookBlue = Color(0xFF1877F2);   // Updated FB blue
  static const appleBlack = Color(0xFF000000);
  static const twitterBlue = Color(0xFF1DA1F2);
  static const instagramPink = Color(0xFFE4405F);
  static const instagramPurple = Color(0xFF833AB4);
  
  // ========== FILL COLORS (iOS Native) ==========
  static const fillLight = Color(0x33787880);      // iOS Fill
  static const fillSecondary = Color(0x29787880);  // iOS Secondary Fill
  static const fillTertiary = Color(0x1F767680);   // iOS Tertiary Fill
  
  static const fillDark = Color(0x5C787880);       // iOS Dark Fill
  static const fillSecondaryDark = Color(0x52787880);
  static const fillTertiaryDark = Color(0x3D767680);
  
  // ========== GROUPED BACKGROUND COLORS ==========
  static const groupedBackgroundLight = Color(0xFFF2F2F7);
  static const groupedBackgroundDark = Color(0xFF000000);
  static const groupedSurfaceLight = Color(0xFFFFFFFF);
  static const groupedSurfaceDark = Color(0xFF1C1C1E);
}