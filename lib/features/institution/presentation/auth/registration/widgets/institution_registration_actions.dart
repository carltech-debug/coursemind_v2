import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../../../../../../../app/theme/app_text_styles.dart';

class InstitutionRegistrationActions
    extends StatelessWidget {
  const InstitutionRegistrationActions({
    super.key,
    this.onBack,
    this.onContinue,
  });

  final VoidCallback? onBack;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color:
                AppColors.outlineVariant
                    .withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: onBack,
            style: TextButton.styleFrom(
              backgroundColor:
                  AppColors.secondaryContainer,
              foregroundColor:
                  AppColors.onSurfaceVariant,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              shape:
                  const StadiumBorder(),
            ),
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
            ),
            label: Text(
              'Back',
              style:
                  AppTextStyles.labelMedium
                      .copyWith(
                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ),

          ElevatedButton(
            onPressed: onContinue,
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.primary,
              foregroundColor:
                  AppColors.onPrimary,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              elevation: 0,
              shape:
                  const StadiumBorder(),
            ),
            child: Row(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                Text(
                  'Continue',
                  style:
                      AppTextStyles.labelMedium
                          .copyWith(
                    color:
                        AppColors.onPrimary,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: AppSpacing.sm,
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}