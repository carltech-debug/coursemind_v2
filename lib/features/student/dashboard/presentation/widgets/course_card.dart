/*
==============================================================================
FILE: course_card.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Course Card
==============================================================================

DESCRIPTION
-----------
Displays a recently accessed course and its current completion progress.

The card does not retrieve course data directly.

Future course and learning activity data will be supplied by the
MyCoursesSection/data layer.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

final class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.courseName, required this.courseCode, required this.progress, required this.onPressed, super.key,
  });

  final String courseName;
  final String courseCode;

  /// Completion value from 0.0 to 1.0.
  final double progress;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final double safeProgress = progress.clamp(0.0, 1.0);

    return InkWell(
      onTap: onPressed,
      borderRadius: AppSpacing.borderRadiusLg,
      child: Container(
        width: double.infinity,
        padding: AppSpacing.paddingMd,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(
            color: AppColors.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            // =================================================================
            // COURSE ICON
            // =================================================================

            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: const Icon(
                Icons.menu_book_outlined,
                color: AppColors.primary,
                size: 28,
              ),
            ),

            const SizedBox(
              width: AppSpacing.md,
            ),

            // =================================================================
            // COURSE INFORMATION
            // =================================================================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: AppTextStyles.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(
                    height: AppSpacing.xs,
                  ),

                  Text(
                    courseCode,
                    style: AppTextStyles.bodySmall,
                  ),

                  const SizedBox(
                    height: AppSpacing.sm,
                  ),

                  // ===========================================================
                  // PROGRESS
                  // ===========================================================

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: AppSpacing.borderRadiusRound,
                          child: LinearProgressIndicator(
                            value: safeProgress,
                            minHeight: 6,
                            backgroundColor:
                                AppColors.surfaceContainerHigh,
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              AppColors.secondary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: AppSpacing.sm,
                      ),

                      Text(
                        '${(safeProgress * 100).round()}%',
                        style: AppTextStyles.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),

            // =================================================================
            // CONTINUE
            // =================================================================

            const Icon(
              Icons.chevron_right,
              color: AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}