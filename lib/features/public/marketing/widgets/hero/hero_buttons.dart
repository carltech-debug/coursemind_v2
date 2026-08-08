/*
==============================================================================
FILE: hero_buttons.dart
MODULE: Public / Marketing
COMPONENT: Hero Action Buttons
==============================================================================
*/

import 'package:flutter/material.dart';

final class HeroButtons extends StatelessWidget {
  const HeroButtons({
    this.onGetStarted,
    this.onLearnMore,
    super.key,
  });

  final VoidCallback? onGetStarted;
  final VoidCallback? onLearnMore;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        //=====================================================================
        // GET STARTED
        //=====================================================================

        ElevatedButton(
          onPressed: onGetStarted,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 16,
            ),
            shape: const StadiumBorder(),
            elevation: 4,
          ),
          child: const Text(
            'Get Started',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        //=====================================================================
        // LEARN MORE
        //=====================================================================

        OutlinedButton(
          onPressed: onLearnMore,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(
              color: Colors.white.withValues(
                alpha: 0.5,
              ),
              width: 2,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 16,
            ),
            shape: const StadiumBorder(),
          ),
          child: const Text(
            'Learn More',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}