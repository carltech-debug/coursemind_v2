
import 'package:flutter/material.dart';

class AcademicCalendarCard extends StatefulWidget {
  const AcademicCalendarCard({super.key});

  @override
  State<AcademicCalendarCard> createState() =>
      _AcademicCalendarCardState();
}

class _AcademicCalendarCardState extends State<AcademicCalendarCard> {
  int? _expandedLevel = 300;

  static const List<int> _levels = [100, 200, 300, 400];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Color(0xFF3525CD),
                  size: 24,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Academic calendar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Configure semester terms for each level.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            for (final level in _levels) ...[
              _buildLevel(level),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLevel(int level) {
    final isExpanded = _expandedLevel == level;

    return Container(
      decoration: BoxDecoration(
        color: isExpanded
            ? const Color(0xFFF2F3FF)
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE2E7FF),
        ),
      ),
      child: Column(
        children: [
         Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              dense: true,
              leading: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down
                    : Icons.chevron_right,
                color: const Color(0xFF3525CD),
              ),
              title: Text(
                'Level $level',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text('Academic year 2026/2027'),
              trailing: Text(
                isExpanded ? 'Editing' : 'Semester 1',
                style: const TextStyle(fontSize: 12),
              ),
              onTap: () {
                setState(() {
                  _expandedLevel = isExpanded ? null : level;
                });
              },
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          'Academic year',
                          '2026/2027',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSemesterDropdown(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          'Semester start',
                          '15/01/2027',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildField(
                          'Semester end',
                          '30/05/2027',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildField(
                          'Exam start',
                          '10/05/2027',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildField(
                          'Exam end',
                          '26/05/2027',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          key: ValueKey('$label-$initialValue'),
          initialValue: initialValue,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSemesterDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current semester',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: 'Semester 2',
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'Semester 1',
              child: Text('Semester 1'),
            ),
            DropdownMenuItem(
              value: 'Semester 2',
              child: Text('Semester 2'),
            ),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }
}
