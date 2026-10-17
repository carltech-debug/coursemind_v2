import 'package:flutter/material.dart';

class AcademicSetupFeaturesCard extends StatelessWidget {
  const AcademicSetupFeaturesCard({super.key});

  static const Color _purple = Color(0xFF3525CD);
  static const Color _green = Color(0xFF006B53);
  static const Color _ink = Color(0xFF17213B);
  static const Color _lavender = Color(0xFFF0F1FF);

  static const List<String> _features = [
    'Calculate progress from calendar dates',
    'Organize programmes & multi-cohort levels',
    'Connect lecturers to assigned courses',
    'Track learning progress across faculties',
    'Generate real-time deanery insights',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EAF5)),
        boxShadow: [
          BoxShadow(
            color: _ink.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'COURSEMIND WILL HANDLE THE REST',
                  style: TextStyle(
                    color: _purple,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.55,
                  ),
                ),
              ),
              Container(
                width: 11,
                height: 11,
                decoration: const BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          for (var index = 0; index < _features.length; index++) ...[
            _buildFeature(_features[index]),
            if (index != _features.length - 1) const SizedBox(height: 17),
          ],

          const SizedBox(height: 30),

          // Role delegation information panel.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _lavender,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.badge_outlined, color: _purple, size: 23),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Role Delegation',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "You won't need to upload every course material "
                  'yourself. After setup, you can invite lecturers '
                  'and give them access to manage the courses they teach.',
                  style: TextStyle(
                    color: Color(0xFF34415D),
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.check_circle_outline, color: _green, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 15,
              height: 1.45,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
