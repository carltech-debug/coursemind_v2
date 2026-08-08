/*
==============================================================================
FILE: splash_provider.dart
MODULE: Splash
COMPONENT: Splash Provider
==============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/splash_state.dart';
import '../services/splash_service.dart';

final splashServiceProvider = Provider<SplashService>(
  (ref) => SplashService(),
);

final splashProvider =
    NotifierProvider<SplashNotifier, SplashState>(
  SplashNotifier.new,
);

final class SplashNotifier extends Notifier<SplashState> {
  late final SplashService _service;

  @override
  SplashState build() {
    _service = ref.read(splashServiceProvider);
    return SplashState.initial();
  }

  Future<void> initialize() async {
    state = await _service.initialize();
  }
}