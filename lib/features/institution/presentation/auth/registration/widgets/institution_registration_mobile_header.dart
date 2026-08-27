import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../../../../../../../app/theme/app_text_styles.dart';

class InstitutionRegistrationMobileHeader extends StatelessWidget {
  const InstitutionRegistrationMobileHeader({
    required this.currentStep, super.key,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.glassSurface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.glassBorder,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _CourseMindBrand(),

              const Spacer(),
            ],
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          _InstitutionMobileProgress(
            currentStep: currentStep,
          ),
        ],
      ),
    );
  }
}

class _CourseMindBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/institution/coursemind_logo.png',
          width: 28,
          height: 28,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          width: AppSpacing.sm,
        ),
        Text(
          'CourseMind',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _InstitutionMobileProgress extends StatelessWidget {
  const _InstitutionMobileProgress({
    required this.currentStep,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 26,
      child: Row(
        children: List.generate(
          7,
          (index) {
            if (index.isOdd) {
              return Expanded(
                child: Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  color: AppColors.outlineVariant,
                ),
              );
            }

            final step = (index ~/ 2) + 1;

            final isCompleted = step < currentStep;
            final isActive = step == currentStep;

            return _ProgressCircle(
              step: step,
              isActive: isActive,
              isCompleted: isCompleted,
            );
          },
        ),
      ),
    );
  }
}

class _ProgressCircle extends StatelessWidget {
  const _ProgressCircle({
    required this.step,
    required this.isActive,
    required this.isCompleted,
  });

  final int step;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive || isCompleted
            ? AppColors.primary
            : AppColors.surfaceContainerLowest,
        border: isActive || isCompleted
            ? null
            : Border.all(
                color: AppColors.outlineVariant,
              ),
      ),
      child: isCompleted
          ? const Icon(
              Icons.check,
              size: 14,
              color: AppColors.onPrimary,
            )
          : Text(
              step.toString(),
              style: AppTextStyles.labelSmall.copyWith(
               color: isCompleted
                  ? AppColors.tertiary
                  : isActive
                      ? AppColors.primary
                      : AppColors.surfaceContainerLowest,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}