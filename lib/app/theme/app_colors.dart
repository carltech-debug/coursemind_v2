import 'package:flutter/material.dart';

/// ============================================================================
/// COURSEMIND — APPLICATION COLOR PALETTE
/// ============================================================================
///
/// Centralized color definitions for the entire CourseMind application.
///
/// The current visual system uses the Institution/Academic glassmorphism
/// palette supplied from the approved design source. Feature code should
/// reference AppColors instead of defining application colors locally.
/// ============================================================================

abstract final class AppColors {
  // ===========================================================================
  // BRAND / PRIMARY
  // ===========================================================================

  static const Color primary = Color(0xFF3525CD);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF4F46E5);
  static const Color onPrimaryContainer = Color(0xFFDAD7FF);
  static const Color primaryFixed = Color(0xFFE2DFFF);
  static const Color primaryFixedDim = Color(0xFFC3C0FF);
  static const Color onPrimaryFixed = Color(0xFF0F0069);
  static const Color onPrimaryFixedVariant = Color(0xFF3323CC);
  static const Color inversePrimary = Color(0xFFC3C0FF);

  // ===========================================================================
  // SECONDARY
  // ===========================================================================

  static const Color secondary = Color(0xFF5A5E69);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFDEE2EF);
  static const Color onSecondaryContainer = Color(0xFF60646F);
  static const Color secondaryFixed = Color(0xFFDEE2EF);
  static const Color secondaryFixedDim = Color(0xFFC2C6D3);
  static const Color onSecondaryFixed = Color(0xFF171C25);
  static const Color onSecondaryFixedVariant = Color(0xFF424751);

  // ===========================================================================
  // TERTIARY
  // ===========================================================================

  static const Color tertiary = Color(0xFF005338);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF006E4B);
  static const Color onTertiaryContainer = Color(0xFF67F4B7);
  static const Color tertiaryFixed = Color(0xFF6FFBBE);
  static const Color tertiaryFixedDim = Color(0xFF4EDEA3);
  static const Color onTertiaryFixed = Color(0xFF002113);
  static const Color onTertiaryFixedVariant = Color(0xFF005236);

  // ===========================================================================
  // SURFACES
  // ===========================================================================

  static const Color background = Color(0xFFFCF8FF);
  static const Color surface = Color(0xFFFCF8FF);
  static const Color surfaceDim = Color(0xFFDAD6FF);
  static const Color surfaceBright = Color(0xFFFCF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F2FF);
  static const Color surfaceContainer = Color(0xFFEFEBFF);
  static const Color surfaceContainerHigh = Color(0xFFE9E5FF);
  static const Color surfaceContainerHighest = Color(0xFFE3DFFF);
  static const Color surfaceVariant = Color(0xFFE3DFFF);
  static const Color surfaceTint = Color(0xFF4D44E3);

  // ===========================================================================
  // TEXT / CONTENT
  // ===========================================================================

  static const Color onSurface = Color(0xFF181445);
  static const Color onSurfaceVariant = Color(0xFF464555);
  static const Color inverseSurface = Color(0xFF2D2A5B);
  static const Color inverseOnSurface = Color(0xFFF3EEFF);

  // ===========================================================================
  // OUTLINES
  // ===========================================================================

  static const Color outline = Color(0xFF777587);
  static const Color outlineVariant = Color(0xFFC7C4D8);

  // ===========================================================================
  // SEMANTIC
  // ===========================================================================

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Existing CourseMind semantic colors retained for shared feature usage.
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF2563EB);

  // ===========================================================================
  // GLASS / OVERLAY TOKENS
  // ===========================================================================
  // These are visual tokens only. The actual BackdropFilter/glass component
  // belongs in the shared/feature widget layer, not in this theme file.

  static const Color imageOverlay = Color(0x661E1B4B);
  static const Color glassSurface = Color(0xB2FFFFFF);
  static const Color glassBorder = Color(0x66FFFFFF);

  static Color? onInverseSurface;
}
