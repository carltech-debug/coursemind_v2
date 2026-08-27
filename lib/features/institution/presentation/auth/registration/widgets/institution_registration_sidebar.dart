import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../../../../../../../app/theme/app_text_styles.dart';

class InstitutionRegistrationSidebar
    extends StatelessWidget {
  const InstitutionRegistrationSidebar({
    required this.currentStep, super.key,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(AppSpacing.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCard
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusCard,
              ),
              border: Border.all(
                color: AppColors.glassBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/institution/coursemind_logo.png',
                      height: 32,
                    ),
                    const SizedBox(
                      width: AppSpacing.sm,
                    ),
                    Text(
                      'CourseMind',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: AppSpacing.lg,
                ),

                Text(
                  'Welcome to\nCourseMind',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.sm,
                ),

                Text(
                  "Let's set up your institution\nand get you started.",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),

                const SizedBox(
                  height: AppSpacing.lg,
                ),

                Column(
                  children: [
                    _RegistrationStep(
                      step: 1,
                      title: 'Institution',
                      isActive: currentStep == 1,
                      isCompleted: currentStep > 1,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    _RegistrationStep(
                      step: 2,
                      title: 'Administrator',
                      isActive: currentStep == 2,
                      isCompleted: currentStep > 2,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    _RegistrationStep(
                      step: 3,
                      title: 'Verification',
                      isActive: currentStep == 3,
                      isCompleted: currentStep > 3,
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    _RegistrationStep(
                      step: 4,
                      title: 'Setup',
                      isActive: currentStep == 4,
                      isCompleted: false,
                    ),
                  ],
                ),

                const Spacer(),

                const _SecurityCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegistrationStep extends StatelessWidget {
  const _RegistrationStep({
    required this.step,
    required this.title,
    required this.isActive,
    required this.isCompleted,
  });

  final int step;
  final String title;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSpacing.sm,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration:
          isActive
              ? BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(
                  AppSpacing.radiusMd,
                ),
                border: Border.all(
                  color: AppColors.glassBorder,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 4,
                  ),
                ],
              )
              : null,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: isActive
                  ? null
                  : Border.all(
                      color: AppColors.outlineVariant,
                    ),
            ),
            child: Text(
              step.toString(),
              style: AppTextStyles.labelSmall.copyWith(
                color: isActive
                    ? AppColors.onPrimary
                    : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            width: AppSpacing.md,
          ),
          Text(
            title,
            style: AppTextStyles.labelMedium.copyWith(
              color:
                  isActive
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant,
              fontWeight:
                  isActive
                      ? FontWeight.w600
                      : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLg,
        ),
        border: Border.all(
          color: AppColors.glassBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.verified_user,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(
                width: AppSpacing.sm,
              ),
              Text(
                'Your data is safe',
                style:
                    AppTextStyles.labelMedium.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          Text(
            'We use industry-standard security to protect '
            'your institution and personal information.',
            style:
                AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}