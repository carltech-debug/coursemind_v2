/*
==============================================================================
FILE: marketing_screen.dart
MODULE: Marketing
COMPONENT: Marketing Screen
==============================================================================
*/

import 'package:flutter/material.dart';

import '../widgets/community/community_section.dart';
import '../widgets/cta/cta_section.dart';
import '../widgets/features/features_section.dart';
import '../widgets/footer/marketing_footer.dart';
import '../widgets/hero/hero_carousel.dart';
import '../widgets/marketing_drawer.dart';
import '../widgets/marketing_navbar.dart';
import '../widgets/mission/mission_section.dart';
import '../widgets/repository/repository_section.dart';
import '../widgets/stakeholders/stakeholders_section.dart';

final class MarketingScreen extends StatelessWidget {
  const MarketingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: MarketingDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MarketingNavbar(),
            HeroCarousel(),
            MissionSection(),
            RepositorySection(),
            FeaturesSection(),
            CommunitySection(),
            StakeholdersSection(),
            CtaSection(),
            MarketingFooter(),
          ],
        ),
      ),
    );
  }
}