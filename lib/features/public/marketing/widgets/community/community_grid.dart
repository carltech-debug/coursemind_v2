/*
==============================================================================
FILE: community_grid.dart
MODULE: Marketing
COMPONENT: Community Grid
==============================================================================
*/

import 'package:flutter/material.dart';

import 'community_card.dart';

final class CommunityGrid extends StatelessWidget {
  const CommunityGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    final cards = [
      const CommunityCard(
        icon: Icons.campaign_outlined,
        title: 'Announcements',
        description:
            'Stay informed with important academic announcements and updates from your institution.',
      ),
      const CommunityCard(
        icon: Icons.forum_outlined,
        title: 'Discussion Hubs',
        description:
            'Connect with fellow students, share ideas, ask questions, and learn together.',
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
            const SizedBox(height: 20),
        ],
      ],
    );
  }
}