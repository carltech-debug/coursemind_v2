/*
==============================================================================
FILE: mission_header.dart
MODULE: Marketing
COMPONENT: Mission Header
==============================================================================
*/

import 'package:flutter/material.dart';

final class MissionHeader extends StatelessWidget {
  const MissionHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'OUR MISSION',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color(0xFF4B41E1),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Redefining the Academic Experience',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Color(0xFF191C1E),
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: const Text(
            'CourseMind is more than just a platform; it\'s an ecosystem designed to eliminate barriers in education. We provide the tools that enable excellence for every stakeholder in the learning journey.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              height: 1.6,
              color: Color(0xFF76777D),
            ),
          ),
        ),
      ],
    );
  }
}