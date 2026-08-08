/*
==============================================================================
FILE: splash_screen.dart
MODULE: Splash
COMPONENT: Splash Screen
==============================================================================
*/


import 'package:coursemind/features/public/marketing/screens/marketing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/splash_provider.dart';
import '../widgets/splash_animation.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_progress.dart';
import '../widgets/splash_title.dart';
final class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  ConsumerState<SplashScreen> createState() =>
      _SplashScreenState();
}

final class _SplashScreenState
    extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await ref.read(splashProvider.notifier).initialize();

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MarketingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
  child: Stack(
    children: [
      Positioned.fill(
        child: Opacity(
          opacity: 0.08,
          child: Image.asset(
            'assets/images/splash/splash_background.png',
            fit: BoxFit.cover,
          ),
        ),
      ),

      const Center(
        child: SplashAnimation(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SplashLogo(),
              SizedBox(height: 24),
              SplashTitle(),
            ],
          ),
        ),
      ),

      const Positioned(
        left: 0,
        right: 0,
        bottom: 64,
        child: Center(
          child: SplashProgress(),
        ),
      ),

      const Positioned(
        left: 0,
        right: 0,
        bottom: 16,
        child: Center(
          child: Opacity(
            opacity: 0.5,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  size: 14,
                ),
                SizedBox(width: 8),
                Text(
                  'SECURED BY COURSEMIND',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
      ),
    );
  }
}