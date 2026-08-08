/*
==============================================================================
FILE: marketing_logo.dart
MODULE: Marketing
COMPONENT: Marketing Logo
==============================================================================
*/

import 'package:flutter/material.dart';

final class MarketingLogo extends StatelessWidget {
  const MarketingLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/splash/coursemind_logo.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 10),
        const Text(
          'CourseMind',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}