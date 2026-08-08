/*
==============================================================================
FILE: signup_screen.dart
MODULE: Authentication
COMPONENT: Sign-Up Screen
==============================================================================
*/

import 'package:flutter/material.dart';
import 'login_screen.dart';

//=============================================================================
// DESIGN TOKENS
//=============================================================================

final class SignUpTheme {
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF131B2E);
  static const Color primary = Color(0xFF4B41E1);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF45464D);
  static const Color outline = Color(0xFF76777D);
  static const Color outlineVariant = Color(0xFFC6C6CD);
  static const Color fieldBackground = Color(0xFFECEEF0);
  static const Color secondaryFixed = Color(0xFFE2DFFF);
  static const Color tertiary = Color(0xFF6FFBBE);
  static const Color tertiaryDim = Color(0xFF4EDEA3);
  static const Color onTertiary = Color(0xFF009668);
  static const Color error = Color(0xFFBA1A1A);
}

//=============================================================================
// SIGN-UP SCREEN
//=============================================================================

final class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

//=============================================================================
// SIGN-UP STATE
//=============================================================================

final class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _hasLength = false;
  bool _hasUpper = false;
  bool _hasNumber = false;
  bool _matches = false;

  double _strengthScore = 0.0;

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(
      _updatePasswordMetrics,
    );

    _confirmPasswordController.addListener(
      _updatePasswordMetrics,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  //===========================================================================
  // PASSWORD METRICS
  //===========================================================================

  void _updatePasswordMetrics() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _hasLength = password.length >= 8;
      _hasUpper = RegExp(r'[A-Z]').hasMatch(password);
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
      _matches =
          password.isNotEmpty &&
          password == confirmPassword;

      var score = 0;

      if (_hasLength) {
        score += 25;
      }

      if (_hasUpper) {
        score += 25;
      }

      if (_hasNumber) {
        score += 25;
      }

      if (password.length > 12) {
        score += 25;
      }

      _strengthScore = score / 100;
    });
  }

  Color get _strengthColor {
    if (_strengthScore <= 0.25) {
      return SignUpTheme.error;
    }

    if (_strengthScore <= 0.75) {
      return SignUpTheme.primary;
    }

    return SignUpTheme.tertiaryDim;
  }

  String get _strengthText {
    if (_strengthScore <= 0.25) {
      return 'Weak';
    }

    if (_strengthScore <= 0.75) {
      return 'Medium';
    }

    return 'Strong';
  }

  Color get _strengthTextColor {
    if (_strengthScore <= 0.25) {
      return SignUpTheme.error;
    }

    if (_strengthScore <= 0.75) {
      return SignUpTheme.primary;
    }

    return SignUpTheme.onTertiary;
  }

  //===========================================================================
  // BUILD
  //===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SignUpTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1100,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: SignUpTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: SignUpTheme.outlineVariant
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
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isDesktop =
                            constraints.maxWidth >= 900;

                        if (isDesktop) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildLeftHeroSection(),
                              ),
                              Expanded(
                                child: _buildRightFormSection(),
                              ),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            _buildRightFormSection(),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                //================================================================
                // FOOTER
                //================================================================

                Wrap(
                  spacing: 24,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    const Text(
                      '© 2024 CourseMind Inc.',
                      style: TextStyle(
                        fontSize: 12,
                        color: SignUpTheme.outline,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Help Center',
                        style: TextStyle(
                          fontSize: 12,
                          color: SignUpTheme.outline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'System Status',
                        style: TextStyle(
                          fontSize: 12,
                          color: SignUpTheme.outline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // LEFT HERO SECTION
  //===========================================================================

  Widget _buildLeftHeroSection() {
    return Container(
      color: SignUpTheme.primaryContainer,
      padding: const EdgeInsets.all(64),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'CourseMind',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: SignUpTheme.secondaryFixed,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Unlock your academic potential with AI-driven learning.',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 24),

              _buildBenefitRow(
                icon: Icons.verified_user_outlined,
                title: 'Institutional Certification',
                subtitle:
                    'Verified credentials from Accra Technical University and partners.',
              ),

              const SizedBox(height: 24),

              _buildBenefitRow(
                icon: Icons.psychology_outlined,
                title: 'AI-Powered Tutoring',
                subtitle:
                    'Personalized study paths that adapt to your unique learning speed.',
              ),

              const SizedBox(height: 24),

              _buildBenefitRow(
                icon: Icons.group_outlined,
                title: 'Global Community',
                subtitle:
                    'Connect with thousands of students and industry professionals.',
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              padding: const EdgeInsets.only(top: 24),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFF3F465C),
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 88,
                    height: 40,
                    child: Stack(
                      children: [
                        _buildAvatarCircle(
                          0,
                          Icons.person,
                        ),
                        _buildAvatarCircle(
                          24,
                          Icons.person_2,
                        ),
                        _buildAvatarCircle(
                          48,
                          Icons.person_3,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Text(
                      'Join 50,000+ students already learning today.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7C839B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // BENEFIT ROW
  //===========================================================================

  Widget _buildBenefitRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: SignUpTheme.tertiary,
          size: 24,
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7C839B),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //===========================================================================
  // AVATAR
  //===========================================================================

  Widget _buildAvatarCircle(
    double left,
    IconData icon,
  ) {
    return Positioned(
      left: left,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE0E3E5),
          border: Border.all(
            color: SignUpTheme.primaryContainer,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: SignUpTheme.onSurfaceVariant,
        ),
      ),
    );
  }

  //===========================================================================
  // RIGHT FORM SECTION
  //===========================================================================

  Widget _buildRightFormSection() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 448,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              //=================================================================
              // MOBILE BRAND
              //=================================================================

              LayoutBuilder(
                builder: (context, constraints) {
                  if (MediaQuery.of(context).size.width <
                      900) {
                    return const Padding(
                      padding: EdgeInsets.only(
                        bottom: 24,
                      ),
                      child: Text(
                        'CourseMind',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: SignUpTheme.primary,
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              //=================================================================
              // HEADING
              //=================================================================

              const Text(
                'Create your CourseMind account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: SignUpTheme.onSurface,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Start your journey toward academic excellence today.',
                style: TextStyle(
                  fontSize: 16,
                  color:
                      SignUpTheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              //=================================================================
              // EMAIL
              //=================================================================

              _buildFloatingInput(
                controller: _emailController,
                label: 'Email Address',
                keyboardType:
                    TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              //=================================================================
              // PASSWORD
              //=================================================================

              _buildFloatingInput(
                controller: _passwordController,
                label: 'Password',
                obscureText: _obscurePassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscurePassword =
                        !_obscurePassword;
                  });
                },
              ),

              const SizedBox(height: 16),

              //=================================================================
              // CONFIRM PASSWORD
              //=================================================================

              _buildFloatingInput(
                controller:
                    _confirmPasswordController,
                label: 'Confirm Password',
                obscureText:
                    _obscureConfirmPassword,
                onToggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                  });
                },
              ),

              const SizedBox(height: 16),

              //=================================================================
              // PASSWORD STRENGTH
              //=================================================================

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      SignUpTheme.fieldBackground,
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(4),
                      child:
                          LinearProgressIndicator(
                        value: _strengthScore == 0
                            ? 0.05
                            : _strengthScore,
                        minHeight: 4,
                        backgroundColor:
                            SignUpTheme
                                .outlineVariant,
                        valueColor:
                            AlwaysStoppedAnimation<
                                Color>(
                          _strengthColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _strengthText.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            _strengthTextColor,
                        letterSpacing: 0.8,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _buildRequirementItem(
                          '8+ characters',
                          _hasLength,
                        ),
                        _buildRequirementItem(
                          'One uppercase',
                          _hasUpper,
                        ),
                        _buildRequirementItem(
                          'One number',
                          _hasNumber,
                        ),
                        _buildRequirementItem(
                          'Passwords match',
                          _matches,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              //=================================================================
              // CREATE ACCOUNT
              //=================================================================

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        SignUpTheme.primary,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              //=================================================================
              // LOGIN LINK
              //=================================================================

              Center(
                child: Wrap(
                  alignment:
                      WrapAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 16,
                        color: SignUpTheme
                            .onSurfaceVariant,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              SignUpTheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              //=================================================================
              // INSTITUTION REGISTRATION
              //=================================================================

              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Register as an institution',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w600,
                      color: SignUpTheme.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              //=================================================================
              // DIVIDER
              //=================================================================

              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color:
                          SignUpTheme
                              .outlineVariant,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'OR REGISTER WITH',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            SignUpTheme.outline,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color:
                          SignUpTheme
                              .outlineVariant,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              //=================================================================
              // SOCIAL REGISTRATION
              //=================================================================

              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton(
                      label: 'Google',
                      iconWidget:
                          const _GoogleIcon(
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: _buildSocialButton(
                      label: 'Apple',
                      iconWidget:
                          const Icon(
                        Icons.apple,
                        size: 20,
                        color:
                            SignUpTheme
                                .onSurface,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              //=================================================================
              // TERMS
              //=================================================================

              Center(
                child: RichText(
                  textAlign:
                      TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          SignUpTheme.outline,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'By clicking "Create Account", you agree to our ',
                      ),
                      TextSpan(
                        text:
                            'Terms of Service',
                        style: TextStyle(
                          decoration:
                              TextDecoration
                                  .underline,
                          color:
                              SignUpTheme
                                  .onSurface,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text:
                            'Privacy Policy',
                        style: TextStyle(
                          decoration:
                              TextDecoration
                                  .underline,
                          color:
                              SignUpTheme
                                  .onSurface,
                        ),
                      ),
                      TextSpan(
                        text: '.',
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
  // INPUT
  //===========================================================================

  Widget _buildFloatingInput({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextInputType keyboardType =
        TextInputType.text,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: SignUpTheme.fieldBackground,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 16,
          color: SignUpTheme.onSurface,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color:
                SignUpTheme.onSurfaceVariant,
            fontSize: 14,
          ),
          floatingLabelStyle:
              const TextStyle(
            color: SignUpTheme.primary,
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8),
            borderSide:
                const BorderSide(
              color: SignUpTheme.primary,
              width: 2,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          suffixIcon:
              onToggleVisibility != null
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons
                                .visibility_outlined
                            : Icons
                                .visibility_off_outlined,
                        color:
                            SignUpTheme
                                .onSurfaceVariant,
                      ),
                      onPressed:
                          onToggleVisibility,
                    )
                  : null,
        ),
      ),
    );
  }

  //===========================================================================
  // PASSWORD REQUIREMENT
  //===========================================================================

  Widget _buildRequirementItem(
    String text,
    bool isValid,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check_circle,
          size: 16,
          color: isValid
              ? SignUpTheme.onTertiary
              : SignUpTheme.outline,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isValid
                ? SignUpTheme.onTertiary
                : SignUpTheme.outline,
          ),
        ),
      ],
    );
  }

  //===========================================================================
  // SOCIAL BUTTON
  //===========================================================================

  Widget _buildSocialButton({
    required String label,
    required Widget iconWidget,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: () {},
        style:
            OutlinedButton.styleFrom(
          side: const BorderSide(
            color:
                SignUpTheme.outlineVariant,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight:
                    FontWeight.w600,
                color:
                    SignUpTheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//=============================================================================
// GOOGLE ICON
//=============================================================================

final class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon({
    this.size = 20,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GooglePainter(),
      ),
    );
  }
}

final class _GooglePainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final width = size.width;
    final height = size.height;

    final paint = Paint()
      ..style = PaintingStyle.fill;

    paint.color =
        const Color(0xFFEA4335);

    canvas.drawArc(
      Rect.fromLTWH(
        0,
        0,
        width,
        height,
      ),
      -0.5,
      1.8,
      true,
      paint,
    );

    paint.color =
        const Color(0xFFFBBC05);

    canvas.drawArc(
      Rect.fromLTWH(
        0,
        0,
        width,
        height,
      ),
      1.3,
      1.5,
      true,
      paint,
    );

    paint.color =
        const Color(0xFF34A853);

    canvas.drawArc(
      Rect.fromLTWH(
        0,
        0,
        width,
        height,
      ),
      2.8,
      1.2,
      true,
      paint,
    );

    paint.color =
        const Color(0xFF4285F4);

    canvas.drawArc(
      Rect.fromLTWH(
        0,
        0,
        width,
        height,
      ),
      4.0,
      1.8,
      true,
      paint,
    );

    paint.color = Colors.white;

    canvas.drawCircle(
      Offset(
        width / 2,
        height / 2,
      ),
      width * 0.3,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}