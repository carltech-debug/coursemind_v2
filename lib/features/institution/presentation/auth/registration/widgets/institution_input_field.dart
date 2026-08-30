import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';
import '../../../../../../../app/theme/app_spacing.dart';
import '../../../../../../../app/theme/app_text_styles.dart';

class InstitutionInputField
    extends StatelessWidget {
  const InstitutionInputField({
    required this.label, required this.placeholder, required this.prefixIcon, super.key,
    this.helperText,
    this.controller,
    this.onChanged,
    this.keyboardType =
        TextInputType.text,
  });

  final String label;
  final String placeholder;
  final IconData prefixIcon;
  final String? helperText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

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

        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style:
              AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurface,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle:
                AppTextStyles.bodyMedium.copyWith(
              color:
                  AppColors.outline.withValues(
                alpha: 0.5,
              ),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color:
                  AppColors.outline.withValues(
                alpha: 0.6,
              ),
              size: 20,
            ),
            filled: true,
            fillColor:
                AppColors.surfaceContainerLowest,
            contentPadding:
                const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: AppSpacing.md,
            ),
            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMd,
              ),
              borderSide: BorderSide(
                color:
                    AppColors.outlineVariant
                        .withValues(alpha: 0.7),
              ),
            ),
            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                AppSpacing.radiusMd,
              ),
              borderSide:
                  const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),

        if (helperText != null) ...[
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color:
                    AppColors.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  helperText!,
                  style:
                      AppTextStyles.labelSmall
                          .copyWith(
                    color:
                        AppColors
                            .onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}