/*
==============================================================================
FILE: marketing_service.dart
MODULE: Marketing
COMPONENT: Marketing Service
==============================================================================
*/

import '../models/marketing_page.dart';

final class MarketingService {
  List<MarketingPage> getHeroSlides() {
    return const [
      MarketingPage(
        title: 'Unlock Your Academic Potential',
        subtitle:
            'Empowering students and institutions with next-generation learning tools.',
        imagePath: 'assets/images/marketing/hero_1.png',
      ),
      MarketingPage(
        title: 'Everything You Need for Every Course',
        subtitle:
            'Centralized resources, lecture notes, and study materials in one place.',
        imagePath: 'assets/images/marketing/hero_2.png',
      ),
      MarketingPage(
        title: 'Learn Smarter with Interactive Tools',
        subtitle:
            'AI-assisted study tutors, interactive quizzes, and personalized learning paths.',
        imagePath: 'assets/images/marketing/hero_3.png',
      ),
      MarketingPage(
        title: 'Stay Connected with Your Community',
        subtitle:
            'Real-time announcements, discussion hubs, and seamless collaboration.',
        imagePath: 'assets/images/marketing/hero_4.png',
      ),
      MarketingPage(
        title: 'Built for the Future of Education',
        subtitle:
            'A unified platform bridging the gap between teaching and learning.',
        imagePath: 'assets/images/marketing/hero_5.png',
      ),
    ];
  }
}