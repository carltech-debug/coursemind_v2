/*
==============================================================================
FILE: dashboard_greeting.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Dashboard Greeting
==============================================================================

DESCRIPTION
-----------
Displays the authenticated student's personal dashboard greeting and
academic identity information.

DATA SOURCE
-----------
Receives UserProfile from the existing ProfileController flow.

The widget does not query Firebase or Firestore directly.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:coursemind/features/student/profile/domain/entities/user_profile.dart';
import 'package:flutter/material.dart';

//=============================================================================
// DASHBOARD GREETING
//=============================================================================

final class DashboardGreeting extends StatelessWidget {
  const DashboardGreeting({
    required this.profile, super.key,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================================================================
        // GREETING
        // =====================================================================

        Text(
          'Good morning, ${profile.fullName} 👋',
          style: AppTextStyles.dashboardGreeting,
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        // =====================================================================
        // INSTITUTION
        // =====================================================================

        Text(
          profile.institutionName,
          style: AppTextStyles.bodyMedium,
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        // =====================================================================
        // PROGRAMME + LEVEL
        // =====================================================================

        Row(
          children: [
            Flexible(
              child: Text(
                profile.programmeName,
                style: AppTextStyles.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),

            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.outline,
                shape: BoxShape.circle,
              ),
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),

            Text(
              profile.academicLevel,
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}