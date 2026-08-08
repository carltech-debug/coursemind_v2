/*
==============================================================================
FILE: splash_logo.dart
MODULE: Splash
COMPONENT: Splash Logo
==============================================================================
*/

import 'package:flutter/material.dart';

final class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Image.asset(
        'assets/images/splash/coursemind_logo.png',
      ),
    );
  }
}