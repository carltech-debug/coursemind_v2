/*
==============================================================================
FILE: auth_provider.dart
MODULE: Core Providers
COMPONENT: Authentication Provider
==============================================================================

DESCRIPTION
-----------
Provides application-wide authentication state.

PURPOSE
-------
Acts as the central provider for authentication-related state and
dependencies used throughout the CourseMind application.

RESPONSIBILITIES
----------------
• Expose authentication state.
• Provide authenticated user information.
• Support login and logout state.
• Support email verification.
• Support role-based authentication.

FUTURE IMPLEMENTATION
---------------------
This provider will integrate with Firebase Authentication and expose
the authenticated user state to the entire application.

DEPENDENCIES
------------
flutter_riverpod

NOTES
-----
Feature-specific authentication logic should remain inside the
Authentication feature.

STATUS
------
🚧 Placeholder

AUTHOR
------
CourseMind Development Team

LAST UPDATED
------------
Phase 1 – Project Foundation

==============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

//=============================================================================
// AUTHENTICATION PROVIDER
//=============================================================================

/// Global authentication provider.
///
/// Firebase Authentication integration will be implemented
/// during the Authentication feature.
final authProvider = Provider<void>(
  (ref) {},
);