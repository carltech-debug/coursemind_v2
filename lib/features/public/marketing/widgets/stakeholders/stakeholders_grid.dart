/*
==============================================================================
FILE: stakeholders_grid.dart
MODULE: Marketing
COMPONENT: Stakeholders Grid
==============================================================================
*/

import 'package:flutter/material.dart';

import 'stakeholder_card.dart';

final class StakeholdersGrid extends StatelessWidget {
  const StakeholdersGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    final stakeholders = [
      const StakeholderCard(
        icon: Icons.school_outlined,
        title: 'Students',
        description:
            'Access smarter learning tools, course materials, quizzes, and academic support in one place.',
      ),
      const StakeholderCard(
        icon: Icons.person_outline_rounded,
        title: 'Lecturers',
        description:
            'Share academic resources, support students, and participate in a connected digital learning environment.',
      ),
      const StakeholderCard(
        icon: Icons.account_balance_outlined,
        title: 'Institutions',
        description:
            'Provide students and lecturers with a centralized platform for modern academic engagement.',
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < stakeholders.length; index++) ...[
            Expanded(
              child: stakeholders[index],
            ),
            if (index < stakeholders.length - 1)
              const SizedBox(width: 24),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (var index = 0; index < stakeholders.length; index++) ...[
          stakeholders[index],
          if (index < stakeholders.length - 1)
            const SizedBox(height: 20),
        ],
      ],
    );
  }
}