/*
==============================================================================
FILE: hero_indicators.dart
MODULE: Public / Marketing
COMPONENT: Hero Slide Indicators
==============================================================================
*/

import 'package:flutter/material.dart';

final class HeroIndicators extends StatelessWidget {
  const HeroIndicators({
    required this.itemCount,
    required this.currentIndex,
    super.key,
  });

  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final isActive = currentIndex == index;

          return AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF4B41E1)
                  : Colors.white54,
              borderRadius:
                  BorderRadius.circular(4),
            ),
          );
        },
      ),
    );
  }
}