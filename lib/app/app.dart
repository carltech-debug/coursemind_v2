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
• Configure MaterialApp.
• Apply the global CourseMind theme.
• Prepare routing integration.

NOTES
-----
This widget should remain lightweight.

STATUS
------
Active

AUTHOR
------
CourseMind Development Team

==============================================================================
*/

import 'package:coursemind/app/routing/auth_action_handler.dart';
import 'package:coursemind/app/theme/app_theme.dart';
//import 'package:coursemind/core/ai/dev/ai_material_analysis_test_screen.dart';
import 'package:coursemind/features/public/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

//=============================================================================
// ROOT APPLICATION
//=============================================================================

class CourseMindApp extends StatelessWidget {
  const CourseMindApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CourseMind',

      // Global application theme.
      theme: AppTheme.light,

      home: const AuthActionHandler(
        child: SplashScreen(),
      ),
      //home: const AiMaterialAnalysisTestScreen(),
    );
  }
}