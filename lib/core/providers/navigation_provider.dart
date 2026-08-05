/*
==============================================================================
FILE: navigation_provider.dart
MODULE: Core Providers
COMPONENT: Navigation Provider
==============================================================================

DESCRIPTION
-----------
Provides application-wide navigation state.

PURPOSE
-------
Maintains shared navigation information across the application.

RESPONSIBILITIES
----------------
• Track active navigation state.
• Manage selected navigation items.
• Support future navigation history.

FUTURE IMPLEMENTATION
---------------------
This provider will synchronize navigation state with GoRouter.

DEPENDENCIES
------------
flutter_riverpod

NOTES
-----
Navigation logic remains inside the Router module.

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
// NAVIGATION PROVIDER
//=============================================================================

/// Global navigation provider.
///
/// Navigation state implementation will be completed
/// alongside the routing system.
final navigationProvider = Provider<void>(
  (ref) {},
);