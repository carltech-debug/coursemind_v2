import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../../../../../../../app/theme/app_text_styles.dart';

class InstitutionDropdownField<T>
    extends StatelessWidget {
  const InstitutionDropdownField({
    required this.label, required this.value, required this.hint, required this.prefixIcon, required this.items, required this.onChanged, super.key,
  });

  final String label;
  final T? value;
  final String hint;
  final IconData prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              AppTextStyles.labelMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

       DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.outline.withValues(
                alpha: 0.7,
              ),
            ),
          ),
          icon: const Icon(
            Icons.expand_more,
            color: AppColors.onSurfaceVariant,
          ),
          items: items,
          onChanged: onChanged,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurface,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.outline.withValues(
                alpha: 0.6,
              ),
              size: 20,
            ),
            filled: true,
            fillColor: AppColors.surfaceContainerLowest,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: AppSpacing.md,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMd,
              ),
              borderSide: BorderSide(
                color: AppColors.outlineVariant.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMd,
              ),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}