/*
==============================================================================
FILE: dashboard_navigation.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Dashboard Navigation
==============================================================================

DESCRIPTION
-----------
Provides the responsive top navigation used on tablet and smaller layouts.

RESPONSIBILITIES
----------------
• Display the primary student navigation.
• Display the active navigation state.
• Notify the parent when a navigation item is selected.

IMPORTANT
---------
This is the tablet/mobile counterpart of DashboardSidebar.

The desktop sidebar remains unchanged.

Profile, Upgrade Plan, Help Center, and Logout are intentionally excluded
from this navigation. Those actions will be provided through the profile
menu in the tablet header.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

//=============================================================================
// DASHBOARD NAVIGATION
//=============================================================================

final class DashboardNavigation extends StatelessWidget {
  const DashboardNavigation({
    required this.activeIndex, required this.onItemSelected, super.key,
  });

  final int activeIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: AppColors.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            _buildNavigationItem(
              index: 0,
              icon: Icons.dashboard_outlined,
              title: 'Dashboard',
            ),
            _buildNavigationItem(
              index: 1,
              icon: Icons.school_outlined,
              title: 'My Courses',
            ),
            _buildNavigationItem(
              index: 2,
              icon: Icons.smart_toy_outlined,
              title: 'AI Tutor',
            ),
            _buildNavigationItem(
              index: 3,
              icon: Icons.menu_book_outlined,
              title: 'Materials',
            ),
            _buildNavigationItem(
              index: 4,
              icon: Icons.account_balance_outlined,
              title: 'Institution Portal',
            ),
          ],
        ),
      ),
    );
  }

  //===========================================================================
  // NAVIGATION ITEM
  //===========================================================================

  Widget _buildNavigationItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final bool isActive = activeIndex == index;

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xs,
      ),
      child: InkWell(
        onTap: () => onItemSelected(index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.secondary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive
                    ? AppColors.onSecondary
                    : AppColors.onSurfaceVariant,
                size: 19,
              ),
              const SizedBox(
                width: AppSpacing.xs,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? AppColors.onSecondary
                      : AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}