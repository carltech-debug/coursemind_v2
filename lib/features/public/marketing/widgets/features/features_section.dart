/*
==============================================================================
FILE: features_section.dart
MODULE: Marketing
COMPONENT: Core Features Section
==============================================================================
*/

import 'package:flutter/material.dart';

import 'features_grid.dart';
import 'features_header.dart';

final class FeaturesSection extends StatelessWidget {
  const FeaturesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 96,
      ),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: const Column(
            children: [
              FeaturesHeader(),
              SizedBox(height: 56),
              FeaturesGrid(),
            ],
          ),
        ),
      ),
    );
  }
}