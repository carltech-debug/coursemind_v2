/*
==============================================================================
FILE: repository_section.dart
MODULE: Marketing
COMPONENT: Smart Repository Section
==============================================================================
*/

import 'package:flutter/material.dart';

import 'repository_features.dart';
import 'repository_header.dart';
import 'repository_image.dart';

final class RepositorySection extends StatelessWidget {
  const RepositorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 96,
      ),
      color: const Color(0xFFF7F9FB),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ),
          child: isDesktop
              ? const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RepositoryHeader(),
                          SizedBox(height: 36),
                          RepositoryFeatures(),
                        ],
                      ),
                    ),
                    SizedBox(width: 64),
                    Expanded(
                      child: RepositoryImage(),
                    ),
                  ],
                )
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RepositoryHeader(),
                    SizedBox(height: 36),
                    RepositoryFeatures(),
                    SizedBox(height: 40),
                    RepositoryImage(),
                  ],
                ),
        ),
      ),
    );
  }
}