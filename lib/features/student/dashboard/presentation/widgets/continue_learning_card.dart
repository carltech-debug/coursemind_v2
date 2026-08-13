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
Displays the student's current learning activity using the CourseMind
dashboard visual design.

RESPONSIBILITIES
----------------
• Show the course currently being studied.
• Show the student's current learning section.
• Show course progress.
• Provide the Continue Learning action.

CURRENT PHASE
-------------
Presentation implementation.

The course and progress values are temporary presentation values.
The final implementation will receive them from the student's learning
activity/data layer.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

//=============================================================================
// CONTINUE LEARNING CARD
//=============================================================================

final class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppSpacing.borderRadiusXl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //===================================================================
          // CURRENTLY STUDYING LABEL
          //===================================================================

          Text(
            'CURRENTLY STUDYING',
            style: TextStyle(
              color: AppColors.onPrimary.withValues(
                alpha: 0.72,
              ),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          //===================================================================
          // COURSE
          //===================================================================

          const Text(
            'Electromagnetic Fields',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          //===================================================================
          // CURRENT SECTION
          //===================================================================

          Text(
            'Chapter 4 • Maxwell’s Equations',
            style: TextStyle(
              color: AppColors.onPrimary.withValues(
                alpha: 0.78,
              ),
              fontSize: 14,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          //===================================================================
          // PROGRESS HEADER
          //===================================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Course Progress',
                style: TextStyle(
                  color: AppColors.onPrimary.withValues(
                    alpha: 0.78,
                  ),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                '74%',
                style: TextStyle(
                  color: AppColors.onPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          //===================================================================
          // PROGRESS BAR
          //===================================================================

          ClipRRect(
            borderRadius: AppSpacing.borderRadiusRound,
            child: const LinearProgressIndicator(
              value: 0.74,
              minHeight: 7,
              backgroundColor: AppColors.primaryContainer,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.onPrimary,
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          //===================================================================
          // RESUME ACTION
          //===================================================================

          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.play_arrow,
                size: 18,
              ),
              label: const Text(
                'Continue Learning',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.onPrimary,
                foregroundColor: AppColors.primary,
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}