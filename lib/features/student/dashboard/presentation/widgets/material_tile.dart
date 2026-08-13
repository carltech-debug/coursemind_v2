// ignore_for_file: always_put_required_named_parameters_first

/*
==============================================================================
FILE: material_tile.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Material Tile
==============================================================================

DESCRIPTION
-----------
Displays a recently accessed course material using the Stitch dashboard
visual language.

The trailing action icon can represent the material's available action,
such as download or play.
==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

final class MaterialTile extends StatelessWidget {
  const MaterialTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
    this.actionIcon = Icons.chevron_right,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final IconData actionIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              //================================================================
              // MATERIAL ICON
              //================================================================

              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 21,
                ),
              ),

              const SizedBox(
                width: AppSpacing.md,
              ),

              //================================================================
              // MATERIAL INFORMATION
              //================================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(
                      height: AppSpacing.xs,
                    ),

                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: AppSpacing.sm,
              ),

              //================================================================
              // MATERIAL ACTION
              //================================================================

              Icon(
                actionIcon,
                color: AppColors.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}