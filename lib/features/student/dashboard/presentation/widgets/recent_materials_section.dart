/*
==============================================================================
FILE: recent_materials_section.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Recent Materials Section
==============================================================================

DESCRIPTION
-----------
Displays the student's recently accessed learning materials.

CURRENT PHASE
-------------
Presentation-only.

The displayed materials are temporary presentation data. The final version
will obtain the student's recently accessed materials from learning activity.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'material_tile.dart';

//=============================================================================
// RECENT MATERIALS SECTION
//=============================================================================

final class RecentMaterialsSection extends StatelessWidget {
  const RecentMaterialsSection({
    required this.onMaterialSelected, super.key,
  });

  final ValueChanged<String> onMaterialSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppSpacing.borderRadiusXl,
        border: Border.all(
          color: AppColors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================================
          // HEADER
          // ===================================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Materials',
                style: AppTextStyles.titleLarge,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          // ===================================================================
          // MATERIALS
          // ===================================================================

          MaterialTile(
            title: 'Tutorial 3: Mesh Analysis',
            subtitle: 'Circuit Theory I • PDF • 2.4 MB',
            icon: Icons.description_outlined,
            actionIcon: Icons.download_outlined,
            onPressed: () {
              onMaterialSelected('material-1');
            },
          ),

          const Divider(
            color: AppColors.outlineVariant,
          ),

          MaterialTile(
            title: 'Lecture Recording: Fourier Series',
            subtitle: 'Engineering Math III • MP4 • 1h 15m',
            icon: Icons.video_library_outlined,
            actionIcon: Icons.play_circle_outline,
            onPressed: () {
              onMaterialSelected('material-2');
            },
          ),

          const Divider(
            color: AppColors.outlineVariant,
          ),

          MaterialTile(
            title: 'Lab Quiz Preparatory Notes',
            subtitle: 'Electromagnetic Fields • DOCX • 450 KB',
            icon: Icons.description_outlined,
            actionIcon: Icons.download_outlined,
            onPressed: () {
              onMaterialSelected('material-3');
            },
          ),
        ],
      ),
    );
  }
}