import 'package:flutter/material.dart';

import '../../../../../../app/theme/app_colors.dart';
import '../../../../../../app/theme/app_spacing.dart';
import '../../../../../../app/theme/app_text_styles.dart';

import '../widgets/institution_glass_card.dart';
import '../widgets/institution_glass_circle_button.dart';
import '../widgets/institution_registration_actions.dart';
import '../widgets/institution_registration_header.dart';
import '../widgets/institution_registration_mobile_header.dart';
import '../widgets/institution_registration_sidebar.dart';
import '../widgets/institution_security_notice.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({
    super.key,
    this.email = 'administrator@institution.edu',
    this.onBack,
    this.onVerified,
    this.onChangeEmail,
  });

  final String email;
  final VoidCallback? onBack;
  final VoidCallback? onVerified;
  final VoidCallback? onChangeEmail;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<EmailVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
      List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _handleOtpChanged(
    int index,
    String value,
  ) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _handleVerification() {
    final code = _controllers
        .map((controller) => controller.text)
        .join();

    if (code.length != 6) {
      return;
    }

    widget.onVerified?.call();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 768;

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
                  const InstitutionRegistrationSidebar(
                    currentStep: 3,
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
                              constraints: const BoxConstraints(
                                maxWidth: 700,
                              ),
                              child: InstitutionGlassCard(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    InstitutionRegistrationHeader(
                                      icon: Icons.mail_outline,
                                      title: 'Verify your email',
                                      subtitle:
                                          'We sent a verification code to ${widget.email}.',
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.sm,
                                    ),

                                    Center(
                                      child: GestureDetector(
                                        onTap: widget.onChangeEmail,
                                        child: Text(
                                          'Change email',
                                          style: AppTextStyles.labelMedium
                                              .copyWith(
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
                                      controllers: _controllers,
                                      focusNodes: _focusNodes,
                                      onChanged: _handleOtpChanged,
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.xl,
                                    ),

                                    Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: AppTextStyles.bodyMedium
                                              .copyWith(
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
                                              style: AppTextStyles
                                                  .labelMedium
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
                                      onBack: widget.onBack,
                                      onContinue:
                                          _handleVerification,
                                    ),
                                  ],
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

class _OtpInput extends StatelessWidget {
  const _OtpInput({
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onChanged;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 768;

    final fieldWidth = isDesktop ? 56.0 : 48.0;
    final fieldHeight = isDesktop ? 64.0 : 56.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: SizedBox(
              width: fieldWidth,
              height: fieldHeight,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.surfaceContainerLowest,
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMd,
                    ),
                    borderSide: const BorderSide(
                      color: AppColors.outlineVariant,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMd,
                    ),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  onChanged(index, value);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InstitutionBackground extends StatelessWidget {
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