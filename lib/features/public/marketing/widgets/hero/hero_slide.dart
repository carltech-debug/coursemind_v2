/*
==============================================================================
FILE: hero_slide.dart
MODULE: Public / Marketing
COMPONENT: Hero Slide
==============================================================================
*/

import 'package:flutter/material.dart';

import '../../models/marketing_page.dart';
import 'hero_content.dart';

final class HeroSlide extends StatelessWidget {
  const HeroSlide({
    required this.slide,
    this.onGetStarted,
    this.onLearnMore,
    super.key,
  });

  final MarketingPage slide;

  final VoidCallback? onGetStarted;
  final VoidCallback? onLearnMore;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //=====================================================================
        // BACKGROUND IMAGE
        //=====================================================================

        Image.asset(
          slide.imagePath,
          fit: BoxFit.cover,
        ),

        //=====================================================================
        // DARK GRADIENT OVERLAY
        //=====================================================================

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black.withValues(alpha: 0.75),
                Colors.black.withValues(alpha: 0.35),
                Colors.transparent,
              ],
            ),
          ),
        ),

        //=====================================================================
        // HERO CONTENT
        //=====================================================================

        HeroContent(
          title: slide.title,
          subtitle: slide.subtitle,
          onGetStarted: onGetStarted,
          onLearnMore: onLearnMore,
        ),
      ],
    );
  }
}