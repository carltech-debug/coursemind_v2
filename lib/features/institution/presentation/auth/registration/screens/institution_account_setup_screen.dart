import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../providers/institution_registration_provider.dart';
import '../widgets/institution_account_form.dart';
import '../widgets/institution_glass_card.dart';
import '../widgets/institution_glass_circle_button.dart';
import '../widgets/institution_registration_actions.dart';
import '../widgets/institution_registration_header.dart';
import '../widgets/institution_registration_mobile_header.dart';
import '../widgets/institution_registration_sidebar.dart';
import '../widgets/institution_security_notice.dart';
import 'administrator_detail_screen.dart';

class InstitutionAccountSetupScreen
    extends ConsumerStatefulWidget {
  const InstitutionAccountSetupScreen({
    super.key,
    this.onBack,
    this.onContinue,
  });

  final VoidCallback? onBack;
  final VoidCallback? onContinue;

  @override
  ConsumerState<InstitutionAccountSetupScreen> createState() =>
      _InstitutionAccountSetupScreenState();
}

class _InstitutionAccountSetupScreenState
    extends ConsumerState<InstitutionAccountSetupScreen> {
  late final TextEditingController
      _institutionNameController;

  late final TextEditingController _websiteController;

  late final TextEditingController
      _officialEmailController;

  @override
  void initState() {
    super.initState();

    final registrationState =
        ref.read(institutionRegistrationProvider);

    _institutionNameController =
        TextEditingController(
      text: registrationState.institutionName,
    );

    _websiteController =
        TextEditingController(
      text: registrationState.website,
    );

    _officialEmailController =
        TextEditingController(
      text: registrationState.officialEmail,
    );
  }

  @override
  void dispose() {
    _institutionNameController.dispose();
    _websiteController.dispose();
    _officialEmailController.dispose();

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
                // Desktop registration sidebar.
                if (isDesktop)
                  const InstitutionRegistrationSidebar(
                    currentStep: 1,
                  ),

                Expanded(
                  child: Column(
                    children: [
                      // Tablet/mobile registration header.
                      if (!isDesktop)
                        const InstitutionRegistrationMobileHeader(
                          currentStep: 1,
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
                              child: InstitutionGlassCard(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .stretch,
                                  children: [
                                    // Tablet/mobile help button.
                                    if (!isDesktop)
                                      Align(
                                        alignment:
                                            Alignment.topRight,
                                        child:
                                            InstitutionGlassCircleButton(
                                          icon: Icons
                                              .help_outline,
                                          onPressed: () {
                                            // Help action will be
                                            // connected later.
                                          },
                                        ),
                                      ),

                                    if (!isDesktop)
                                      const SizedBox(
                                        height:
                                            AppSpacing.sm,
                                      ),

                                    // Screen header.
                                    const InstitutionRegistrationHeader(),

                                    const SizedBox(
                                      height:
                                          AppSpacing.xl,
                                    ),

                                    // Institution information form.
                                    InstitutionAccountForm(
                                      selectedInstitutionType:
                                          registrationState
                                              .institutionType,
                                      selectedCountry:
                                          registrationState
                                              .country,
                                      institutionNameController:
                                          _institutionNameController,
                                      websiteController:
                                          _websiteController,
                                      officialEmailController:
                                          _officialEmailController,

                                      onInstitutionNameChanged:
                                          registrationNotifier
                                              .updateInstitutionName,

                                      onInstitutionTypeChanged:
                                          (value) {
                                        if (value == null) {
                                          return;
                                        }

                                        registrationNotifier
                                            .updateInstitutionType(
                                          value,
                                        );
                                      },

                                      onCountryChanged:
                                          (value) {
                                        if (value == null) {
                                          return;
                                        }

                                        registrationNotifier
                                            .updateCountry(
                                          value,
                                        );
                                      },

                                      onWebsiteChanged:
                                          registrationNotifier
                                              .updateWebsite,

                                      onOfficialEmailChanged:
                                          registrationNotifier
                                              .updateOfficialEmail,
                                    ),

                                    const SizedBox(
                                      height:
                                          AppSpacing.lg,
                                    ),

                                    // Security notice.
                                    const InstitutionSecurityNotice(),

                                    const SizedBox(
                                      height:
                                          AppSpacing.lg,
                                    ),

                                    // Navigation actions.
                                    InstitutionRegistrationActions(
                                      onBack: widget.onBack,
                                      onContinue: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                AdministratorDetailScreen(
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

          // Desktop help button remains outside the card.
          if (isDesktop)
            Positioned(
              top: AppSpacing.lg,
              right: AppSpacing.lg,
              child: InstitutionGlassCircleButton(
                icon: Icons.help_outline,
                onPressed: () {
                  // Help action will be connected later.
                },
              ),
            ),
        ],
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