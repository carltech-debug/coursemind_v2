/*
==============================================================================
FILE: login_screen.dart
MODULE: Authentication
COMPONENT: Login Screen
==============================================================================
*/

import 'package:flutter/material.dart';
import 'signup_screen.dart';

//=============================================================================
// DESIGN TOKENS
//=============================================================================

final class LoginTheme {
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color fieldBackground = Color(0xFFF2F4F6);
  static const Color primary = Color(0xFF4B41E1);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF45464D);
  static const Color outline = Color(0xFF76777D);
  static const Color outlineVariant = Color(0xFFC6C6CD);
}

//=============================================================================
// LOGIN SCREEN
//=============================================================================

final class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//=============================================================================
// LOGIN STATE
//=============================================================================

final class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _handleLogin() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Logging in as ${_emailController.text}...',
        ),
        backgroundColor: LoginTheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            //=================================================================
            // BACK BUTTON
            //=================================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: LoginTheme.onSurfaceVariant,
                  ),
                  label: const Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: LoginTheme.onSurfaceVariant,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ),

            //=================================================================
            // MAIN CONTENT
            //=================================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 480,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        //=====================================================
                        // BRANDING
                        //=====================================================

                        const Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.school,
                                  size: 40,
                                  color: LoginTheme.primary,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'CourseMind',
                                  style: TextStyle(
                                    fontSize: 24,
                                    height: 32 / 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Welcome back',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32,
                                height: 40 / 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.32,
                                color: LoginTheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Sign in to continue your learning journey.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                height: 24 / 16,
                                color:
                                    LoginTheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        //=====================================================
                        // LOGIN CARD
                        //=====================================================

                        Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: LoginTheme.surface,
                            borderRadius:
                                BorderRadius.circular(12),
                            border: Border.all(
                              color: LoginTheme.outlineVariant
                                  .withValues(alpha: 0.3),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(
                                  15,
                                  23,
                                  42,
                                  0.05,
                                ),
                                offset: Offset(0, 4),
                                blurRadius: 6,
                                spreadRadius: -1,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(
                                  15,
                                  23,
                                  42,
                                  0.1,
                                ),
                                offset: Offset(0, 10),
                                blurRadius: 15,
                                spreadRadius: -3,
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                //=================================================
                                // EMAIL
                                //=================================================

                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 4,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    'Email Address',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w600,
                                      color:
                                          LoginTheme.onSurface,
                                    ),
                                  ),
                                ),

                                TextFormField(
                                  controller: _emailController,
                                  keyboardType:
                                      TextInputType.emailAddress,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color:
                                        LoginTheme.onSurface,
                                  ),
                                  decoration:
                                      _inputDecoration(
                                    hintText:
                                        'student@university.edu',
                                    prefixIcon: Icons
                                        .mail_outline,
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty) {
                                      return 'Enter your email address';
                                    }

                                    if (!value.contains('@')) {
                                      return 'Enter a valid email address';
                                    }

                                    return null;
                                  },
                                ),

                                const SizedBox(height: 24),

                                //=================================================
                                // PASSWORD LABEL
                                //=================================================

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Password',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight.w600,
                                          color: LoginTheme
                                              .onSurface,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight.w600,
                                          color:
                                              LoginTheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                //=================================================
                                // PASSWORD
                                //=================================================

                                TextFormField(
                                  controller:
                                      _passwordController,
                                  obscureText:
                                      _obscurePassword,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color:
                                        LoginTheme.onSurface,
                                  ),
                                  decoration:
                                      _inputDecoration(
                                    hintText: '••••••••',
                                    prefixIcon:
                                        Icons.lock_outline,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons
                                                .visibility_outlined
                                            : Icons
                                                .visibility_off_outlined,
                                        color:
                                            LoginTheme.outline,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword =
                                              !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'Enter your password';
                                    }

                                    return null;
                                  },
                                ),

                                const SizedBox(height: 24),

                                //=================================================
                                // REMEMBER ME
                                //=================================================

                                Row(
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: _rememberMe,
                                        activeColor:
                                            LoginTheme.primary,
                                        shape:
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius
                                                  .circular(4),
                                        ),
                                        side: const BorderSide(
                                          color: LoginTheme
                                              .outlineVariant,
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            _rememberMe =
                                                value ?? false;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _rememberMe =
                                              !_rememberMe;
                                        });
                                      },
                                      child: const Text(
                                        'Remember me for 30 days',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                              FontWeight.w600,
                                          color: LoginTheme
                                              .onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 28),

                                //=================================================
                                // LOGIN BUTTON
                                //=================================================

                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: _handleLogin,
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          LoginTheme.primary,
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
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Log In',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                //=================================================
                                // OR DIVIDER
                                //=================================================

                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: LoginTheme
                                            .outlineVariant
                                            .withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Text(
                                        'OR',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              LoginTheme.outline,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: LoginTheme
                                            .outlineVariant
                                            .withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                //=================================================
                                // GOOGLE BUTTON
                                //=================================================

                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style:
                                        OutlinedButton.styleFrom(
                                      backgroundColor:
                                          LoginTheme
                                              .fieldBackground,
                                      foregroundColor:
                                          LoginTheme.onSurface,
                                      side: const BorderSide(
                                        color: LoginTheme
                                            .outlineVariant,
                                      ),
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons
                                              .account_circle_outlined,
                                          size: 20,
                                          color: LoginTheme
                                              .onSurfaceVariant,
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          'Continue with Google',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeight.w600,
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

                        const SizedBox(height: 40),

                        //=====================================================
                        // CREATE ACCOUNT
                        //=====================================================

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    LoginTheme.onSurfaceVariant,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Create one',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: LoginTheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //=================================================================
            // FOOTER
            //=================================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1280,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile =
                          constraints.maxWidth < 600;

                      return Flex(
                        direction: isMobile
                            ? Axis.vertical
                            : Axis.horizontal,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        LoginTheme.outline,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              GestureDetector(
                                 onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignUpScreen(),
                                      ),
                                    );
                                  },
                                child: const Text(
                                  'Terms of Service',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        LoginTheme.outline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (isMobile)
                            const SizedBox(height: 16),
                          const Text(
                            '© 2024 CourseMind EdTech. All rights reserved.',
                            style: TextStyle(
                              fontSize: 12,
                              color: LoginTheme.outline,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: LoginTheme.outline,
        fontSize: 16,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: LoginTheme.outline,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: LoginTheme.fieldBackground,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LoginTheme.outlineVariant,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LoginTheme.outlineVariant,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: LoginTheme.primary,
          width: 2,
        ),
      ),
    );
  }
}