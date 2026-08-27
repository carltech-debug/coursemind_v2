import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../widgets/institution_account_form.dart';
import '../widgets/institution_glass_card.dart';
import '../widgets/institution_glass_circle_button.dart';
import '../widgets/institution_registration_actions.dart';
import '../widgets/institution_registration_header.dart';
import '../widgets/institution_registration_mobile_header.dart';
import '../widgets/institution_registration_sidebar.dart';
import '../widgets/institution_security_notice.dart';
import 'administrator_detail_screen.dart';

class InstitutionAccountSetupScreen extends StatefulWidget {
  const InstitutionAccountSetupScreen({
    super.key,
    this.onBack,
    this.onContinue,
  });

  final VoidCallback? onBack;
  final VoidCallback? onContinue;

  @override
  State<InstitutionAccountSetupScreen> createState() =>
      _InstitutionAccountSetupScreenState();
}

class _InstitutionAccountSetupScreenState
    extends State<InstitutionAccountSetupScreen> {
  String? _selectedInstitutionType;
  String _selectedCountry = 'Ghana';

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
                              constraints: const BoxConstraints(
                                maxWidth: 700,
                              ),
                              child: InstitutionGlassCard(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Tablet/mobile help button.
                                    if (!isDesktop)
                                      Align(
                                        alignment: Alignment.topRight,
                                        child:
                                            InstitutionGlassCircleButton(
                                          icon: Icons.help_outline,
                                          onPressed: () {
                                            // Help action will be
                                            // connected later.
                                          },
                                        ),
                                      ),

                                    if (!isDesktop)
                                      const SizedBox(
                                        height: AppSpacing.sm,
                                      ),

                                    // Screen header.
                                    const InstitutionRegistrationHeader(),

                                    const SizedBox(
                                      height: AppSpacing.xl,
                                    ),

                                    // Institution information form.
                                    InstitutionAccountForm(
                                      selectedInstitutionType:
                                          _selectedInstitutionType,
                                      selectedCountry:
                                          _selectedCountry,
                                      onInstitutionTypeChanged: (value) {
                                        setState(() {
                                          _selectedInstitutionType =
                                              value;
                                        });
                                      },
                                      onCountryChanged: (value) {
                                        if (value == null) {
                                          return;
                                        }

                                        setState(() {
                                          _selectedCountry = value;
                                        });
                                      },
                                    ),

                                    const SizedBox(
                                      height: AppSpacing.lg,
                                    ),

                                    // Security notice.
                                    const InstitutionSecurityNotice(),

                                    const SizedBox(
                                      height: AppSpacing.lg,
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