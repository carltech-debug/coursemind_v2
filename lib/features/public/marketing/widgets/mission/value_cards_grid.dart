/*
==============================================================================
FILE: value_cards_grid.dart
MODULE: Marketing
COMPONENT: Value Cards Grid
==============================================================================
*/

import 'package:flutter/material.dart';

import 'value_card.dart';

final class ValueCardsGrid extends StatelessWidget {
  const ValueCardsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    final cards = [
      const ValueCard(
        icon: Icons.trending_up_rounded,
        title: 'Fast-Track Success',
        description:
            'Access the right resources and tools to achieve your academic goals faster.',
      ),
      const ValueCard(
        icon: Icons.lightbulb_outline_rounded,
        title: 'Pedagogical Innovation',
        description:
            'Experience modern learning methods designed to make education more effective.',
      ),
      const ValueCard(
        icon: Icons.hub_outlined,
        title: 'Unified Ecosystem',
        description:
            'Connect students, lecturers, and institutions in one academic environment.',
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < cards.length; index++) ...[
            Expanded(
              child: cards[index],
            ),
            if (index < cards.length - 1)
              const SizedBox(width: 24),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (var index = 0; index < cards.length; index++) ...[
          cards[index],
          if (index < cards.length - 1)
            const SizedBox(height: 16),
        ],
      ],
    );
  }
}