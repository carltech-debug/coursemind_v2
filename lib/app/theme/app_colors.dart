import 'package:flutter/material.dart';

/// ============================================================================
/// COURSEMIND — APPLICATION COLOR PALETTE
/// ============================================================================
///
/// Centralized color definitions for the entire CourseMind application.
///
/// UI components should reference this class instead of defining their own
/// application colors.
/// ============================================================================

abstract final class AppColors {
  // ===========================================================================
  // BRAND
  // ===========================================================================

  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF4B41E1);

  static const Color primaryContainer = Color(0xFF131B2E);
  static const Color secondaryContainer = Color(0xFF645EFB);
  static const Color secondaryFixedDim = Color(0xFFC3C0FF);

  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFFFFFBFF);

  // ===========================================================================
  // SURFACES
  // ===========================================================================

  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFF7F9FB);

  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F6);
  static const Color surfaceContainer = Color(0xFFECEEF0);
  static const Color surfaceContainerHigh = Color(0xFFE6E8EA);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E5);

  static const Color surfaceDim = Color(0xFFD8DADC);
  static const Color surfaceBright = Color(0xFFF7F9FB);

  // ===========================================================================
  // TEXT
  // ===========================================================================

  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF45464D);

  // ===========================================================================
  // OUTLINES
  // ===========================================================================

  static const Color outline = Color(0xFF76777D);
  static const Color outlineVariant = Color(0xFFC6C6CD);

  // ===========================================================================
  // SEMANTIC
  // ===========================================================================

  static const Color error = Color(0xFFBA1A1A);

  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF2563EB);
}