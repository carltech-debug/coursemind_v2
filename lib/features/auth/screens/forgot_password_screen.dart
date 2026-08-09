/*
==============================================================================
FILE: forgot_password_screen.dart
MODULE: Authentication
COMPONENT: Forgot Password Screen
==============================================================================
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_state.dart';
import '../providers/auth_provider.dart';

//=============================================================================
// DESIGN TOKENS
//=============================================================================

final class ForgotPasswordTheme {
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF4B41E1);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF45464D);
  static const Color outline = Color(0xFF76777D);
  static const Color outlineVariant = Color(0xFFC6C6CD);
}

//=============================================================================
// FORGOT PASSWORD SCREEN
//=============================================================================

final class ForgotPasswordScreen
    extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

//=============================================================================
// STATE
//=============================================================================

final class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final FocusNode _emailFocusNode =
      FocusNode();

  bool _isFocused = false;
  bool _isSent = false;

  Timer? _successTimer;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(
      _handleFocusChange,
    );
  }

  @override
  void dispose() {
    _successTimer?.cancel();
    _emailController.dispose();
    _emailFocusNode.dispose();

    super.dispose();
  }

  //===========================================================================
  // FOCUS
  //===========================================================================

  void _handleFocusChange() {
    if (!mounted) {
      return;
    }

    setState(() {
      _isFocused =
          _emailFocusNode.hasFocus;
    });
  }

  //===========================================================================
  // SEND RESET LINK
  //===========================================================================

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ??
        false)) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isSent = false;
    });

    await ref
        .read(authProvider.notifier)
        .resetPassword(
          email:
              _emailController.text.trim(),
        );

    if (!mounted) {
      return;
    }

    final authState =
        ref.read(authProvider);

    if (authState.status ==
        AuthStatus.passwordResetSent) {
      setState(() {
        _isSent = true;
      });

      _successTimer?.cancel();

      _successTimer = Timer(
        const Duration(seconds: 3),
        () {
          if (!mounted) {
            return;
          }

          setState(() {
            _isSent = false;
          });
        },
      );

      return;
    }

    if (authState.status ==
        AuthStatus.error) {
      _showError(
        authState.errorMessage ??
            'Unable to send the reset link.',
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
            Colors.red.shade700,
      ),
    );
  }

  //===========================================================================
  // BUILD
  //===========================================================================

  @override
  Widget build(BuildContext context) {
    final authState =
        ref.watch(authProvider);

    final isSubmitting =
        authState.status ==
            AuthStatus.loading;

    return Scaffold(
      backgroundColor:
          ForgotPasswordTheme.background,
      body: Container(
        decoration:
            const BoxDecoration(
          color:
              ForgotPasswordTheme
                  .background,
          gradient:
              RadialGradient(
            center:
                Alignment.topRight,
            radius: 1.2,
            colors: [
              Color.fromRGBO(
                75,
                65,
                225,
                0.05,
              ),
              Colors.transparent,
            ],
            stops: [
              0.0,
              1.0,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child:
                SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 480,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .center,
                  children: [
                    //=========================================================
                    // BRAND
                    //=========================================================

                    const Column(
                      children: [
                        Text(
                          'CourseMind',
                          style:
                              TextStyle(
                            fontSize: 24,
                            height:
                                32 / 24,
                            fontWeight:
                                FontWeight
                                    .bold,
                            letterSpacing:
                                -0.5,
                            color:
                                Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Opacity(
                          opacity: 0.7,
                          child: Text(
                            'Accra Technical Education Portal',
                            style:
                                TextStyle(
                              fontSize:
                                  14,
                              height:
                                  20 / 14,
                              fontWeight:
                                  FontWeight
                                      .w600,
                              letterSpacing:
                                  0.7,
                              color:
                                  ForgotPasswordTheme
                                      .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    //=========================================================
                    // CARD
                    //=========================================================

                    Container(
                      width:
                          double.infinity,
                      padding:
                          const EdgeInsets
                              .all(40),
                      decoration:
                          BoxDecoration(
                        color:
                            ForgotPasswordTheme
                                .surface,
                        borderRadius:
                            BorderRadius
                                .circular(
                          12,
                        ),
                        boxShadow:
                            const [
                          BoxShadow(
                            color:
                                Color
                                    .fromRGBO(
                              15,
                              23,
                              42,
                              0.05,
                            ),
                            offset:
                                Offset(
                              0,
                              4,
                            ),
                            blurRadius:
                                6,
                            spreadRadius:
                                -1,
                          ),
                          BoxShadow(
                            color:
                                Color
                                    .fromRGBO(
                              15,
                              23,
                              42,
                              0.1,
                            ),
                            offset:
                                Offset(
                              0,
                              10,
                            ),
                            blurRadius:
                                15,
                            spreadRadius:
                                -3,
                          ),
                        ],
                      ),
                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .center,
                        children: [
                          //===================================================
                          // SECURITY ICON
                          //===================================================

                          Container(
                            width: 128,
                            height: 128,
                            margin:
                                const EdgeInsets
                                    .only(
                              bottom: 24,
                            ),
                            child:
                                Image.asset(
                              'assets/images/auth/forgot_password_icon.png',
                              fit:
                                  BoxFit.contain,
                            ),
                          ),

                          //===================================================
                          // TITLE
                          //===================================================

                          const Text(
                            'Forgot Password?',
                            textAlign:
                                TextAlign
                                    .center,
                            style:
                                TextStyle(
                              fontSize:
                                  32,
                              height:
                                  40 / 32,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              letterSpacing:
                                  -0.32,
                              color:
                                  ForgotPasswordTheme
                                      .onSurface,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          //===================================================
                          // DESCRIPTION
                          //===================================================

                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(
                              maxWidth: 320,
                            ),
                            child: const Text(
                              "Don't worry. Enter the email address linked to your account, and we'll send you a password reset link.",
                              textAlign:
                                  TextAlign
                                      .center,
                              style:
                                  TextStyle(
                                fontSize:
                                    16,
                                height:
                                    24 / 16,
                                color:
                                    ForgotPasswordTheme
                                        .onSurfaceVariant,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          //===================================================
                          // FORM
                          //===================================================

                          Form(
                            key:
                                _formKey,
                            child:
                                Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets
                                          .only(
                                    left: 4,
                                    bottom: 8,
                                  ),
                                  child:
                                      Text(
                                    'Email Address',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          14,
                                      fontWeight:
                                          FontWeight
                                              .w600,
                                      color:
                                          ForgotPasswordTheme
                                              .onSurface,
                                    ),
                                  ),
                                ),

                                //================================================
                                // EMAIL
                                //================================================

                                TextFormField(
                                  controller:
                                      _emailController,
                                  focusNode:
                                      _emailFocusNode,
                                  keyboardType:
                                      TextInputType
                                          .emailAddress,
                                  enabled:
                                      !isSubmitting,
                                  style:
                                      const TextStyle(
                                    fontSize:
                                        16,
                                    color:
                                        ForgotPasswordTheme
                                            .onSurface,
                                  ),
                                  validator:
                                      (value) {
                                    if (value ==
                                            null ||
                                        value
                                            .trim()
                                            .isEmpty) {
                                      return 'Please enter your email address';
                                    }

                                    if (!value
                                        .contains(
                                      '@',
                                    )) {
                                      return 'Please enter a valid email address';
                                    }

                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(
                                    hintText:
                                        'Enter your university or registered email',
                                    hintStyle:
                                        TextStyle(
                                      color:
                                          ForgotPasswordTheme
                                              .outline
                                              .withValues(
                                        alpha:
                                            0.6,
                                      ),
                                      fontSize:
                                          16,
                                    ),
                                    prefixIcon:
                                        AnimatedScale(
                                      scale:
                                          _isFocused
                                              ? 1.1
                                              : 1.0,
                                      duration:
                                          const Duration(
                                        milliseconds:
                                            200,
                                      ),
                                      child:
                                          Icon(
                                        Icons
                                            .mail_outline,
                                        color:
                                            _isFocused
                                                ? ForgotPasswordTheme
                                                    .primary
                                                : ForgotPasswordTheme
                                                    .outline,
                                      ),
                                    ),
                                    filled:
                                        true,
                                    fillColor:
                                        ForgotPasswordTheme
                                            .background,
                                    contentPadding:
                                        const EdgeInsets
                                            .symmetric(
                                      vertical:
                                          12,
                                      horizontal:
                                          24,
                                    ),
                                    border:
                                        OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        8,
                                      ),
                                      borderSide:
                                          const BorderSide(
                                        color:
                                            ForgotPasswordTheme
                                                .outlineVariant,
                                      ),
                                    ),
                                    enabledBorder:
                                        OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        8,
                                      ),
                                      borderSide:
                                          const BorderSide(
                                        color:
                                            ForgotPasswordTheme
                                                .outlineVariant,
                                      ),
                                    ),
                                    focusedBorder:
                                        OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        8,
                                      ),
                                      borderSide:
                                          const BorderSide(
                                        color:
                                            ForgotPasswordTheme
                                                .primary,
                                        width:
                                            2,
                                      ),
                                    ),
                                    disabledBorder:
                                        OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        8,
                                      ),
                                      borderSide:
                                          const BorderSide(
                                        color:
                                            ForgotPasswordTheme
                                                .outlineVariant,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 24,
                                ),

                                //================================================
                                // SEND BUTTON
                                //================================================

                                SizedBox(
                                  width:
                                      double.infinity,
                                  height:
                                      48,
                                  child:
                                      ElevatedButton(
                                    onPressed:
                                        isSubmitting
                                            ? null
                                            : _handleSubmit,
                                    style:
                                        ElevatedButton
                                            .styleFrom(
                                      backgroundColor:
                                          _isSent
                                              ? const Color(
                                                  0xFF009668,
                                                )
                                              : ForgotPasswordTheme
                                                  .primary,
                                      foregroundColor:
                                          ForgotPasswordTheme
                                              .onPrimary,
                                      disabledBackgroundColor:
                                          ForgotPasswordTheme
                                              .primary
                                              .withValues(
                                        alpha:
                                            0.55,
                                      ),
                                      elevation:
                                          8,
                                      shadowColor:
                                          const Color
                                              .fromRGBO(
                                        37,
                                        99,
                                        235,
                                        0.3,
                                      ),
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
                                        _buildButtonContent(
                                      isSubmitting,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          //===================================================
                          // BACK TO SIGN IN
                          //===================================================

                          MouseRegion(
                            cursor:
                                SystemMouseCursors
                                    .click,
                            child:
                                GestureDetector(
                              onTap:
                                  isSubmitting
                                      ? null
                                      : () {
                                          if (Navigator
                                              .canPop(
                                            context,
                                          )) {
                                            Navigator
                                                .pop(
                                              context,
                                            );
                                          }
                                        },
                              child:
                                  const Row(
                                mainAxisSize:
                                    MainAxisSize
                                        .min,
                                children: [
                                  Icon(
                                    Icons
                                        .arrow_back,
                                    size:
                                        18,
                                    color:
                                        ForgotPasswordTheme
                                            .primary,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Back to Sign In',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          14,
                                      fontWeight:
                                          FontWeight
                                              .w600,
                                      color:
                                          ForgotPasswordTheme
                                              .primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    //=========================================================
                    // SUPPORT FOOTER
                    //=========================================================

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          children: [
                            const Text(
                              'Need help? ',
                              style:
                                  TextStyle(
                                fontSize:
                                    12,
                                color:
                                    ForgotPasswordTheme
                                        .onSurfaceVariant,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child:
                                  const Text(
                                'Contact Support',
                                style:
                                    TextStyle(
                                  fontSize:
                                      12,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                  color:
                                      ForgotPasswordTheme
                                          .primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        const Opacity(
                          opacity: 0.5,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              Text(
                                'Privacy Policy',
                                style:
                                    TextStyle(
                                  fontSize:
                                      12,
                                  color:
                                      ForgotPasswordTheme
                                          .onSurface,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                '•',
                                style:
                                    TextStyle(
                                  fontSize:
                                      12,
                                  color:
                                      ForgotPasswordTheme
                                          .onSurface,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                'Terms of Service',
                                style:
                                    TextStyle(
                                  fontSize:
                                      12,
                                  color:
                                      ForgotPasswordTheme
                                          .onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // BUTTON CONTENT
  //===========================================================================

  Widget _buildButtonContent(
    bool isSubmitting,
  ) {
    if (isSubmitting) {
      return const Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child:
                CircularProgressIndicator(
              strokeWidth: 2,
              color:
                  ForgotPasswordTheme
                      .onPrimary,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Sending...',
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      );
    }

    if (_isSent) {
      return const Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 20,
            color:
                ForgotPasswordTheme
                    .onPrimary,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Sent!',
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return const Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Text(
          'Send Reset Link',
          style: TextStyle(
            fontSize: 14,
            fontWeight:
                FontWeight.w600,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Icon(
          Icons.send,
          size: 20,
        ),
      ],
    );
  }
}