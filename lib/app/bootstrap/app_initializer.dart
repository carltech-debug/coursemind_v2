/*
==============================================================================
FILE: app_initializer.dart
MODULE: Application Bootstrap
COMPONENT: Application Initializer
==============================================================================
*/

import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import 'app_startup_result.dart';

//=============================================================================
// APPLICATION INITIALIZER
//=============================================================================

final class AppInitializer {
  /// Executes application-wide initialization.
  Future<AppStartupResult> initialize() async {
    try {
      // ===============================================================
      // STEP 1
      // Initialize Firebase
      // ===============================================================

      await Firebase.initializeApp(
        options:
            DefaultFirebaseOptions.currentPlatform,
      );

      // ===============================================================
      // STEP 2
      // Initialize Local Storage
      // ===============================================================

      // Implemented in upcoming phase.

      // ===============================================================
      // STEP 3
      // Prepare Application
      // ===============================================================

      return const AppStartupResult.success();
    } catch (exception) {
      return AppStartupResult.failure(
        exception.toString(),
      );
    }
  }
}