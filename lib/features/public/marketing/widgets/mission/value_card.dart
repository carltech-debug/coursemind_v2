/*
==============================================================================
FILE: value_card.dart
MODULE: Marketing
COMPONENT: Value Card
==============================================================================
*/

import 'package:flutter/material.dart';

final class ValueCard extends StatelessWidget {
  const ValueCard({
    required this.icon, required this.title, required this.description, super.key,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFC6C6CD),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.05),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color(0xFF4B41E1),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              color: Color(0xFF76777D),
            ),
          ),
        ],
      ),
    );
  }
}