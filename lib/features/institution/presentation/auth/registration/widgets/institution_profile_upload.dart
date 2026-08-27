import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../../app/theme/app_colors.dart';
import '../../../../../../app/theme/app_spacing.dart';
import '../../../../../../app/theme/app_text_styles.dart';

class InstitutionProfileUpload
    extends StatelessWidget {
  const InstitutionProfileUpload({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Image picker will be connected later.
          },
          child: CustomPaint(
            painter: _DashedCirclePainter(
              color: AppColors.primary.withValues(alpha: 0.5),
            ),
            child: Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                color:
                    AppColors.surfaceContainerLow,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.photo_camera_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Upload',
                    style:
                        AppTextStyles.labelSmall
                            .copyWith(
                      color:
                          AppColors.primary,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppSpacing.sm,
        ),
        Text(
          'Profile Photo\n(Optional)',
          textAlign: TextAlign.center,
          style:
              AppTextStyles.labelSmall.copyWith(
            color:
                AppColors.onSurfaceVariant,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _DashedCirclePainter
    extends CustomPainter {
  const _DashedCirclePainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(
      radius,
      radius,
    );

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final circumference =
        2 * math.pi * radius;

    final count =
        (circumference /
                (dashWidth + dashSpace))
            .floor();

    for (var i = 0; i < count; i++) {
      final startAngle =
          (i *
                  (dashWidth + dashSpace) /
                  circumference) *
              2 *
              math.pi;

      final sweepAngle =
          (dashWidth / circumference) *
              2 *
              math.pi;

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}