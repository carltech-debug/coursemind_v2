import 'package:flutter/material.dart';

import 'app_colors.dart';

/// ============================================================================
/// COURSEMIND — APPLICATION TYPOGRAPHY
/// ============================================================================
///
/// Centralized text styles used throughout CourseMind.
///
/// Screen-specific text styles should only be created when a component has
/// a genuine visual requirement that is not covered by this system.
/// ============================================================================

abstract final class AppTextStyles {
  // ===========================================================================
  // DISPLAY
  // ===========================================================================

  static const TextStyle displayLarge = TextStyle(
    fontSize: 40,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -0.8,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -0.6,
  );

  // ===========================================================================
  // HEADINGS
  // ===========================================================================

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    height: 1.25,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  // ===========================================================================
  // TITLES
  // ===========================================================================

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  // ===========================================================================
  // BODY
  // ===========================================================================

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.outline,
  );

  // ===========================================================================
  // LABELS
  // ===========================================================================

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurfaceVariant,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: AppColors.outline,
    letterSpacing: 0.5,
  );

  // ===========================================================================
  // BUTTONS
  // ===========================================================================

  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    height: 1.4,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );

  // ===========================================================================
  // DASHBOARD-SPECIFIC BASE STYLES
  // ===========================================================================

  static const TextStyle dashboardGreeting = TextStyle(
    fontSize: 32,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: -0.6,
  );

  static const TextStyle dashboardSectionTitle = TextStyle(
    fontSize: 24,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle dashboardHeroTitle = TextStyle(
    fontSize: 48,
    height: 1.1,
    fontWeight: FontWeight.w800,
    color: AppColors.onPrimary,
    letterSpacing: -0.8,
  );

  static const TextStyle dashboardHeroBody = TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );
}