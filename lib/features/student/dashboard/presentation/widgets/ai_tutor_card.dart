/*
==============================================================================
FILE: ai_tutor_card.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: AI Tutor Card
==============================================================================

DESCRIPTION
-----------
Displays the AI Study Tutor entry point on the Student Dashboard.

RESPONSIBILITY
--------------
• Present the AI Study Tutor card.
• Provide a visual entry point into the AI Tutor platform.

IMPORTANT
---------
The AI Tutor platform itself is implemented separately.

This component contains no AI logic, API calls, chat functionality,
course analysis, or AI usage tracking.
==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

//=============================================================================
// AI TUTOR CARD
//=============================================================================

final class AiTutorCard extends StatelessWidget {
  const AiTutorCard({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

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
          //===================================================================
          // HEADER
          //===================================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.secondary,
                  size: 24,
                ),
              ),

              const Spacer(),

              IconButton(
                onPressed: onPressed,
                tooltip: 'Open AI Tutor',
                icon: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.onSurfaceVariant,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          //===================================================================
          // TITLE
          //===================================================================

          const Text(
            'AI Study Tutor',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),

          const SizedBox(
            height: AppSpacing.xs,
          ),

          //===================================================================
          // DESCRIPTION
          //===================================================================

          const Text(
            'Get personalized help with your courses and study smarter.',
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: AppColors.onSurfaceVariant,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          //===================================================================
          // SUGGESTED QUESTION
          //===================================================================

          Container(
            width: double.infinity,
            padding: AppSpacing.paddingMd,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 18,
                  color: AppColors.onSurfaceVariant,
                ),

                SizedBox(
                  width: AppSpacing.sm,
                ),

                Expanded(
                  child: Text(
                    'Ask your AI Tutor anything...',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(
                  width: AppSpacing.sm,
                ),

                Icon(
                  Icons.arrow_forward,
                  size: 17,
                  color: AppColors.onSurfaceVariant,
                ),
              ],
            ),
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          //===================================================================
          // START SESSION
          //===================================================================

          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 40),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Start a new session',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: AppSpacing.xs,
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}