/*
==============================================================================
FILE: auth_provider.dart
MODULE: Authentication
COMPONENT: Authentication Provider
==============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_state.dart';

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  void setLoading() {
    state = const AuthState(
      status: AuthStatus.loading,
    );
  }

  void setAuthenticated() {
    state = const AuthState(
      status: AuthStatus.authenticated,
    );
  }

  void setUnauthenticated() {
    state = const AuthState(
      status: AuthStatus.unauthenticated,
    );
  }

  void setError(String message) {
    state = AuthState(
      status: AuthStatus.error,
      errorMessage: message,
    );
  }
}