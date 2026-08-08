/*
==============================================================================
FILE: splash_service.dart
MODULE: Splash
COMPONENT: Splash Service
==============================================================================
*/

import '../models/splash_state.dart';

final class SplashService {
  Future<SplashState> initialize() async {
    await Future<void>.delayed(
      const Duration(seconds: 3),
    );

    return const SplashState(
      status: SplashStatus.completed,
      message: 'INITIALIZING LEARNING CORE',
      progress: 1.0,
    );
  }

  Future<void> waitForSplash() async {
    await Future<void>.delayed(
      const Duration(seconds: 3),
    );
  }
}