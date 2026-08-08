/*
==============================================================================
FILE: mission_section.dart
MODULE: Marketing
COMPONENT: Mission Section
==============================================================================
*/

import 'package:flutter/material.dart';

import 'mission_header.dart';
import 'value_cards_grid.dart';

final class MissionSection extends StatelessWidget {
  const MissionSection({
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
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: const Column(
            children: [
              MissionHeader(),
              SizedBox(height: 56),
              ValueCardsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}