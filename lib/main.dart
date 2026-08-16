/*
==============================================================================
FILE: main.dart
MODULE: Application Entry Point
COMPONENT: Main Entry Point
==============================================================================

DESCRIPTION
-----------
Application entry point for CourseMind.

PURPOSE
-------
Initializes Flutter, executes the application bootstrap process,
and launches the root CourseMind application.

RESPONSIBILITIES
----------------
• Initialize Flutter.
• Execute application bootstrap.
• Launch the application.

DEPENDENCIES
------------
flutter
app.dart
app_bootstrap.dart

NOTES
-----
Business logic should never exist in this file.

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

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap/app_bootstrap.dart';

//=============================================================================
// APPLICATION ENTRY POINT
//=============================================================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrap.bootstrap();

  await FirebaseAppCheck.instance.activate(
    providerWeb: ReCaptchaV3Provider(
      '6Le5_4UtAAAAAEidwkb1GlMf0Ar2kUqnpMwk8jb3',
    ),
  );

  runApp(
    const ProviderScope(
      child: CourseMindApp(),
    ),
  );
}