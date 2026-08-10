/*
==============================================================================
FILE: auth_action_handler.dart
MODULE: Application
COMPONENT: Firebase Auth Action Handler
==============================================================================

DESCRIPTION
-----------
Handles Firebase Authentication email action links.

Currently supported:
• Password reset links

The widget reads Firebase Auth action parameters from the
current web URL and routes password reset requests to the
Reset Password screen.

==============================================================================
*/

import 'package:flutter/material.dart';

import '../../features/auth/screens/reset_password_screen.dart';

//=============================================================================
// AUTH ACTION HANDLER
//=============================================================================

final class AuthActionHandler extends StatelessWidget {
  const AuthActionHandler({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.base;

    final mode =
        uri.queryParameters['mode'];

    final oobCode =
        uri.queryParameters['oobCode'];

    //=========================================================================
    // PASSWORD RESET
    //=========================================================================

    if (mode == 'resetPassword' &&
        oobCode != null &&
        oobCode.isNotEmpty) {
      return ResetPasswordScreen(
        oobCode: oobCode,
      );
    }

    //=========================================================================
    // NORMAL APPLICATION
    //=========================================================================

    return child;
  }
}