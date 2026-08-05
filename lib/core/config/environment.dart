/*
==============================================================================
FILE: environment.dart
MODULE: Core Configuration
COMPONENT: Environment Configuration
==============================================================================

DESCRIPTION
-----------
Defines the application's runtime environment.

PURPOSE
-------
Provides a centralized way to determine whether the application is
running in Development, Staging, or Production.

RESPONSIBILITIES
----------------
• Define supported environments.
• Expose the active environment.
• Support environment-specific configuration.
• Improve deployment flexibility.

FUTURE IMPLEMENTATION
---------------------
This file will be expanded to support environment variables and
feature flags as the application grows.

DEPENDENCIES
------------
None

NOTES
-----
All environment-dependent logic should reference this file.

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
/// Defines the environments supported by CourseMind.
enum AppEnvironment {
  development,
  staging,
  production,
}
/// Holds the active application environment.
class Environment {
  const Environment._();

  static const AppEnvironment current = AppEnvironment.development;

  static bool get isDevelopment =>
      current == AppEnvironment.development;

  static bool get isStaging =>
      current == AppEnvironment.staging;

  static bool get isProduction =>
      current == AppEnvironment.production;
}