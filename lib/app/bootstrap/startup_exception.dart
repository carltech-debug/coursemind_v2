/*
==============================================================================
FILE: startup_exception.dart
MODULE: Application Bootstrap
COMPONENT: Startup Exception
==============================================================================

DESCRIPTION
-----------
Defines exceptions that occur during application startup.

PURPOSE
-------
Provides a dedicated exception type for bootstrap-related failures.

RESPONSIBILITIES
----------------
• Represent startup failures.
• Improve startup error reporting.
• Separate bootstrap exceptions from application exceptions.

FUTURE IMPLEMENTATION
---------------------
Future versions may include:
• Error codes
• Failure categories
• Recovery suggestions

DEPENDENCIES
------------
None

NOTES
-----
Only bootstrap-related exceptions should use this class.

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
// STARTUP EXCEPTION
//=============================================================================

/// Exception thrown during application startup.
final class StartupException implements Exception {
  /// Creates a startup exception.
  const StartupException(this.message);

  /// Exception message.
  final String message;

  @override
  String toString() => 'StartupException: $message';
}