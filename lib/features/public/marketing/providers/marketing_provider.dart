/*
==============================================================================
FILE: marketing_provider.dart
MODULE: Marketing
COMPONENT: Marketing Provider
==============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/marketing_page.dart';
import '../services/marketing_service.dart';

final marketingServiceProvider = Provider<MarketingService>(
  (ref) => MarketingService(),
);

final marketingSlidesProvider = Provider<List<MarketingPage>>(
  (ref) => ref.read(marketingServiceProvider).getHeroSlides(),
);