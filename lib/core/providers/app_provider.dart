/*
==============================================================================
FILE: app_provider.dart
MODULE: Core Providers
COMPONENT: Application Provider
==============================================================================

DESCRIPTION
-----------
Provides application-wide state and dependencies shared across
multiple features.

PURPOSE
-------
Acts as the root provider for global application state.

RESPONSIBILITIES
----------------
• Expose application configuration.
• Provide shared dependencies.
• Support application initialization.
• Enable dependency injection.

FUTURE IMPLEMENTATION
---------------------
Additional providers will compose this provider as the
application grows.

DEPENDENCIES
------------
flutter_riverpod

NOTES
-----
This provider should remain lightweight and avoid feature-specific logic.

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

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Indicates whether the application has completed initialization.
final appInitializedProvider = Provider<bool>((ref) => false);