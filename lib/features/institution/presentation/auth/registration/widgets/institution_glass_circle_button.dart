import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../../../app/theme/app_colors.dart';

class InstitutionGlassCircleButton extends StatelessWidget {
  const InstitutionGlassCircleButton({
    required this.icon, required this.onPressed, super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.glassBorder,
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              icon,
              color: AppColors.onSurface,
              size: 20,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}