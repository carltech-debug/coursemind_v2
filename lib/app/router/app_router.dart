/*
==============================================================================
FILE: app_router.dart
MODULE: App Router
COMPONENT: Application Router
==============================================================================

DESCRIPTION
-----------
Provides the application's central navigation configuration using
GoRouter.

PURPOSE
-------
Acts as the single entry point for navigation throughout the
CourseMind application.

RESPONSIBILITIES
----------------
• Configure the application's GoRouter instance.
• Register route definitions.
• Register navigation guards.
• Define the application's initial route.
• Handle unknown routes.

FUTURE IMPLEMENTATION
---------------------
This file will initialize GoRouter using the application's route
definitions and authentication guards.

DEPENDENCIES
------------
go_router

NOTES
-----
All navigation within the application should be configured here.

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

import 'package:go_router/go_router.dart';

//=============================================================================
// APPLICATION ROUTER
//=============================================================================

/// Global GoRouter configuration.
///
/// Implementation will be completed during the Public Module
/// development phase.
GoRouter createAppRouter() {
  throw UnimplementedError(
    'App router has not been implemented yet.',
  );
}