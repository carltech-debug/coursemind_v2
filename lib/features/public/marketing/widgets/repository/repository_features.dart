/*
==============================================================================
FILE: repository_features.dart
MODULE: Marketing
COMPONENT: Repository Features
==============================================================================
*/

import 'package:flutter/material.dart';

final class RepositoryFeatures extends StatelessWidget {
  const RepositoryFeatures({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RepositoryFeature(
          icon: Icons.folder_open_rounded,
          title: 'Organized Course Materials',
        ),
        SizedBox(height: 20),
        _RepositoryFeature(
          icon: Icons.search_rounded,
          title: 'Quick Access to Resources',
        ),
        SizedBox(height: 20),
        _RepositoryFeature(
          icon: Icons.devices_rounded,
          title: 'Access Across Your Devices',
        ),
      ],
    );
  }
}

final class _RepositoryFeature extends StatelessWidget {
  const _RepositoryFeature({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEDEBFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 22,
            color: Color(0xFF4B41E1),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1E),
            ),
          ),
        ),
      ],
    );
  }
}