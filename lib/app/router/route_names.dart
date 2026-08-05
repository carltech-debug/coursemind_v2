/*
==============================================================================
FILE: route_names.dart
MODULE: App Router
COMPONENT: Route Definitions
==============================================================================

DESCRIPTION
-----------
Defines every navigation route used throughout the CourseMind
application.

PURPOSE
-------
Provides a centralized source of truth for all route paths,
eliminating hardcoded route strings and improving navigation
consistency.

RESPONSIBILITIES
----------------
• Define all application route paths.
• Prevent hardcoded route strings.
• Improve navigation maintainability.
• Support route refactoring.
• Enable IDE auto-completion.

FUTURE IMPLEMENTATION
---------------------
Additional route paths will be added as new application
features are implemented.

DEPENDENCIES
------------
None

NOTES
-----
Every navigation request in the application should reference
these constants instead of hardcoded strings.

STATUS
------
🚧 Initial Implementation

AUTHOR
------
CourseMind Development Team

LAST UPDATED
------------
Phase 1 – Project Foundation

==============================================================================
*/

/// Defines all route paths used in CourseMind.
abstract final class RouteNames {
  const RouteNames._();

  // ==========================================================================
  // Public Routes
  // ==========================================================================

  static const String splash = '/';

  static const String login = '/login';

  static const String register = '/register';

  static const String profile = '/profile';

  static const String settings = '/settings';

  // ==========================================================================
  // Student Routes
  // ==========================================================================

  static const String studentDashboard =
      '/student/dashboard';

  static const String courses =
      '/student/courses';

  static const String aiTutor =
      '/student/ai-tutor';

  static const String library =
      '/student/library';

  static const String marketplace =
      '/student/marketplace';

  // ==========================================================================
  // Institution Routes
  // ==========================================================================

  static const String institutionDashboard =
      '/institution/dashboard';

  static const String programmes =
      '/institution/programmes';

  static const String institutionSettings =
      '/institution/settings';
}