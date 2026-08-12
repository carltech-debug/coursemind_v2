import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// ============================================================================
/// COURSEMIND — GLOBAL APPLICATION THEME
/// ============================================================================
///
/// Connects the CourseMind design system to Flutter's Material ThemeData.
///
/// Responsibilities:
/// - Configure Material 3.
/// - Apply the CourseMind color palette.
/// - Register application typography.
/// - Configure common Material components.
///
/// Colors, spacing, and typography remain defined in their dedicated files.
/// ============================================================================

abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      // ========================================================================
      // COLORS
      // ========================================================================

      scaffoldBackgroundColor: AppColors.background,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        surface: AppColors.surfaceContainerLowest,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        error: AppColors.error,
      ),

      // ========================================================================
      // TYPOGRAPHY
      // ========================================================================

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,

        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,

        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,

        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,

        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // ========================================================================
      // APP BAR
      // ========================================================================

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),

      // ========================================================================
      // CARD
      // ========================================================================

      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          side: const BorderSide(
            color: AppColors.outlineVariant,
          ),
        ),
      ),

      // ========================================================================
      // DIVIDERS
      // ========================================================================

      dividerTheme: const DividerThemeData(
        color: AppColors.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      // ========================================================================
      // INPUT FIELDS
      // ========================================================================

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainer,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),

        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(
            color: AppColors.secondary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),

      // ========================================================================
      // ELEVATED BUTTON
      // ========================================================================

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          elevation: 0,

          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),

          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ========================================================================
      // OUTLINED BUTTON
      // ========================================================================

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondary,

          side: const BorderSide(
            color: AppColors.secondary,
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),

          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ========================================================================
      // TEXT BUTTON
      // ========================================================================

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondary,

          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),

          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // ========================================================================
      // FLOATING ACTION BUTTON
      // ========================================================================

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 8,
      ),

      // ========================================================================
      // ICON BUTTON
      // ========================================================================

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.onSurfaceVariant,
        ),
      ),

      // ========================================================================
      // PROGRESS INDICATORS
      // ========================================================================

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.secondary,
        linearTrackColor: AppColors.surfaceContainer,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.secondaryFixedDim,
        onPrimary: AppColors.primaryContainer,
        secondary: AppColors.secondaryFixedDim,
        onSecondary: AppColors.primaryContainer,
        surface: Color(0xFF191C1E),
        onSurface: Color(0xFFE1E2E5),
        onSurfaceVariant: Color(0xFFC6C6CD),
        outline: Color(0xFF909096),
        outlineVariant: Color(0xFF45464D),
        error: Color(0xFFFFB4AB),
      ),
    );
  }
}