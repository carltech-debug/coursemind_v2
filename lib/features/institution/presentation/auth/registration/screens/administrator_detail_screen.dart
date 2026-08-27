import 'package:flutter/material.dart';

import '../../../../../../app/theme/app_colors.dart';
import '../../../../../../app/theme/app_spacing.dart';
import '../../../../../../app/theme/app_text_styles.dart';

import '../widgets/institution_dropdown_field.dart';
import '../widgets/institution_glass_card.dart';
import '../widgets/institution_glass_circle_button.dart';
import '../widgets/institution_input_field.dart';
import '../widgets/institution_profile_upload.dart';
import '../widgets/institution_registration_actions.dart';
import '../widgets/institution_registration_header.dart';
import '../widgets/institution_registration_mobile_header.dart';
import '../widgets/institution_registration_sidebar.dart';
import '../widgets/institution_security_notice.dart';
import 'email_verification_screen.dart';

class AdministratorDetailScreen extends StatefulWidget {
  const AdministratorDetailScreen({
    super.key,
    this.onBack,
    this.onContinue,
  });

  final VoidCallback? onBack;
  final VoidCallback? onContinue;

  @override
  State<AdministratorDetailScreen> createState() =>
      _AdministratorDetailScreenState();
}

class _AdministratorDetailScreenState
    extends State<AdministratorDetailScreen> {
  String? _selectedPosition;
  String _selectedCountryCode = '+233';

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
                    currentStep: 2,
                  ),

                Expanded(
                  child: Column(
                    children: [
                      if (!isDesktop)
                        const InstitutionRegistrationMobileHeader(
                          currentStep: 2,
                        ),

                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  isDesktop
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
                                    const InstitutionRegistrationHeader(
                                      icon: Icons.person_outline,
                                      title:
                                          'Tell us about the administrator',
                                      subtitle:
                                          'Add the person responsible for managing your institution\'s CourseMind account.',
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.xl,
                                    ),

                                    const InstitutionProfileUpload(),

                                    const SizedBox(
                                      height: AppSpacing.xl,
                                    ),

                                    const InstitutionInputField(
                                      label: 'Full Name',
                                      placeholder:
                                          'e.g. Dr. Sarah Connor',
                                      prefixIcon:
                                          Icons.person_outline,
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.md,
                                    ),

                                    _PositionAndEmailRow(
                                      selectedPosition:
                                          _selectedPosition,
                                      onPositionChanged:
                                          (value) {
                                        setState(() {
                                          _selectedPosition =
                                              value;
                                        });
                                      },
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.md,
                                    ),

                                    _PhoneNumberField(
                                      selectedCode:
                                          _selectedCountryCode,
                                      onCodeChanged:
                                          (value) {
                                        if (value == null) {
                                          return;
                                        }

                                        setState(() {
                                          _selectedCountryCode =
                                              value;
                                        });
                                      },
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.lg,
                                    ),

                                    const InstitutionSecurityNotice(
                                      message:
                                          'Next, we\'ll verify this email address to ensure secure access to your institution\'s portal.',
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.lg,
                                    ),

                                   InstitutionRegistrationActions(
                                      onBack: widget.onBack,
                                      onContinue: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => EmailVerificationScreen(
                                              onBack: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        );
                                      },
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

class _PositionAndEmailRow extends StatelessWidget {
  const _PositionAndEmailRow({
    required this.selectedPosition,
    required this.onPositionChanged,
  });

  final String? selectedPosition;
  final ValueChanged<String?> onPositionChanged;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 600;

    final position = InstitutionDropdownField<String>(
      label: 'Position',
      value: selectedPosition,
      hint: 'Select position',
      prefixIcon: Icons.badge_outlined,
      items: const [
        DropdownMenuItem(
          value: 'dean',
          child: Text('Dean'),
        ),
        DropdownMenuItem(
          value: 'registrar',
          child: Text('Registrar'),
        ),
        DropdownMenuItem(
          value: 'it_director',
          child: Text('IT Director'),
        ),
        DropdownMenuItem(
          value: 'other',
          child: Text('Other'),
        ),
      ],
      onChanged: onPositionChanged,
    );

    const email = InstitutionInputField(
      label: 'Official Email',
      placeholder: 'admin@institution.edu',
      prefixIcon: Icons.mail_outline,
      keyboardType: TextInputType.emailAddress,
    );

    if (!isDesktop) {
      return Column(
        children: [
          position,
          const SizedBox(height: AppSpacing.md),
          email,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: position),
        const SizedBox(width: AppSpacing.md),
        const Expanded(child: email),
      ],
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField({
    required this.selectedCode,
    required this.onCodeChanged,
  });

  final String selectedCode;
  final ValueChanged<String?> onCodeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: AppSpacing.sm,
        ),
        Row(
          children: [
            SizedBox(
              width: 150,
              child:
                  InstitutionDropdownField<String>(
                label: '',
                value: selectedCode,
                hint: '+233',
                prefixIcon: Icons.phone_outlined,
                items: const [
                  DropdownMenuItem(
                    value: '+233',
                    child: Text('+233 (GH)'),
                  ),
                  DropdownMenuItem(
                    value: '+1',
                    child: Text('+1 (US)'),
                  ),
                  DropdownMenuItem(
                    value: '+44',
                    child: Text('+44 (UK)'),
                  ),
                ],
                onChanged: onCodeChanged,
              ),
            ),
            const SizedBox(
              width: AppSpacing.sm,
            ),
            const Expanded(
              child: InstitutionInputField(
                label: '',
                placeholder: '244 123 456',
                prefixIcon:
                    Icons.phone_outlined,
                keyboardType:
                    TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
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