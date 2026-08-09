/*
==============================================================================
FILE: auth_provider.dart
MODULE: Authentication
COMPONENT: Authentication Provider
==============================================================================
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_state.dart';

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final class AuthNotifier extends Notifier<AuthState> {
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance;

  @override
  AuthState build() {
    return const AuthState();
  }

  //===========================================================================
  // EMAIL / PASSWORD SIGN-UP
  //===========================================================================

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AuthState(
      status: AuthStatus.loading,
    );

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      state = const AuthState(
        status: AuthStatus.authenticated,
      );
    } on FirebaseAuthException catch (exception) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: _getAuthErrorMessage(exception),
      );
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage:
            'Something went wrong. Please try again.',
      );
    }
  }

  //===========================================================================
  // EMAIL / PASSWORD LOGIN
  //===========================================================================

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState(
      status: AuthStatus.loading,
    );

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      state = const AuthState(
        status: AuthStatus.authenticated,
      );
    } on FirebaseAuthException catch (exception) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: _getAuthErrorMessage(exception),
      );
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage:
            'Something went wrong. Please try again.',
      );
    }
  }

  //===========================================================================
  // AUTHENTICATION ERROR MESSAGES
  //===========================================================================

  String _getAuthErrorMessage(
    FirebaseAuthException exception,
  ) {
    switch (exception.code) {
      case 'email-already-in-use':
        return 'An account already exists with this email address.';

      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'weak-password':
        return 'The password is too weak.';

      case 'user-not-found':
        return 'No account was found with this email address.';

      case 'wrong-password':
        return 'The password is incorrect.';

      case 'invalid-credential':
        return 'The email or password is incorrect.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'operation-not-allowed':
        return 'Email and password authentication is not enabled.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      default:
        return 'Authentication failed. Please try again.';
    }
  }
}