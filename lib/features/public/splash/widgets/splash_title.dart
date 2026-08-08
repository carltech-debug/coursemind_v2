/*
==============================================================================
FILE: splash_title.dart
MODULE: Splash
COMPONENT: Splash Title
==============================================================================
*/

import 'package:flutter/material.dart';

final class SplashTitle extends StatelessWidget {
  const SplashTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'CourseMind',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Learn Smarter. Study Better.',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}