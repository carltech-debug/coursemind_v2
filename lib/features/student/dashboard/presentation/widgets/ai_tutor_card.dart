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
• Direct the student to the AI Tutor platform when selected.

NOTES
-----
The AI Tutor platform itself will be implemented separately.

This component contains no AI logic, API calls, chat functionality,
course analysis, or AI usage tracking.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

//=============================================================================
// AI TUTOR CARD
//=============================================================================

final class AiTutorCard extends StatelessWidget {
  const AiTutorCard({
    required this.onPressed, super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        borderRadius: AppSpacing.borderRadiusXl,
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================================
          // ICON
          // ===================================================================

          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: AppSpacing.borderRadiusMd,
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: AppColors.onSecondary,
              size: 24,
            ),
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // ===================================================================
          // TITLE
          // ===================================================================

          const Text(
            'AI Study Tutor',
            style: AppTextStyles.headlineSmall,
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          // ===================================================================
          // DESCRIPTION
          // ===================================================================

          const Text(
            'Get personalized help with your courses and study smarter.',
            style: AppTextStyles.bodyMedium,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          // ===================================================================
          // ACTION
          // ===================================================================

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_forward,
                size: 18,
              ),
              label: const Text(
                'Open AI Tutor',
              ),
            ),
          ),
        ],
      ),
    );
  }
}