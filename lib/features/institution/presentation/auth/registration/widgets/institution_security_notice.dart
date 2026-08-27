import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../../../../../../../app/theme/app_text_styles.dart';

class InstitutionSecurityNotice
    extends StatelessWidget {
  const InstitutionSecurityNotice({
    super.key,
    this.message =
        'Your institution information is securely stored and will be used to establish your official CourseMind institution account.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer
            .withValues(alpha: 0.7),
        borderRadius:
            BorderRadius.circular(
          AppSpacing.radiusMd,
        ),
        border: Border.all(
          color:
              AppColors.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.security,
            color: AppColors.primary,
            size: 28,
          ),
          const SizedBox(
            width: AppSpacing.md,
          ),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}