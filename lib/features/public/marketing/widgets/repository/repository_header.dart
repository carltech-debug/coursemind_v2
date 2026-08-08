/*
==============================================================================
FILE: repository_header.dart
MODULE: Marketing
COMPONENT: Repository Header
==============================================================================
*/

import 'package:flutter/material.dart';

final class RepositoryHeader extends StatelessWidget {
  const RepositoryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SMART REPOSITORY',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Color(0xFF4B41E1),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'All Your Course Materials, In One Place',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            height: 1.15,
            color: Color(0xFF191C1E),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Access organized course materials and academic resources whenever you need them.',
          style: TextStyle(
            fontSize: 18,
            height: 1.5,
            color: Color(0xFF76777D),
          ),
        ),
      ],
    );
  }
}