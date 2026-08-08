/*
==============================================================================
FILE: community_header.dart
MODULE: Marketing
COMPONENT: Community Header
==============================================================================
*/

import 'package:flutter/material.dart';

final class CommunityHeader extends StatelessWidget {
  const CommunityHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'COMMUNITY',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color(0xFF4B41E1),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Learn Together. Grow Together.',
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
            'Stay connected with your academic community through announcements, discussions, and shared learning experiences.',
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