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
Compares the student's actual academic completion progress against the
expected progress for the current point in the semester.

RESPONSIBILITIES
----------------
• Display expected semester progress.
• Display actual student completion progress.
• Calculate the difference between expected and actual progress.
• Determine whether the student is ahead, on track, or behind.
• Present the comparison clearly to the student.

DATA SOURCES
------------
Expected progress:
    Institution academic calendar / semester dates.

Actual progress:
    Student learning and course completion data.

IMPORTANT
---------
This widget does not retrieve data from Firestore.

The parent/data layer supplies the expected and actual progress values.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

//=============================================================================
// ACADEMIC HEALTH CARD
//=============================================================================

final class AcademicHealthCard extends StatelessWidget {
  const AcademicHealthCard({
    required this.expectedProgress, required this.actualProgress, required this.currentMonth, required this.totalMonths, super.key,
  });

  /// Expected academic completion from 0.0 to 1.0.
  final double expectedProgress;

  /// Student's actual completion from 0.0 to 1.0.
  final double actualProgress;

  /// Current month within the academic period.
  final int currentMonth;

  /// Total number of months in the academic period.
  final int totalMonths;

  @override
  Widget build(BuildContext context) {
    final double safeExpectedProgress =
        expectedProgress.clamp(0.0, 1.0);

    final double safeActualProgress =
        actualProgress.clamp(0.0, 1.0);

    final double progressDifference =
        safeActualProgress - safeExpectedProgress;

    final _AcademicStatus status =
        _getAcademicStatus(progressDifference);

    final int expectedPercentage =
        (safeExpectedProgress * 100).round();

    final int actualPercentage =
        (safeActualProgress * 100).round();

    final int differencePercentage =
        (progressDifference.abs() * 100).round();

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
          // ===================================================================
          // HEADER
          // ===================================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Academic Health',
                style: AppTextStyles.titleLarge,
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: _statusBackgroundColor(status),
                  borderRadius: AppSpacing.borderRadiusRound,
                ),
                child: Text(
                  _statusLabel(status),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _statusTextColor(status),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Text(
            'Month $currentMonth of $totalMonths',
            style: AppTextStyles.bodySmall,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // ===================================================================
          // PROGRESS COMPARISON
          // ===================================================================

          Row(
            children: [
              Expanded(
                child: _ProgressColumn(
                  label: 'Expected',
                  percentage: expectedPercentage,
                  progress: safeExpectedProgress,
                ),
              ),

              const SizedBox(
                width: AppSpacing.lg,
              ),

              Expanded(
                child: _ProgressColumn(
                  label: 'Your Progress',
                  percentage: actualPercentage,
                  progress: safeActualProgress,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // ===================================================================
          // COMPARISON MESSAGE
          // ===================================================================

          Container(
            width: double.infinity,
            padding: AppSpacing.paddingMd,
            decoration: BoxDecoration(
              color: _statusBackgroundColor(status),
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _statusIcon(status),
                  color: _statusTextColor(status),
                  size: 20,
                ),

                const SizedBox(
                  width: AppSpacing.sm,
                ),

                Expanded(
                  child: Text(
                    _comparisonMessage(
                      status,
                      differencePercentage,
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      color: _statusTextColor(status),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // STATUS
  //===========================================================================

  _AcademicStatus _getAcademicStatus(
    double difference,
  ) {
    const double tolerance = 0.03;

    if (difference > tolerance) {
      return _AcademicStatus.ahead;
    }

    if (difference < -tolerance) {
      return _AcademicStatus.behind;
    }

    return _AcademicStatus.onTrack;
  }

  String _statusLabel(
    _AcademicStatus status,
  ) {
    switch (status) {
      case _AcademicStatus.ahead:
        return 'Ahead';

      case _AcademicStatus.onTrack:
        return 'On Track';

      case _AcademicStatus.behind:
        return 'Behind';
    }
  }

  IconData _statusIcon(
    _AcademicStatus status,
  ) {
    switch (status) {
      case _AcademicStatus.ahead:
        return Icons.trending_up;

      case _AcademicStatus.onTrack:
        return Icons.check_circle_outline;

      case _AcademicStatus.behind:
        return Icons.trending_down;
    }
  }

  Color _statusBackgroundColor(
    _AcademicStatus status,
  ) {
    switch (status) {
      case _AcademicStatus.ahead:
        return AppColors.primaryContainer;

      case _AcademicStatus.onTrack:
        return AppColors.secondaryContainer;

      case _AcademicStatus.behind:
        return AppColors.error;
    }
  }

  Color _statusTextColor(
    _AcademicStatus status,
  ) {
    switch (status) {
      case _AcademicStatus.ahead:
        return AppColors.primary;

      case _AcademicStatus.onTrack:
        return AppColors.onSecondaryContainer;

      case _AcademicStatus.behind:
        return AppColors.error;
    }
  }

  String _comparisonMessage(
    _AcademicStatus status,
    int difference,
  ) {
    switch (status) {
      case _AcademicStatus.ahead:
        return 'You are $difference% ahead of the expected academic progress.';

      case _AcademicStatus.onTrack:
        return 'You are currently on track with the expected academic progress.';

      case _AcademicStatus.behind:
        return 'You are $difference% behind the expected academic progress.';
    }
  }
}

//=============================================================================
// PROGRESS COLUMN
//=============================================================================

final class _ProgressColumn extends StatelessWidget {
  const _ProgressColumn({
    required this.label,
    required this.percentage,
    required this.progress,
  });

  final String label;
  final int percentage;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall,
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        Text(
          '$percentage%',
          style: AppTextStyles.headlineSmall,
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        ClipRRect(
          borderRadius: AppSpacing.borderRadiusRound,
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: AppColors.surfaceContainerHigh,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}

//=============================================================================
// ACADEMIC STATUS
//=============================================================================

enum _AcademicStatus {
  ahead,
  onTrack,
  behind,
}