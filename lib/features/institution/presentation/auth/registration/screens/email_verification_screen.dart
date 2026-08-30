// ignore_for_file: always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../app/theme/app_colors.dart';
import '../../../../../../app/theme/app_spacing.dart';
import '../../../../../../app/theme/app_text_styles.dart';

import '../providers/institution_registration_provider.dart';
import '../widgets/institution_glass_card.dart';
import '../widgets/institution_glass_circle_button.dart';
import '../widgets/institution_registration_actions.dart';
import '../widgets/institution_registration_header.dart';
import '../widgets/institution_registration_mobile_header.dart';
import '../widgets/institution_registration_sidebar.dart';
import '../widgets/institution_security_notice.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({
    super.key,
    this.email,
    this.onBack,
    this.onVerified,
    this.onChangeEmail,
  });

  final String? email;
  final VoidCallback? onBack;
  final VoidCallback? onVerified;
  final VoidCallback? onChangeEmail;

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _otpFocusNodes =
      List.generate(6, (_) => FocusNode());

  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _showPasswordCard = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();

    final registrationState =
        ref.read(institutionRegistrationProvider);

    _passwordController = TextEditingController(
      text: registrationState.password,
    );

    _confirmPasswordController =
        TextEditingController();

    _passwordController.addListener(_handlePasswordChanged);
    _confirmPasswordController
        .addListener(_handlePasswordChanged);
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }

    for (final node in _otpFocusNodes) {
      node.dispose();
    }

    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _handleOtpChanged(
    int index,
    String value,
  ) {
    if (value.length > 1) {
      final lastCharacter = value.characters.last;
      _otpControllers[index].text = lastCharacter;
      _otpControllers[index].selection =
          TextSelection.fromPosition(
        TextPosition(
          offset: _otpControllers[index].text.length,
        ),
      );
    }

    if (value.isNotEmpty && index < 5) {
      _otpFocusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }

    if (index == 5 && value.isNotEmpty) {
      _handleVerification();
    }
  }

  void _handleVerification() {
    final code = _otpControllers
        .map((controller) => controller.text)
        .join();

    if (code.length != 6) {
      return;
    }

    ref
        .read(institutionRegistrationProvider.notifier)
        .setEmailVerified(true);

    setState(() {
      _showPasswordCard = true;
    });
  }

  void _handlePasswordChanged() {
    final password = _passwordController.text;

    ref
        .read(institutionRegistrationProvider.notifier)
        .updatePassword(password);

    setState(() {});
  }

  bool get _hasMinimumLength =>
      _passwordController.text.length >= 8;

  bool get _hasUppercase =>
      RegExp(r'[A-Z]').hasMatch(
        _passwordController.text,
      );

  bool get _hasLowercase =>
      RegExp(r'[a-z]').hasMatch(
        _passwordController.text,
      );

  bool get _hasNumber =>
      RegExp(r'[0-9]').hasMatch(
        _passwordController.text,
      );

  bool get _passwordsMatch =>
      _passwordController.text.isNotEmpty &&
      _passwordController.text ==
          _confirmPasswordController.text;

  bool get _isPasswordValid =>
      _hasMinimumLength &&
      _hasUppercase &&
      _hasLowercase &&
      _hasNumber &&
      _passwordsMatch;

  void _handlePasswordContinue() {
    if (!_isPasswordValid) {
      return;
    }

    widget.onVerified?.call();
  }

  void _handleBack() {
    if (_showPasswordCard) {
      setState(() {
        _showPasswordCard = false;
      });
      return;
    }

    widget.onBack?.call();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 768;

    final registrationState =
        ref.watch(institutionRegistrationProvider);

    final verificationEmail =
        widget.email ??
        registrationState.administratorEmail;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(
            child: _InstitutionBackground(),
          ),

          SafeArea(
            child: Row(
              children: [
                if (isDesktop)
                  InstitutionRegistrationSidebar(
                    currentStep:
                        _showPasswordCard ? 3 : 3,
                  ),

                Expanded(
                  child: Column(
                    children: [
                      if (!isDesktop)
                        const InstitutionRegistrationMobileHeader(
                          currentStep: 3,
                        ),

                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop
                                  ? AppSpacing.lg
                                  : AppSpacing.md,
                              vertical: AppSpacing.lg,
                            ),
                            child: ConstrainedBox(
                              constraints:
                                  const BoxConstraints(
                                maxWidth: 700,
                              ),
                              child: AnimatedSwitcher(
                                duration:
                                    const Duration(
                                  milliseconds: 450,
                                ),
                                switchInCurve:
                                    Curves.easeOutCubic,
                                switchOutCurve:
                                    Curves.easeInCubic,
                                transitionBuilder:
                                    (
                                  child,
                                  animation,
                                ) {
                                  final isIncoming =
                                      child.key ==
                                          const ValueKey(
                                            'password',
                                          );

                                  final beginOffset =
                                      isIncoming
                                          ? const Offset(
                                              1,
                                              0,
                                            )
                                          : const Offset(
                                              -1,
                                              0,
                                            );

                                  return ClipRect(
                                    child:
                                        SlideTransition(
                                      position:
                                          Tween<Offset>(
                                        begin:
                                            beginOffset,
                                        end: Offset.zero,
                                      ).animate(
                                        animation,
                                      ),
                                      child:
                                          FadeTransition(
                                        opacity:
                                            animation,
                                        child: child,
                                      ),
                                    ),
                                  );
                                },
                                child: _showPasswordCard
                                    ? _CreatePasswordCard(
                                        key: const ValueKey(
                                          'password',
                                        ),
                                        passwordController:
                                            _passwordController,
                                        confirmPasswordController:
                                            _confirmPasswordController,
                                        obscurePassword:
                                            _obscurePassword,
                                        obscureConfirmPassword:
                                            _obscureConfirmPassword,
                                        onTogglePassword:
                                            () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                        onToggleConfirmPassword:
                                            () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                        hasMinimumLength:
                                            _hasMinimumLength,
                                        hasUppercase:
                                            _hasUppercase,
                                        hasLowercase:
                                            _hasLowercase,
                                        hasNumber:
                                            _hasNumber,
                                        passwordsMatch:
                                            _passwordsMatch,
                                        isPasswordValid:
                                            _isPasswordValid,
                                        onBack:
                                            _handleBack,
                                        onContinue:
                                            _handlePasswordContinue,
                                      )
                                    : _VerifyEmailCard(
                                        key: const ValueKey(
                                          'verification',
                                        ),
                                        email:
                                            verificationEmail,
                                        controllers:
                                            _otpControllers,
                                        focusNodes:
                                            _otpFocusNodes,
                                        onChanged:
                                            _handleOtpChanged,
                                        onBack:
                                            _handleBack,
                                        onChangeEmail:
                                            widget
                                                .onChangeEmail,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: AppSpacing.lg,
            right: AppSpacing.lg,
            child: InstitutionGlassCircleButton(
              icon: Icons.help_outline,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifyEmailCard extends StatelessWidget {
  const _VerifyEmailCard({
    super.key,
    required this.email,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.onBack,
    this.onChangeEmail,
  });

  final String email;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onChanged;
  final VoidCallback? onBack;
  final VoidCallback? onChangeEmail;

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        MediaQuery.sizeOf(context).width >= 768;

    return InstitutionGlassCard(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          const InstitutionRegistrationHeader(
            icon: Icons.mail_outline,
            title: 'Verify your email',
            subtitle:
                'Enter the verification code sent to your administrator email address.',
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          Center(
            child: GestureDetector(
              onTap: onChangeEmail,
              child: Text(
                email,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  decoration:
                      TextDecoration.underline,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          _OtpInput(
            controllers: controllers,
            focusNodes: focusNodes,
            onChanged: onChanged,
            isDesktop: isDesktop,
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style:
                    AppTextStyles.bodyMedium.copyWith(
                  color:
                      AppColors.onSurfaceVariant,
                ),
                children: [
                  const TextSpan(
                    text:
                        "Didn't receive the code? ",
                  ),
                  TextSpan(
                    text:
                        'Resend code in 00:45',
                    style:
                        AppTextStyles.labelMedium
                            .copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          const InstitutionSecurityNotice(
            message:
                'For your security, email verification is required before completing your institution setup.',
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          InstitutionRegistrationActions(
            onBack: onBack,
            onContinue: null,
          ),
        ],
      ),
    );
  }
}

class _CreatePasswordCard extends StatelessWidget {
  const _CreatePasswordCard({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.hasMinimumLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.passwordsMatch,
    required this.isPasswordValid,
    required this.onBack,
    required this.onContinue,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final bool obscurePassword;
  final bool obscureConfirmPassword;

  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;

  final bool hasMinimumLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool passwordsMatch;
  final bool isPasswordValid;

  final VoidCallback onBack;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return InstitutionGlassCard(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          const InstitutionRegistrationHeader(
            icon: Icons.lock_outline,
            title: 'Create your password',
            subtitle:
                'Create a secure password for your CourseMind administrator account.',
          ),

          const SizedBox(
            height: AppSpacing.xl,
          ),

          _PasswordField(
            label: 'Password',
            controller: passwordController,
            obscureText: obscurePassword,
            onToggleVisibility:
                onTogglePassword,
          ),

          const SizedBox(
            height: AppSpacing.md,
          ),

          _PasswordField(
            label: 'Confirm password',
            controller:
                confirmPasswordController,
            obscureText:
                obscureConfirmPassword,
            onToggleVisibility:
                onToggleConfirmPassword,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          Text(
            'Password requirements',
            style:
                AppTextStyles.labelMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          _PasswordRequirement(
            text: 'At least 8 characters',
            isSatisfied:
                hasMinimumLength,
          ),

          _PasswordRequirement(
            text: 'One uppercase letter',
            isSatisfied: hasUppercase,
          ),

          _PasswordRequirement(
            text: 'One lowercase letter',
            isSatisfied: hasLowercase,
          ),

          _PasswordRequirement(
            text: 'One number',
            isSatisfied: hasNumber,
          ),

          _PasswordRequirement(
            text: 'Passwords match',
            isSatisfied: passwordsMatch,
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          const InstitutionSecurityNotice(
            message:
                'Your password will be used to create your secure CourseMind administrator account.',
          ),

          const SizedBox(
            height: AppSpacing.lg,
          ),

          InstitutionRegistrationActions(
            onBack: onBack,
            onContinue:
                isPasswordValid
                    ? onContinue
                    : null,
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: onToggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMd,
          ),
        ),
      ),
    );
  }
}

class _PasswordRequirement
    extends StatelessWidget {
  const _PasswordRequirement({
    required this.text,
    required this.isSatisfied,
  });

  final String text;
  final bool isSatisfied;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
      ),
      child: Row(
        children: [
          Icon(
            isSatisfied
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            size: 18,
            color: isSatisfied
                ? AppColors.success
                : AppColors.onSurfaceVariant,
          ),
          const SizedBox(
            width: AppSpacing.sm,
          ),
          Text(
            text,
            style:
                AppTextStyles.bodySmall.copyWith(
              color: isSatisfied
                  ? AppColors.success
                  : AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  const _OtpInput({
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.isDesktop,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onChanged;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final fieldWidth =
        isDesktop ? 56.0 : 48.0;
    final fieldHeight =
        isDesktop ? 64.0 : 56.0;

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: SizedBox(
              width: fieldWidth,
              height: fieldHeight,
              child: TextField(
                controller:
                    controllers[index],
                focusNode:
                    focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType:
                    TextInputType.number,
                maxLength: 1,
                style: AppTextStyles
                    .headlineMedium
                    .copyWith(
                  color:
                      AppColors.onSurface,
                  fontWeight:
                      FontWeight.w600,
                ),
                decoration:
                    InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors
                      .surfaceContainerLowest,
                  contentPadding:
                      EdgeInsets.zero,
                  enabledBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      AppSpacing.radiusMd,
                    ),
                    borderSide:
                        const BorderSide(
                      color: AppColors
                          .outlineVariant,
                    ),
                  ),
                  focusedBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      AppSpacing.radiusMd,
                    ),
                    borderSide:
                        const BorderSide(
                      color:
                          AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  onChanged(
                    index,
                    value,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InstitutionBackground
    extends StatelessWidget {
  const _InstitutionBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/institution/background_image.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: AppColors.imageOverlay,
      ),
    );
  }
}