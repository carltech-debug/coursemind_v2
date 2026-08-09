/*
==============================================================================
FILE: auth_state.dart
MODULE: Authentication
COMPONENT: Authentication State
==============================================================================
*/

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  passwordResetSent,
  error,
}

final class AuthState {
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  final AuthStatus status;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}