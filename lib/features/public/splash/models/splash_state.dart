/*
==============================================================================
FILE: splash_state.dart
MODULE: Splash
COMPONENT: Splash State
==============================================================================

DESCRIPTION
-----------
Represents the current state of the splash experience.

==============================================================================
*/

enum SplashStatus {
  loading,
  completed,
}

final class SplashState {

  factory SplashState.initial() {
    return const SplashState(
      status: SplashStatus.loading,
      message: 'INITIALIZING LEARNING CORE',
      progress: 0.0,
    );
  }
  const SplashState({
    required this.status,
    required this.message,
    required this.progress,
  });

  final SplashStatus status;

  final String message;

  final double progress;

  SplashState copyWith({
    SplashStatus? status,
    String? message,
    double? progress,
  }) {
    return SplashState(
      status: status ?? this.status,
      message: message ?? this.message,
      progress: progress ?? this.progress,
    );
  }
}