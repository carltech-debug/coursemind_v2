/*
==============================================================================
FILE: academic_health_card.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Academic Health Card
==============================================================================

DESCRIPTION
-----------
Displays the student's academic health by comparing actual course progress
with the progress expected at the current point in the semester.

ACADEMIC HEALTH
---------------
Academic Health = (Actual Progress / Expected Progress) × 100

STATUS
------
> 90%  → Green
> 60%  → Orange
≤ 60%  → Red

The health percentage controls both the status indicator and the motivational
message.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

//=============================================================================
// ACADEMIC HEALTH CARD
//=============================================================================

final class AcademicHealthCard extends StatelessWidget {
  const AcademicHealthCard({
    required this.expectedProgress, required this.actualProgress, required this.currentMonth, required this.totalMonths, super.key,
  });

  /// Expected progress from 0.0 to 1.0.
  final double expectedProgress;

  /// Actual student progress from 0.0 to 1.0.
  final double actualProgress;

  final int currentMonth;
  final int totalMonths;

  @override
  Widget build(BuildContext context) {
    final double safeExpected =
        expectedProgress.clamp(0.0, 1.0);

    final double safeActual =
        actualProgress.clamp(0.0, 1.0);

    final double healthPercentage =
        _calculateHealth(
      expectedProgress: safeExpected,
      actualProgress: safeActual,
    );

    final _HealthStatus status =
        _getHealthStatus(healthPercentage);

    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppSpacing.borderRadiusXl,
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //===================================================================
          // HEADER
          //===================================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Academic Health',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ),

              _buildHealthIndicator(
                status: status,
                healthPercentage: healthPercentage,
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          Text(
            'Month $currentMonth of $totalMonths',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceVariant,
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          //===================================================================
          // EXPECTED / ACTUAL PROGRESS
          //===================================================================

          Row(
            children: [
              Expanded(
                child: _buildProgressColumn(
                  label: 'Expected',
                  percentage: safeExpected,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: _buildProgressColumn(
                  label: 'Your Progress',
                  percentage: safeActual,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          //===================================================================
          // MOTIVATIONAL MESSAGE
          //===================================================================

          _buildMotivationalMessage(
            status: status,
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // HEALTH CALCULATION
  //===========================================================================

  double _calculateHealth({
    required double expectedProgress,
    required double actualProgress,
  }) {
    if (expectedProgress <= 0) {
      return 100;
    }

    return (actualProgress / expectedProgress) * 100;
  }

  //===========================================================================
  // HEALTH STATUS
  //===========================================================================

  _HealthStatus _getHealthStatus(
    double healthPercentage,
  ) {
    if (healthPercentage > 90) {
      return _HealthStatus.green;
    }

    if (healthPercentage > 60) {
      return _HealthStatus.orange;
    }

    return _HealthStatus.red;
  }

  //===========================================================================
  // HEALTH INDICATOR
  //===========================================================================

  Widget _buildHealthIndicator({
    required _HealthStatus status,
    required double healthPercentage,
  }) {
    final _HealthColors colors =
        _getHealthColors(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: AppSpacing.borderRadiusRound,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colors.foreground,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(
            width: AppSpacing.xs,
          ),

          Text(
            '${healthPercentage.round()}%',
            style: TextStyle(
              color: colors.foreground,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // PROGRESS COLUMN
  //===========================================================================

  Widget _buildProgressColumn({
    required String label,
    required double percentage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.onSurfaceVariant,
          ),
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        Text(
          '${(percentage * 100).round()}%',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        ClipRRect(
          borderRadius: AppSpacing.borderRadiusRound,
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 6,
            backgroundColor:
                AppColors.surfaceContainerHigh,
            valueColor:
                const AlwaysStoppedAnimation<Color>(
              AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  //===========================================================================
  // MOTIVATIONAL MESSAGE
  //===========================================================================

  Widget _buildMotivationalMessage({
    required _HealthStatus status,
  }) {
    final _HealthColors colors =
        _getHealthColors(status);

    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingMd,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            colors.icon,
            color: colors.foreground,
            size: 20,
          ),

          const SizedBox(
            width: AppSpacing.sm,
          ),

          Expanded(
            child: Text(
              _getMotivationalMessage(status),
              style: TextStyle(
                color: colors.foreground,
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // MOTIVATIONAL TEXT
  //===========================================================================

  String _getMotivationalMessage(
    _HealthStatus status,
  ) {
    switch (status) {
      case _HealthStatus.green:
        return 'Excellent work! You are ahead of your expected pace. Keep up the momentum.';

      case _HealthStatus.orange:
        return 'You are making good progress. Stay consistent and keep pushing toward your target.';

      case _HealthStatus.red:
        return 'Your progress is falling behind the expected pace. Increase your study effort to get back on track.';
    }
  }

  //===========================================================================
  // COLORS
  //===========================================================================

  _HealthColors _getHealthColors(
    _HealthStatus status,
  ) {
    switch (status) {
      case _HealthStatus.green:
        return const _HealthColors(
          background: Color(0xFFE8F5E9),
          foreground: Color(0xFF2E7D32),
          icon: Icons.trending_up,
        );

      case _HealthStatus.orange:
        return const _HealthColors(
          background: Color(0xFFFFF3E0),
          foreground: Color(0xFFE65100),
          icon: Icons.trending_flat,
        );

      case _HealthStatus.red:
        return const _HealthColors(
          background: Color(0xFFFFEBEE),
          foreground: Color(0xFFC62828),
          icon: Icons.warning_amber_rounded,
        );
    }
  }
}

//=============================================================================
// HEALTH STATUS
//=============================================================================

enum _HealthStatus {
  green,
  orange,
  red,
}

//=============================================================================
// HEALTH COLORS
//=============================================================================

final class _HealthColors {
  const _HealthColors({
    required this.background,
    required this.foreground,
    required this.icon,
  });

  final Color background;
  final Color foreground;
  final IconData icon;
}