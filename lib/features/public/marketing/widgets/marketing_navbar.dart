/*
==============================================================================
FILE: marketing_navbar.dart
MODULE: Marketing
COMPONENT: Marketing Navigation Bar
==============================================================================
*/

import 'package:coursemind/features/auth/screens/login_screen.dart';
import 'package:coursemind/features/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'marketing_logo.dart';
import 'marketing_nav_link.dart';

final class MarketingNavbar extends StatelessWidget {
  const MarketingNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.90),
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        children: [
          const MarketingLogo(),

          const Spacer(),

          if (isDesktop) ...[
            const MarketingNavLink(title: 'Home'),
            const SizedBox(width: 24),
            const MarketingNavLink(title: 'Features'),
            const SizedBox(width: 24),
            const MarketingNavLink(title: 'Institutions'),
            const SizedBox(width: 24),
            const MarketingNavLink(title: 'Pricing'),
            const SizedBox(width: 24),
            const MarketingNavLink(title: 'Contact'),

            const Spacer(),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Sign In'),
            ),

            const SizedBox(width: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUpScreen(),
                  ),
                );
              },
              child: const Text('Get Started'),
            ),
          ] else
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}