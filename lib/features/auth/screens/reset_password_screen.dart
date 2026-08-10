/*
==============================================================================
FILE: reset_password_screen.dart
MODULE: Authentication
COMPONENT: Reset Password Screen
==============================================================================
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_state.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

//=============================================================================
// DESIGN TOKENS
//=============================================================================

final class ResetPasswordTheme {
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLow = Color(0xFFF2F4F6);
  static const Color surfaceHigh = Color(0xFFE6E8EA);

  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF4B41E1);
  static const Color secondaryContainer = Color(0xFF645EFB);

  static const Color success = Color(0xFF009668);
  static const Color error = Color(0xFFBA1A1A);

  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF45464D);

  static const Color outline = Color(0xFF76777D);
  static const Color outlineVariant = Color(0xFFC6C6CD);
}

//=============================================================================
// RESET PASSWORD SCREEN
//=============================================================================

final class ResetPasswordScreen
    extends ConsumerStatefulWidget {
  const ResetPasswordScreen({
    required this.oobCode,
    super.key,
  });

  final String oobCode;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

//=============================================================================
// STATE
//=============================================================================

final class _ResetPasswordScreenState
    extends ConsumerState<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _passwordFocusNode =
      FocusNode();

  final FocusNode _confirmPasswordFocusNode =
      FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _isVerifyingCode = true;
  bool _isSubmitting = false;
  bool _isSuccess = false;
  bool _isInvalidCode = false;

  String? _verifiedEmail;

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(
      _validatePassword,
    );

    _verifyResetCode();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  //===========================================================================
  // VERIFY RESET CODE
  //===========================================================================

  Future<void> _verifyResetCode() async {
    if (widget.oobCode.trim().isEmpty) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isVerifyingCode = false;
        _isInvalidCode = true;
      });

      return;
    }

    final email = await ref
        .read(authProvider.notifier)
        .verifyPasswordResetCode(
          code: widget.oobCode,
        );

    if (!mounted) {
      return;
    }

    setState(() {
      _isVerifyingCode = false;
      _verifiedEmail = email;
      _isInvalidCode = email == null;
    });
  }

  //===========================================================================
  // PASSWORD VALIDATION
  //===========================================================================

  void _validatePassword() {
    final value = _passwordController.text;

    if (!mounted) {
      return;
    }

    setState(() {
      _hasMinLength = value.length >= 8;
      _hasUppercase =
          RegExp(r'[A-Z]').hasMatch(value);
      _hasLowercase =
          RegExp(r'[a-z]').hasMatch(value);
      _hasNumber =
          RegExp(r'[0-9]').hasMatch(value);
      _hasSpecialChar =
          RegExp(
            r'[!@#$%^&*(),.?":{}|<>]',
          ).hasMatch(value);
    });
  }

  int get _score {
    var count = 0;

    if (_hasMinLength) count++;
    if (_hasUppercase) count++;
    if (_hasLowercase) count++;
    if (_hasNumber) count++;
    if (_hasSpecialChar) count++;

    return count;
  }

  String get _strengthText {
    if (_score <= 2) {
      return 'Weak';
    }

    if (_score <= 4) {
      return 'Medium';
    }

    return 'Strong';
  }

  Color get _strengthColor {
    if (_score <= 2) {
      return ResetPasswordTheme.error;
    }

    if (_score <= 4) {
      return ResetPasswordTheme.secondary;
    }

    return ResetPasswordTheme.success;
  }

  //===========================================================================
  // RESET PASSWORD
  //===========================================================================

  Future<void> _handleReset() async {
    if (!(_formKey.currentState?.validate() ??
        false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isSubmitting = true;
    });

    await ref
        .read(authProvider.notifier)
        .confirmPasswordReset(
          code: widget.oobCode,
          newPassword:
              _passwordController.text,
        );

    if (!mounted) {
      return;
    }

    final authState = ref.read(authProvider);

    setState(() {
      _isSubmitting = false;
      _isSuccess =
          authState.status ==
              AuthStatus.passwordResetCompleted;
    });

    if (authState.status ==
        AuthStatus.error) {
      _showError(
        authState.errorMessage ??
            'Unable to reset your password.',
      );
    }
  }

  //===========================================================================
  // ERROR
  //===========================================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            ResetPasswordTheme.error,
      ),
    );
  }

  //===========================================================================
  // GO TO LOGIN
  //===========================================================================

  void _goToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (_) => false,
    );
  }

  //===========================================================================
  // BUILD
  //===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ResetPasswordTheme.background,
      body: Container(
        decoration:
            const BoxDecoration(
          color:
              ResetPasswordTheme.background,
          gradient:
              RadialGradient(
            center:
                Alignment.topRight,
            radius: 1.2,
            colors: [
              Color(0xFFE2DFFF),
              ResetPasswordTheme.background,
            ],
            stops: [
              0.0,
              0.6,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child:
                SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 448,
                ),
                child: _buildContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // CONTENT
  //===========================================================================

  Widget _buildContent() {
    if (_isVerifyingCode) {
      return _buildLoadingCard();
    }

    if (_isInvalidCode) {
      return _buildInvalidCodeCard();
    }

    if (_isSuccess) {
      return _buildSuccessCard();
    }

    return _buildFormCard();
  }

  //===========================================================================
  // VERIFYING CARD
  //===========================================================================

  Widget _buildLoadingCard() {
    return _buildCard(
      child: const Padding(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child:
                  CircularProgressIndicator(
                strokeWidth: 3,
                color:
                    ResetPasswordTheme
                        .secondary,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Verifying Reset Link',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
                color:
                    ResetPasswordTheme
                        .onSurface,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please wait while we verify your password reset request.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 20 / 14,
                color:
                    ResetPasswordTheme
                        .onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //===========================================================================
  // INVALID CODE CARD
  //===========================================================================

  Widget _buildInvalidCodeCard() {
    final authState =
        ref.read(authProvider);

    return _buildCard(
      child: Padding(
        padding:
            const EdgeInsets.all(64),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration:
                  BoxDecoration(
                color:
                    ResetPasswordTheme
                        .error
                        .withValues(
                  alpha: 0.1,
                ),
                shape:
                    BoxShape.circle,
              ),
              child: const Icon(
                Icons
                    .link_off_outlined,
                size: 42,
                color:
                    ResetPasswordTheme
                        .error,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Invalid Reset Link',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
                color:
                    ResetPasswordTheme
                        .onSurface,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              authState.errorMessage ??
                  'This password reset link is invalid or has expired. Please request a new reset link.',
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 24 / 16,
                color:
                    ResetPasswordTheme
                        .onSurfaceVariant,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _primaryButton(
              label:
                  'Back to Sign In',
              onPressed:
                  _goToLogin,
            ),
          ],
        ),
      ),
    );
  }

  //===========================================================================
  // SUCCESS CARD
  //===========================================================================

  Widget _buildSuccessCard() {
    return _buildCard(
      child: Padding(
        padding:
            const EdgeInsets.all(64),
        child: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration:
                  const BoxDecoration(
                color:
                    ResetPasswordTheme
                        .success,
                shape:
                    BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Password Changed',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                height: 40 / 32,
                fontWeight:
                    FontWeight.bold,
                letterSpacing:
                    -0.32,
                color:
                    ResetPasswordTheme
                        .primary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Your password has been reset successfully. You can now use your new credentials to log in.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 24 / 16,
                color:
                    ResetPasswordTheme
                        .onSurfaceVariant,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _primaryButton(
              label:
                  'Go to Sign In',
              onPressed:
                  _goToLogin,
            ),
          ],
        ),
      ),
    );
  }

  //===========================================================================
  // FORM CARD
  //===========================================================================

  Widget _buildFormCard() {
    return _buildCard(
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.all(64),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .stretch,
            children: [
              //===============================================================
              // ICON
              //===============================================================

              Center(
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child:
                      Image.asset(
                    'assets/images/auth/forgot_password_icon.png',
                    fit:
                        BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              //===============================================================
              // TITLE
              //===============================================================

              const Text(
                'Create New Password',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  height: 40 / 32,
                  fontWeight:
                      FontWeight.bold,
                  letterSpacing:
                      -0.32,
                  color:
                      ResetPasswordTheme
                          .primary,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              //===============================================================
              // DESCRIPTION
              //===============================================================

              const Text(
                'Your new password must be different from your previous password and meet the security requirements below.',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  color:
                      ResetPasswordTheme
                          .onSurfaceVariant,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //===============================================================
              // VERIFIED EMAIL
              //===============================================================

              if (_verifiedEmail != null)
                Padding(
                  padding:
                      const EdgeInsets
                          .only(
                    bottom: 16,
                  ),
                  child: Text(
                    'Resetting password for $_verifiedEmail',
                    textAlign:
                        TextAlign.center,
                    style:
                        const TextStyle(
                      fontSize: 12,
                      color:
                          ResetPasswordTheme
                              .onSurfaceVariant,
                    ),
                  ),
                ),

              //===============================================================
              // NEW PASSWORD
              //===============================================================

              _buildLabel(
                'New Password',
              ),

              TextFormField(
                controller:
                    _passwordController,
                focusNode:
                    _passwordFocusNode,
                obscureText:
                    _obscurePassword,
                enabled:
                    !_isSubmitting,
                validator:
                    (value) {
                  if (value ==
                          null ||
                      value.isEmpty) {
                    return 'Please enter a password';
                  }

                  if (_score < 5) {
                    return 'Password does not meet all security requirements';
                  }

                  return null;
                },
                decoration:
                    _passwordDecoration(
                  hint:
                      'Enter new password',
                  obscure:
                      _obscurePassword,
                  onToggle:
                      () {
                    setState(() {
                      _obscurePassword =
                          !_obscurePassword;
                    });
                  },
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              //===============================================================
              // CONFIRM PASSWORD
              //===============================================================

              _buildLabel(
                'Confirm New Password',
              ),

              TextFormField(
                controller:
                    _confirmPasswordController,
                focusNode:
                    _confirmPasswordFocusNode,
                obscureText:
                    _obscureConfirmPassword,
                enabled:
                    !_isSubmitting,
                validator:
                    (value) {
                  if (value ==
                          null ||
                      value.isEmpty) {
                    return 'Please confirm your password';
                  }

                  if (value !=
                      _passwordController
                          .text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },
                decoration:
                    _passwordDecoration(
                  hint:
                      'Re-type new password',
                  obscure:
                      _obscureConfirmPassword,
                  onToggle:
                      () {
                    setState(() {
                      _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                    });
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //===============================================================
              // SECURITY STRENGTH
              //===============================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  const Text(
                    'Security Strength',
                    style:
                        TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          ResetPasswordTheme
                              .onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _strengthText,
                    style:
                        TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          _strengthColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              //===============================================================
              // STRENGTH BAR
              //===============================================================

              ClipRRect(
                borderRadius:
                    BorderRadius
                        .circular(
                  999,
                ),
                child:
                    Container(
                  height: 8,
                  color:
                      ResetPasswordTheme
                          .surfaceHigh,
                  child:
                      FractionallySizedBox(
                    alignment:
                        Alignment
                            .centerLeft,
                    widthFactor:
                        _score / 5,
                    child:
                        AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds:
                            300,
                      ),
                      color:
                          _strengthColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              //===============================================================
              // REQUIREMENTS
              //===============================================================

              GridView.count(
                shrinkWrap:
                    true,
                physics:
                    const NeverScrollableScrollPhysics(),
                crossAxisCount:
                    2,
                childAspectRatio:
                    4.5,
                mainAxisSpacing:
                    8,
                crossAxisSpacing:
                    16,
                children: [
                  _buildRequirement(
                    '8+ Characters',
                    _hasMinLength,
                  ),
                  _buildRequirement(
                    'Uppercase',
                    _hasUppercase,
                  ),
                  _buildRequirement(
                    'Lowercase',
                    _hasLowercase,
                  ),
                  _buildRequirement(
                    'Number',
                    _hasNumber,
                  ),
                  _buildRequirement(
                    'Special Char',
                    _hasSpecialChar,
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),

              //===============================================================
              // RESET BUTTON
              //===============================================================

              SizedBox(
                width:
                    double.infinity,
                height: 48,
                child:
                    ElevatedButton(
                  onPressed:
                      _isSubmitting
                          ? null
                          : _handleReset,
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF2563EB,
                    ),
                    foregroundColor:
                        Colors.white,
                    elevation: 1,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        8,
                      ),
                    ),
                  ),
                  child:
                      _isSubmitting
                          ? const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                              children: [
                                SizedBox(
                                  width:
                                      18,
                                  height:
                                      18,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth:
                                        2,
                                    color:
                                        Colors
                                            .white,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      8,
                                ),
                                Text(
                                  'Processing...',
                                  style:
                                      TextStyle(
                                    fontSize:
                                        14,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ],
                            )
                          : const Text(
                              'Reset Password',
                              style:
                                  TextStyle(
                                fontSize:
                                    14,
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              //===============================================================
              // BACK TO SIGN IN
              //===============================================================

              InkWell(
                onTap:
                    _isSubmitting
                        ? null
                        : _goToLogin,
                borderRadius:
                    BorderRadius
                        .circular(
                  4,
                ),
                child:
                    const Padding(
                  padding:
                      EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 20,
                        color:
                            ResetPasswordTheme
                                .onSurfaceVariant,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Back to Sign In',
                        style:
                            TextStyle(
                          fontSize: 14,
                          fontWeight:
                              FontWeight
                                  .w600,
                          color:
                              ResetPasswordTheme
                                  .onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // CARD
  //===========================================================================

  Widget _buildCard({
    required Widget child,
  }) {
    return Container(
      width:
          double.infinity,
      decoration:
          BoxDecoration(
        color:
            ResetPasswordTheme.surface,
        borderRadius:
            BorderRadius.circular(
          20,
        ),
        boxShadow: const [
          BoxShadow(
            color:
                Color.fromRGBO(
              15,
              23,
              42,
              0.1,
            ),
            offset:
                Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: child,
    );
  }

  //===========================================================================
  // LABEL
  //===========================================================================

  Widget _buildLabel(
    String label,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: Text(
        label,
        style:
            const TextStyle(
          fontSize: 14,
          fontWeight:
              FontWeight.w600,
          letterSpacing: 0.7,
          color:
              ResetPasswordTheme
                  .onSurfaceVariant,
        ),
      ),
    );
  }

  //===========================================================================
  // PASSWORD DECORATION
  //===========================================================================

  InputDecoration _passwordDecoration({
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          const TextStyle(
        color:
            ResetPasswordTheme
                .outline,
      ),
      filled: true,
      fillColor:
          ResetPasswordTheme
              .surfaceLow,
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 64,
        vertical: 12,
      ),
      prefixIcon:
          const Icon(
        Icons.lock_outline,
        color:
            ResetPasswordTheme
                .outline,
      ),
      suffixIcon:
          IconButton(
        icon: Icon(
          obscure
              ? Icons
                  .visibility_outlined
              : Icons
                  .visibility_off_outlined,
          color:
              ResetPasswordTheme
                  .outline,
        ),
        onPressed:
            onToggle,
      ),
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8,
        ),
        borderSide:
            const BorderSide(
          color:
              ResetPasswordTheme
                  .outlineVariant,
        ),
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8,
        ),
        borderSide:
            const BorderSide(
          color:
              ResetPasswordTheme
                  .outlineVariant,
        ),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          8,
        ),
        borderSide:
            const BorderSide(
          color:
              ResetPasswordTheme
                  .secondaryContainer,
          width: 2,
        ),
      ),
    );
  }

  //===========================================================================
  // PRIMARY BUTTON
  //===========================================================================

  Widget _primaryButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width:
          double.infinity,
      height: 48,
      child:
          ElevatedButton(
        onPressed:
            onPressed,
        style:
            ElevatedButton.styleFrom(
          backgroundColor:
              ResetPasswordTheme
                  .secondaryContainer,
          foregroundColor:
              Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              8,
            ),
          ),
        ),
        child: Text(
          label,
          style:
              const TextStyle(
            fontSize: 14,
            fontWeight:
                FontWeight.w600,
            letterSpacing: 0.7,
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // REQUIREMENT ITEM
  //===========================================================================

  Widget _buildRequirement(
    String label,
    bool satisfied,
  ) {
    final color = satisfied
        ? ResetPasswordTheme
            .success
        : ResetPasswordTheme
            .onSurfaceVariant;

    return Row(
      children: [
        Icon(
          satisfied
              ? Icons.check_circle
              : Icons
                  .check_circle_outline,
          size: 16,
          color: color,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            label,
            style:
                TextStyle(
              fontSize: 12,
              color: color,
            ),
            overflow:
                TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}