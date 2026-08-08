/*
==============================================================================
FILE: marketing_nav_link.dart
MODULE: Marketing
COMPONENT: Marketing Navigation Link
==============================================================================
*/

import 'package:flutter/material.dart';

final class MarketingNavLink extends StatelessWidget {
  const MarketingNavLink({
    required this.title, super.key,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}