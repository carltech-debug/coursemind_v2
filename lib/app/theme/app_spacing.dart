import 'package:flutter/material.dart';

/// ============================================================================
/// COURSEMIND — APPLICATION SPACING SYSTEM
/// ============================================================================
///
/// Centralized spacing, padding, layout, and radius values used throughout
/// CourseMind.
///
/// Widgets should use these constants instead of arbitrary spacing values.
/// ============================================================================

abstract final class AppSpacing {
  // ===========================================================================
  // BASE SPACING SCALE
  // ===========================================================================

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;
  static const double xxxl = 48.0;
  static const double huge = 64.0;

  // ===========================================================================
  // COMMON PADDING
  // ===========================================================================

  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  // ===========================================================================
  // HORIZONTAL PADDING
  // ===========================================================================

  static const EdgeInsets horizontalSm =
      EdgeInsets.symmetric(horizontal: sm);

  static const EdgeInsets horizontalMd =
      EdgeInsets.symmetric(horizontal: md);

  static const EdgeInsets horizontalLg =
      EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets horizontalXl =
      EdgeInsets.symmetric(horizontal: xl);

  // ===========================================================================
  // VERTICAL PADDING
  // ===========================================================================

  static const EdgeInsets verticalSm =
      EdgeInsets.symmetric(vertical: sm);

  static const EdgeInsets verticalMd =
      EdgeInsets.symmetric(vertical: md);

  static const EdgeInsets verticalLg =
      EdgeInsets.symmetric(vertical: lg);

  static const EdgeInsets verticalXl =
      EdgeInsets.symmetric(vertical: xl);

  // ===========================================================================
  // BORDER RADIUS
  // ===========================================================================

  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusXxl = 20.0;
  static const double radiusRound = 999.0;

  // ===========================================================================
  // COMMON BORDER RADIUS OBJECTS
  // ===========================================================================

  static final BorderRadius borderRadiusSm =
      BorderRadius.circular(radiusSm);

  static final BorderRadius borderRadiusMd =
      BorderRadius.circular(radiusMd);

  static final BorderRadius borderRadiusLg =
      BorderRadius.circular(radiusLg);

  static final BorderRadius borderRadiusXl =
      BorderRadius.circular(radiusXl);

  static final BorderRadius borderRadiusRound =
      BorderRadius.circular(radiusRound);

  // ===========================================================================
  // DASHBOARD / LARGE LAYOUT
  // ===========================================================================

  static const double dashboardSidebarWidth = 256.0;
  static const double dashboardHeaderHeight = 64.0;
  static const double dashboardMaxWidth = 1280.0;
}