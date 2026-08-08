/*
==============================================================================
FILE: stakeholders_header.dart
MODULE: Marketing
COMPONENT: Stakeholders Header
==============================================================================
*/

import 'package:flutter/material.dart';

final class StakeholdersHeader extends StatelessWidget {
  const StakeholdersHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'BUILT FOR EVERYONE',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color(0xFF4B41E1),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'One Platform. Every Stakeholder.',
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
            'CourseMind brings students, lecturers, and institutions together in one connected academic ecosystem.',
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