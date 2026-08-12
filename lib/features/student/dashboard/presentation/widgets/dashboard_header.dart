/*
==============================================================================
FILE: dashboard_header.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Dashboard Header
==============================================================================

DESCRIPTION
-----------
Provides the top header area of the Student Dashboard.

RESPONSIBILITIES
----------------
• Display the course/material search field.
• Display notification action.
• Display settings action.
• Display the student's profile/avatar area.

NOTES
-----
Actions are UI placeholders at this stage.
Search, notifications, settings, and profile functionality will be
implemented in later development phases.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

//=============================================================================
// DASHBOARD HEADER
//=============================================================================

final class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          // ===================================================================
          // SEARCH
          // ===================================================================

          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: AppSpacing.borderRadiusRound,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search courses, materials...',
                  hintStyle: AppTextStyles.bodyMedium,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),

          // ===================================================================
          // NOTIFICATIONS
          // ===================================================================

          IconButton(
            onPressed: () {},
            tooltip: 'Notifications',
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: AppColors.onSurface,
            ),
          ),

          const SizedBox(
            width: AppSpacing.xs,
          ),

          // ===================================================================
          // SETTINGS
          // ===================================================================

          IconButton(
            onPressed: () {},
            tooltip: 'Settings',
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.onSurface,
            ),
          ),

          const SizedBox(
            width: AppSpacing.sm,
          ),

          // ===================================================================
          // PROFILE
          // ===================================================================

          GestureDetector(
            onTap: () {},
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceContainerHigh,
              ),
              child: const Icon(
                Icons.person_outline,
                color: AppColors.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}