/*
==============================================================================
FILE: community_section.dart
MODULE: Marketing
COMPONENT: Community Section
==============================================================================
*/

import 'package:flutter/material.dart';

import 'community_grid.dart';
import 'community_header.dart';

final class CommunitySection extends StatelessWidget {
  const CommunitySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 96,
      ),
      color: const Color(0xFFF7F9FB),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: const Column(
            children: [
              CommunityHeader(),
              SizedBox(height: 56),
              CommunityGrid(),
            ],
          ),
        ),
      ),
    );
  }
}