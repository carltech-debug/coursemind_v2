import 'package:flutter/material.dart';

import 'app_colors.dart';

/// ============================================================================
/// COURSEMIND — APPLICATION TYPOGRAPHY
/// ============================================================================
///
/// Centralized text styles used throughout CourseMind.
///
/// The approved Academic design uses Inter. The font family token is declared
/// here so all CourseMind typography resolves consistently once the font asset
/// is bundled/configured.
/// ============================================================================

abstract final class AppTextStyles {
  static const String fontFamily = 'Inter';

  // ===========================================================================
  // DISPLAY
  // ===========================================================================

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    height: 56 / 48,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -0.96,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    letterSpacing: -0.32,
  );

  // ===========================================================================
  // HEADINGS
  // ===========================================================================

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    letterSpacing: -0.32,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  // ===========================================================================
  // TITLES
  // ===========================================================================

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 28 / 18,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  // ===========================================================================
  // BODY
  // ===========================================================================

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 28 / 18,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.outline,
  );

  // ===========================================================================
  // LABELS
  // ===========================================================================

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    letterSpacing: 0.28,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurfaceVariant,
    letterSpacing: 0.28,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    color: AppColors.outline,
  );

  // ===========================================================================
  // BUTTONS
  // ===========================================================================

  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
  );

  // ===========================================================================
  // MOBILE / RESPONSIVE TOKENS
  // ===========================================================================

  static const TextStyle headlineLargeMobile = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  // ===========================================================================
  // DASHBOARD BASE STYLES
  // ===========================================================================

  static const TextStyle dashboardGreeting = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    letterSpacing: -0.32,
  );

  static const TextStyle dashboardSectionTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle dashboardHeroTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    height: 56 / 48,
    fontWeight: FontWeight.w700,
    color: AppColors.onPrimary,
    letterSpacing: -0.96,
  );

  static const TextStyle dashboardHeroBody = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );
}
