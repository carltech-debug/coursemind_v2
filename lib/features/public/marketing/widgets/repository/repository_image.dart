/*
==============================================================================
FILE: repository_image.dart
MODULE: Marketing
COMPONENT: Repository Image
==============================================================================
*/

import 'package:flutter/material.dart';

final class RepositoryImage extends StatelessWidget {
  const RepositoryImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/marketing/repository.png',
        width: double.infinity,
        height: 420,
        fit: BoxFit.cover,
      ),
    );
  }
}