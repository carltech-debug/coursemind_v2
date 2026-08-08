/*
==============================================================================
FILE: features_header.dart
MODULE: Marketing
COMPONENT: Features Header
==============================================================================
*/

import 'package:flutter/material.dart';

final class FeaturesHeader extends StatelessWidget {
  const FeaturesHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'CORE FEATURES',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color(0xFF4B41E1),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Everything You Need to Succeed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            height: 1.15,
            color: Color(0xFF191C1E),
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 760,
          ),
          child: const Text(
            'Powerful tools designed to make learning simpler, smarter, and more effective.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
              color: Color(0xFF76777D),
            ),
          ),
        ),
      ],
    );
  }
}