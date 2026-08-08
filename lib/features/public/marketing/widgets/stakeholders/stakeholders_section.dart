/*
==============================================================================
FILE: stakeholders_section.dart
MODULE: Marketing
COMPONENT: Stakeholders Section
==============================================================================
*/

import 'package:flutter/material.dart';

import 'stakeholders_grid.dart';
import 'stakeholders_header.dart';

final class StakeholdersSection extends StatelessWidget {
  const StakeholdersSection({
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
              StakeholdersHeader(),
              SizedBox(height: 56),
              StakeholdersGrid(),
            ],
          ),
        ),
      ),
    );
  }
}