/*
==============================================================================
FILE: dashboard_sidebar.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Dashboard Sidebar
==============================================================================

DESCRIPTION
-----------
Provides the fixed navigation sidebar for the Student Dashboard.

RESPONSIBILITIES
----------------
• Display the institution branding.
• Display primary dashboard navigation.
• Track the currently selected navigation item through the parent screen.
• Display Upgrade Plan and footer actions.

NOTES
-----
Navigation actions are UI placeholders at this stage.
Actual navigation functionality will be implemented later.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({
    required this.activeIndex, required this.onItemSelected, super.key,
  });

  final int activeIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          right: BorderSide(
            color: AppColors.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInstitutionBranding(),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Expanded(
            child: ListView(
              children: [
                _buildNavigationItem(
                  index: 0,
                  icon: Icons.dashboard,
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
                  icon: Icons.account_balance_outlined,
                  title: 'Institution Portal',
                ),
                _buildNavigationItem(
                  index: 4,
                  icon: Icons.person_outline,
                  title: 'Profile',
                ),
              ],
            ),
          ),

          _buildFooterActions(),
        ],
      ),
    );
  }

  //===========================================================================
  // INSTITUTION BRANDING
  //===========================================================================

  Widget _buildInstitutionBranding() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.school,
              color: AppColors.onPrimary,
              size: 24,
            ),
          ),

          const SizedBox(
            width: AppSpacing.xs,
          ),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accra Technical',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'ACADEMIC EXCELLENCE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: AppColors.outline,
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
  // PRIMARY NAVIGATION
  //===========================================================================

  Widget _buildNavigationItem({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final bool isActive = activeIndex == index;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.xs,
      ),
      child: InkWell(
        onTap: () => onItemSelected(index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(
            AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.secondary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive
                    ? AppColors.onSecondary
                    : AppColors.onSurfaceVariant,
                size: 20,
              ),

              const SizedBox(
                width: AppSpacing.sm,
              ),

              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
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

  //===========================================================================
  // FOOTER ACTIONS
  //===========================================================================

  Widget _buildFooterActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryContainer,
              foregroundColor: AppColors.onSecondaryContainer,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(
              Icons.bolt,
              size: 18,
            ),
            label: const Text(
              'Upgrade Plan',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        const Divider(
          color: AppColors.outlineVariant,
        ),

        const SizedBox(
          height: AppSpacing.xs,
        ),

        _buildFooterNavigationItem(
          icon: Icons.help_outline,
          title: 'Help Center',
        ),

        _buildFooterNavigationItem(
          icon: Icons.logout,
          title: 'Logout',
        ),
      ],
    );
  }

  Widget _buildFooterNavigationItem({
    required IconData icon,
    required String title,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.onSurfaceVariant,
              size: 20,
            ),

            const SizedBox(
              width: AppSpacing.sm,
            ),

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}