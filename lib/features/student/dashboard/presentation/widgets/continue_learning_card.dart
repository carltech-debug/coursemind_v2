/*
==============================================================================
FILE: continue_learning_card.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Continue Learning Card
==============================================================================

DESCRIPTION
-----------
Displays the student's current learning activity and provides a visual
entry point for continuing a course.

DATA
----
Course and progress values are temporary presentation data at this stage.

Future versions will receive these values from the course and learning
activity data layers.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

//=============================================================================
// CONTINUE LEARNING CARD
//=============================================================================

final class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          // SECTION HEADER
          // ===================================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Continue Learning',
                style: AppTextStyles.titleLarge,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // ===================================================================
          // COURSE INFORMATION
          // ===================================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Electromagnetic Fields',
                      style: AppTextStyles.titleMedium,
                    ),
                    SizedBox(
                      height: AppSpacing.xs,
                    ),
                    Text(
                      'Chapter 4 • Maxwell’s Equations',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // ===================================================================
          // PROGRESS
          // ===================================================================

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Course progress',
                style: AppTextStyles.bodySmall,
              ),
              Text(
                '74%',
                style: AppTextStyles.labelLarge,
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          ClipRRect(
            borderRadius: AppSpacing.borderRadiusRound,
            child: const LinearProgressIndicator(
              value: 0.74,
              minHeight: 8,
              backgroundColor: AppColors.surfaceContainerHigh,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.secondary,
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // ===================================================================
          // CONTINUE ACTION
          // ===================================================================

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow,
              ),
              label: const Text(
                'Continue Learning',
              ),
            ),
          ),
        ],
      ),
    );
  }
}