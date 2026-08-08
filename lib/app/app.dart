/*
==============================================================================
FILE: app.dart
MODULE: Application
COMPONENT: Root Application Widget
==============================================================================

DESCRIPTION
-----------
Defines the root widget of the CourseMind application.

PURPOSE
-------
Provides the application's root widget and prepares the widget tree
for routing, theming, and global state management.

RESPONSIBILITIES
----------------
• Create the root application widget.
• Wrap the application with Riverpod.
• Configure MaterialApp.
• Prepare routing integration.

FUTURE IMPLEMENTATION
---------------------
Future versions will integrate:

• GoRouter
• Themes
• Localization
• Authentication redirects

DEPENDENCIES
------------
flutter
flutter_riverpod

NOTES
-----
This widget should remain lightweight.

STATUS
------
🚧 Initial Implementation

AUTHOR
------
CourseMind Development Team

LAST UPDATED
------------
Phase 2 – Public Module

==============================================================================
*/
import 'package:coursemind/features/public/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
//=============================================================================
// ROOT APPLICATION
//=============================================================================

//=============================================================================
// ROOT APPLICATION
//=============================================================================

class CourseMindApp extends StatelessWidget {
  const CourseMindApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CourseMind',
      home: SplashScreen(),
    );
  }
}