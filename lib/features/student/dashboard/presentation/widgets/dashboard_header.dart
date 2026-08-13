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
Responsive header for the Student Dashboard.

RESPONSIVE BEHAVIOR
-------------------
Desktop:
    Search + notification + settings + profile.

Tablet / smaller layouts:
    CourseMind branding on the left.
    Centered search field.
    Notifications, settings, and profile on the right.

The tablet header uses fixed compact regions for the branding and actions,
while the search field receives the remaining available width.

This prevents the header controls from overflowing against the browser
boundary at smaller tablet widths.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

//=============================================================================
// BREAKPOINT
//=============================================================================

const double _tabletHeaderBreakpoint = 1100;

//=============================================================================
// DASHBOARD HEADER
//=============================================================================

final class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet =
            constraints.maxWidth < _tabletHeaderBreakpoint;

        if (isTablet) {
          return _buildTabletHeader(context);
        }

        return _buildDesktopHeader(context);
      },
    );
  }

  //===========================================================================
  // DESKTOP HEADER
  //===========================================================================

  Widget _buildDesktopHeader(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          _buildSearchField(
            maxWidth: 420,
          ),

          const Spacer(),

          _buildNotificationButton(),

          const SizedBox(
            width: AppSpacing.xs,
          ),

          _buildSettingsButton(),

          const SizedBox(
            width: AppSpacing.sm,
          ),

          _buildProfileButton(),
        ],
      ),
    );
  }

  //===========================================================================
  // TABLET HEADER
  //===========================================================================

  Widget _buildTabletHeader(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          //===================================================================
          // LEFT — COURSEMIND
          //===================================================================

          SizedBox(
            width: 105,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildCourseMindBrand(),
            ),
          ),

          //===================================================================
          // CENTER — SEARCH
          //===================================================================

          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 150,
                  maxWidth: 240,
                ),
                child: _buildSearchField(
                  maxWidth: double.infinity,
                ),
              ),
            ),
          ),

          //===================================================================
          // RIGHT — ACTIONS
          //===================================================================

          SizedBox(
            width: 108,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCompactHeaderButton(
                  icon: Icons.notifications_none_outlined,
                  tooltip: 'Notifications',
                  onPressed: _openNotifications,
                ),

                _buildCompactHeaderButton(
                  icon: Icons.settings_outlined,
                  tooltip: 'Settings',
                  onPressed: _openSettings,
                ),

                _buildCompactProfileButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // COURSEMIND BRAND
  //===========================================================================

  Widget _buildCourseMindBrand() {
    return const Text(
      'CourseMind',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.primary,
      ),
    );
  }

  //===========================================================================
  // SEARCH
  //===========================================================================

  Widget _buildSearchField({
    required double maxWidth,
  }) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: AppSpacing.borderRadiusRound,
      ),
      child: const TextField(
        maxLines: 1,
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
    );
  }

  //===========================================================================
  // DESKTOP NOTIFICATIONS
  //===========================================================================

  Widget _buildNotificationButton() {
    return const IconButton(
      onPressed: _openNotifications,
      tooltip: 'Notifications',
      icon: Icon(
        Icons.notifications_none_outlined,
        color: AppColors.onSurface,
      ),
    );
  }

  //===========================================================================
  // TABLET COMPACT BUTTON
  //===========================================================================

  Widget _buildCompactHeaderButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 32,
      height: 40,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 40,
        ),
        icon: Icon(
          icon,
          color: AppColors.onSurface,
          size: 20,
        ),
      ),
    );
  }

  //===========================================================================
  // DESKTOP SETTINGS
  //===========================================================================

  Widget _buildSettingsButton() {
    return const IconButton(
      onPressed: _openSettings,
      tooltip: 'Settings',
      icon: Icon(
        Icons.settings_outlined,
        color: AppColors.onSurface,
      ),
    );
  }

  //===========================================================================
  // DESKTOP PROFILE
  //===========================================================================

  Widget _buildProfileButton() {
    return PopupMenuButton<_ProfileMenuAction>(
      tooltip: 'Profile',
      onSelected: _handleProfileAction,
      offset: const Offset(
        0,
        46,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) => const [
        PopupMenuItem<_ProfileMenuAction>(
          value: _ProfileMenuAction.profile,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.person_outline,
            ),
            title: Text('Profile'),
          ),
        ),
        PopupMenuItem<_ProfileMenuAction>(
          value: _ProfileMenuAction.upgrade,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.workspace_premium_outlined,
            ),
            title: Text('Upgrade Plan'),
          ),
        ),
        PopupMenuItem<_ProfileMenuAction>(
          value: _ProfileMenuAction.help,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.help_outline,
            ),
            title: Text('Help Center'),
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem<_ProfileMenuAction>(
          value: _ProfileMenuAction.logout,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.logout,
            ),
            title: Text('Logout'),
          ),
        ),
      ],
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
    );
  }

  //===========================================================================
  // TABLET PROFILE
  //===========================================================================

  Widget _buildCompactProfileButton() {
    return SizedBox(
      width: 36,
      height: 40,
      child: PopupMenuButton<_ProfileMenuAction>(
        tooltip: 'Profile',
        onSelected: _handleProfileAction,
        padding: EdgeInsets.zero,
        offset: const Offset(
          0,
          44,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        itemBuilder: (context) => const [
          PopupMenuItem<_ProfileMenuAction>(
            value: _ProfileMenuAction.profile,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.person_outline,
              ),
              title: Text('Profile'),
            ),
          ),
          PopupMenuItem<_ProfileMenuAction>(
            value: _ProfileMenuAction.upgrade,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.workspace_premium_outlined,
              ),
              title: Text('Upgrade Plan'),
            ),
          ),
          PopupMenuItem<_ProfileMenuAction>(
            value: _ProfileMenuAction.help,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.help_outline,
              ),
              title: Text('Help Center'),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<_ProfileMenuAction>(
            value: _ProfileMenuAction.logout,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.logout,
              ),
              title: Text('Logout'),
            ),
          ),
        ],
        child: Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceContainerHigh,
          ),
          child: const Icon(
            Icons.person_outline,
            color: AppColors.onSurfaceVariant,
            size: 18,
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // ACTION HANDLERS
  //===========================================================================

  static void _openNotifications() {
    // Notification functionality will be implemented later.
  }

  static void _openSettings() {
    // Settings functionality will be implemented later.
  }

  static void _handleProfileAction(
    _ProfileMenuAction action,
  ) {
    switch (action) {
      case _ProfileMenuAction.profile:
        // Profile navigation will be connected later.
        break;

      case _ProfileMenuAction.upgrade:
        // Upgrade functionality will be implemented later.
        break;

      case _ProfileMenuAction.help:
        // Help Center functionality will be implemented later.
        break;

      case _ProfileMenuAction.logout:
        // Logout will be connected to Firebase Authentication later.
        break;
    }
  }
}

//=============================================================================
// PROFILE MENU ACTION
//=============================================================================

enum _ProfileMenuAction {
  profile,
  upgrade,
  help,
  logout,
}