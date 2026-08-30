import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../app/theme/app_colors.dart';
import '../../../../../../app/theme/app_spacing.dart';
import '../../../../../../app/theme/app_text_styles.dart';

import '../providers/institution_registration_provider.dart';
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

class AdministratorDetailScreen extends ConsumerStatefulWidget {
  const AdministratorDetailScreen({
    super.key,
    this.onBack,
    this.onContinue,
  });

  final VoidCallback? onBack;
  final VoidCallback? onContinue;

  @override
  ConsumerState<AdministratorDetailScreen> createState() =>
      _AdministratorDetailScreenState();
}

class _AdministratorDetailScreenState
    extends ConsumerState<AdministratorDetailScreen> {
  late final TextEditingController _administratorNameController;
  late final TextEditingController _administratorEmailController;
  late final TextEditingController _administratorPhoneController;

  @override
  void initState() {
    super.initState();

    final registrationState =
        ref.read(institutionRegistrationProvider);

    _administratorNameController =
        TextEditingController(
      text: registrationState.administratorFullName,
    );

    _administratorEmailController =
        TextEditingController(
      text: registrationState.administratorEmail,
    );

    _administratorPhoneController =
        TextEditingController(
      text: registrationState.administratorPhone,
    );
  }

  @override
  void dispose() {
    _administratorNameController.dispose();
    _administratorEmailController.dispose();
    _administratorPhoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 768;

    final registrationState =
        ref.watch(institutionRegistrationProvider);

    final registrationNotifier =
        ref.read(
      institutionRegistrationProvider.notifier,
    );

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
                                    const InstitutionRegistrationHeader(
                                      icon:
                                          Icons.person_outline,
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

                                    InstitutionInputField(
                                      label: 'Full Name',
                                      placeholder:
                                          'e.g. Dr. Sarah Connor',
                                      prefixIcon:
                                          Icons.person_outline,
                                      controller:
                                          _administratorNameController,
                                      onChanged:
                                          registrationNotifier
                                              .updateAdministratorFullName,
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.md,
                                    ),

                                    _PositionAndEmailRow(
                                      selectedPosition:
                                          registrationState
                                              .administratorPosition,
                                      onPositionChanged:
                                          (value) {
                                        if (value == null) {
                                          return;
                                        }

                                        registrationNotifier
                                            .updateAdministratorPosition(
                                          value,
                                        );
                                      },
                                      emailController:
                                          _administratorEmailController,
                                      onEmailChanged:
                                          registrationNotifier
                                              .updateAdministratorEmail,
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.md,
                                    ),

                                    _PhoneNumberField(
                                      selectedCode:
                                          registrationState
                                              .administratorCountryCode,
                                      onCodeChanged:
                                          (value) {
                                        if (value == null) {
                                          return;
                                        }

                                        registrationNotifier
                                            .updateAdministratorCountryCode(
                                          value,
                                        );
                                      },
                                      phoneController:
                                          _administratorPhoneController,
                                      onPhoneChanged:
                                          registrationNotifier
                                              .updateAdministratorPhone,
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
                                            builder: (_) =>
                                                EmailVerificationScreen(
                                              onBack: () {
                                                Navigator.pop(
                                                  context,
                                                );
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
    required this.emailController,
    required this.onEmailChanged,
  });

  final String? selectedPosition;
  final ValueChanged<String?> onPositionChanged;
  final TextEditingController emailController;
  final ValueChanged<String>? onEmailChanged;

  @override
  Widget build(BuildContext context) {
    final isDesktop =
        MediaQuery.sizeOf(context).width >= 600;

    final position =
        InstitutionDropdownField<String>(
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

    final email = InstitutionInputField(
      label: 'Official Email',
      placeholder: 'admin@institution.edu',
      prefixIcon: Icons.mail_outline,
      keyboardType:
          TextInputType.emailAddress,
      controller: emailController,
      onChanged: onEmailChanged,
    );

    if (!isDesktop) {
      return Column(
        children: [
          position,
          const SizedBox(
            height: AppSpacing.md,
          ),
          email,
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(child: position),
        const SizedBox(
          width: AppSpacing.md,
        ),
        Expanded(child: email),
      ],
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField({
    required this.selectedCode,
    required this.onCodeChanged,
    required this.phoneController,
    required this.onPhoneChanged,
  });

  final String selectedCode;
  final ValueChanged<String?> onCodeChanged;
  final TextEditingController phoneController;
  final ValueChanged<String>? onPhoneChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style:
              AppTextStyles.labelMedium.copyWith(
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
                prefixIcon:
                    Icons.phone_outlined,
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
            Expanded(
              child: InstitutionInputField(
                label: '',
                placeholder: '244 123 456',
                prefixIcon:
                    Icons.phone_outlined,
                keyboardType:
                    TextInputType.phone,
                controller: phoneController,
                onChanged: onPhoneChanged,
              ),
            ),
          ],
        ),
      ],
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