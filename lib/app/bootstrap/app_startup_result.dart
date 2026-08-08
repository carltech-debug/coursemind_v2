/*
==============================================================================
FILE: app_startup_result.dart
MODULE: Application Bootstrap
COMPONENT: Application Startup Result
==============================================================================

DESCRIPTION
-----------
Represents the outcome of the application startup process.

PURPOSE
-------
Provides a standardized result returned by the bootstrap process,
allowing the application to determine whether startup completed
successfully or failed.

RESPONSIBILITIES
----------------
• Represent successful startup.
• Represent failed startup.
• Store startup error messages.
• Provide startup status.

FUTURE IMPLEMENTATION
---------------------
Additional startup metadata may include:
• Startup duration
• Initialized services
• Version information
• Environment information

DEPENDENCIES
------------
None

NOTES
-----
This model should remain immutable.

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

//=============================================================================
// APPLICATION STARTUP RESULT
//=============================================================================

/// Represents the outcome of the application startup process.
final class AppStartupResult {

  /// Failed startup.
  const AppStartupResult.failure(
    this.message,
  ) : success = false;

  //===========================================================================
  // FACTORY CONSTRUCTORS
  //===========================================================================

  /// Successful startup.
  const AppStartupResult.success()
      : success = true,
        message = null;
  /// Creates a startup result.
  const AppStartupResult({
    required this.success,
    this.message,
  });

  /// Indicates whether startup completed successfully.
  final bool success;

  /// Optional startup message.
  final String? message;
}