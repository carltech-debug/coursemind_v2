/*
==============================================================================
FILE: splash_progress.dart
MODULE: Splash
COMPONENT: Splash Progress
==============================================================================
*/

import 'package:flutter/material.dart';

final class SplashProgress extends StatelessWidget {
  const SplashProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 280,
      child: Column(
        children: [
          Text(
            'INITIALIZING LEARNING CORE',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(),
        ],
      ),
    );
  }
}