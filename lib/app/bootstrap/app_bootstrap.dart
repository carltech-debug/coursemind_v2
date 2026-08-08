/*
==============================================================================
FILE: app_bootstrap.dart
MODULE: Application Bootstrap
COMPONENT: Application Bootstrap Coordinator
==============================================================================

DESCRIPTION
-----------
Coordinates the application's startup sequence.

PURPOSE
-------
Acts as the entry point for bootstrapping CourseMind before the user
interacts with the application.

RESPONSIBILITIES
----------------
• Coordinate application startup.
• Execute application initialization.
• Return startup results.
• Prevent duplicate initialization.

FUTURE IMPLEMENTATION
---------------------
Additional startup tasks may include:
• Remote Config
• App Check
• Version Validation
• Feature Flags

DEPENDENCIES
------------
app_initializer.dart
app_startup_result.dart

NOTES
-----
This class should remain lightweight and delegate initialization
responsibilities to AppInitializer.

STATUS
------
✅ Production Ready

AUTHOR
------
CourseMind Development Team

LAST UPDATED
------------
Phase 2 – Public Module

==============================================================================
*/

import 'app_initializer.dart';
import 'app_startup_result.dart';

//=============================================================================
// APPLICATION BOOTSTRAP
//=============================================================================

/// Coordinates application startup.
final class AppBootstrap {
  const AppBootstrap._();

  /// Starts the application.
  static Future<AppStartupResult> bootstrap() async {
    final AppInitializer initializer = AppInitializer();

    return initializer.initialize();
  }
}