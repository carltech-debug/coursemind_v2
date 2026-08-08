/*
==============================================================================
FILE: features_grid.dart
MODULE: Marketing
COMPONENT: Features Grid
==============================================================================
*/

import 'package:flutter/material.dart';

import 'feature_card.dart';

final class FeaturesGrid extends StatelessWidget {
  const FeaturesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    final features = [
      const FeatureCard(
        icon: Icons.auto_awesome_rounded,
        title: 'AI Tutor',
        description:
            'Get personalized explanations and academic support whenever you need it.',
      ),
      const FeatureCard(
        icon: Icons.quiz_outlined,
        title: 'Interactive Quizzes',
        description:
            'Test your understanding with engaging quizzes that help reinforce what you learn.',
      ),
      const FeatureCard(
        icon: Icons.dashboard_outlined,
        title: 'Smart Dashboard',
        description:
            'Track your courses, learning activity, and academic progress from one place.',
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < features.length; index++) ...[
            Expanded(
              child: features[index],
            ),
            if (index < features.length - 1)
              const SizedBox(width: 24),
          ],
        ],
      );
    }

    return Column(
      children: [
        for (var index = 0; index < features.length; index++) ...[
          features[index],
          if (index < features.length - 1)
            const SizedBox(height: 20),
        ],
      ],
    );
  }
}