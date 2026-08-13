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
Displays a recently accessed course using the Stitch dashboard visual design.

RESPONSIBILITIES
----------------
• Display the course image.
• Display course code and name.
• Display completion progress.
• Open the course when selected.

The component remains presentation-only. Course data is supplied by the
parent/data layer.
==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

final class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.courseName,
    required this.courseCode,
    required this.progress,
    required this.imageAsset,
    required this.onPressed,
    super.key,
  });

  final String courseName;
  final String courseCode;

  /// Completion value from 0.0 to 1.0.
  final double progress;

  /// Local dashboard image asset.
  final String imageAsset;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final double safeProgress = progress.clamp(0.0, 1.0);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppSpacing.borderRadiusLg,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: AppSpacing.borderRadiusLg,
            border: Border.all(
              color: AppColors.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================================================================
              // COURSE IMAGE
              //================================================================

              AspectRatio(
                aspectRatio: 1.65,
                child: Image.asset(
                  imageAsset,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      color: AppColors.primaryContainer,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.menu_book_outlined,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),

              //================================================================
              // COURSE INFORMATION
              //================================================================

              Padding(
                padding: AppSpacing.paddingMd,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseCode,
                      style: AppTextStyles.labelSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(
                      height: AppSpacing.xs,
                    ),

                    Text(
                      courseName,
                      style: AppTextStyles.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    //==========================================================
                    // PROGRESS
                    //==========================================================

                    ClipRRect(
                      borderRadius: AppSpacing.borderRadiusRound,
                      child: LinearProgressIndicator(
                        value: safeProgress,
                        minHeight: 5,
                        backgroundColor:
                            AppColors.surfaceContainerHigh,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                          AppColors.secondary,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.xs,
                    ),

                    Text(
                      '${(safeProgress * 100).round()}% Completed',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}