/*
==============================================================================
FILE: hero_content.dart
MODULE: Public / Marketing
COMPONENT: Hero Content
==============================================================================
*/

import 'package:flutter/material.dart';

import 'hero_buttons.dart';

final class HeroContent extends StatelessWidget {
  const HeroContent({
    required this.title,
    required this.subtitle,
    this.onGetStarted,
    this.onLearnMore,
    super.key,
  });

  final String title;
  final String subtitle;

  final VoidCallback? onGetStarted;
  final VoidCallback? onLearnMore;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 1280,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 56,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.15,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 40),

                HeroButtons(
                  onGetStarted: onGetStarted,
                  onLearnMore: onLearnMore,
                ),
              ],
            ),
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}