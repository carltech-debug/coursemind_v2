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

//=============================================================================
// AUTH PROVIDER
//=============================================================================

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

//=============================================================================
// AUTH NOTIFIER
//=============================================================================

final class AuthNotifier extends Notifier<AuthState> {
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance;

  /// Currently authenticated Firebase user.
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  AuthState build() {
    return const AuthState();
  }

  //===========================================================================
  // SIGN UP
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
  // LOGIN
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
  // PASSWORD RESET
  //===========================================================================

  Future<void> resetPassword({
    required String email,
  }) async {
    state = const AuthState(
      status: AuthStatus.loading,
    );

    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email.trim(),
      );

      state = const AuthState(
        status: AuthStatus.passwordResetSent,
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
  // VERIFY PASSWORD RESET CODE
  //===========================================================================

  Future<String?> verifyPasswordResetCode({
    required String code,
  }) async {
    state = const AuthState(
      status: AuthStatus.loading,
    );

    try {
      final email =
          await _firebaseAuth.verifyPasswordResetCode(
        code,
      );

      state = const AuthState(
        status: AuthStatus.initial,
      );

      return email;
    } on FirebaseAuthException catch (exception) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage:
            _getAuthErrorMessage(exception),
      );

      return null;
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage:
            'The password reset link is invalid or has expired.',
      );

      return null;
    }
  }

  //===========================================================================
  // CONFIRM PASSWORD RESET
  //===========================================================================

  Future<void> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) async {
    state = const AuthState(
      status: AuthStatus.loading,
    );

    try {
      await _firebaseAuth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );

      state = const AuthState(
        status: AuthStatus.passwordResetCompleted,
      );
    } on FirebaseAuthException catch (exception) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage:
            _getAuthErrorMessage(exception),
      );
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.error,
        errorMessage:
            'Unable to reset your password. Please try again.',
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

      case 'expired-action-code':
        return 'This password reset link has expired. Please request a new one.';

      case 'invalid-action-code':
        return 'This password reset link is invalid or has already been used.';

      case 'requires-recent-login':
        return 'Please sign in again before changing your password.';

      default:
        return 'Authentication failed. Please try again.';
    }
  }
}