import 'package:flutter/material.dart';

/// ============================================================================
/// COURSEMIND — APPLICATION SPACING SYSTEM
/// ============================================================================
///
/// Centralized spacing, padding, layout, and radius values used throughout
/// CourseMind.
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
  // Existing radius names are retained for compatibility. The Academic
  // design adds 24px, 32px card, and full-radius tokens without changing the
  // existing 20px radiusXxl value.

  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusXxl = 20.0;
  static const double radiusXxxl = 24.0;
  static const double radiusCard = 32.0;
  static const double radiusRound = 999.0;
  static const double radiusFull = 9999.0;

  // ===========================================================================
  // COMMON BORDER RADIUS OBJECTS
  // ===========================================================================

  static final BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static final BorderRadius borderRadiusXxxl =
      BorderRadius.circular(radiusXxxl);
  static final BorderRadius borderRadiusCard =
      BorderRadius.circular(radiusCard);
  static final BorderRadius borderRadiusRound =
      BorderRadius.circular(radiusRound);
  static final BorderRadius borderRadiusFull =
      BorderRadius.circular(radiusFull);

  // ===========================================================================
  // GLASS CARD DEFAULTS
  // ===========================================================================

  static const double glassBlur = 20.0;
  static const double glassBorderWidth = 1.0;
  static const double glassShadowBlur = 32.0;
  static const double glassShadowOffsetY = 12.0;
  static const EdgeInsets glassCardPadding = EdgeInsets.all(24.0);

  // ===========================================================================
  // DASHBOARD / LARGE LAYOUT
  // ===========================================================================

  static const double dashboardSidebarWidth = 256.0;
  static const double dashboardHeaderHeight = 64.0;
  static const double dashboardMaxWidth = 1280.0;
}
