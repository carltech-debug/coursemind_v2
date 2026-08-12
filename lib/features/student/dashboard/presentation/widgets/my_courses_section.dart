/*
==============================================================================
FILE: my_courses_section.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: My Courses Section
==============================================================================

DESCRIPTION
-----------
Displays the three most recently accessed courses by the student.

CURRENT PHASE
-------------
Presentation-only implementation.

The course entries below are temporary presentation data. The final
implementation will obtain the three most recently accessed courses from
student learning activity.

==============================================================================
*/

import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/app/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'course_card.dart';

final class MyCoursesSection extends StatelessWidget {
  const MyCoursesSection({
    required this.onCourseSelected, super.key,
  });

  final ValueChanged<String> onCourseSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ===================================================================
        // SECTION HEADER
        // ===================================================================

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Courses',
              style: AppTextStyles.headlineSmall,
            ),

            TextButton(
              onPressed: () {},
              child: const Text(
                'View All',
              ),
            ),
          ],
        ),

        const SizedBox(
          height: AppSpacing.md,
        ),

        // ===================================================================
        // RECENT COURSES
        // ===================================================================

        const _TemporaryCourseData(
          courseId: 'course-1',
          courseName: 'Electromagnetic Fields',
          courseCode: 'EEE 302',
          progress: 0.74,
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        const _TemporaryCourseData(
          courseId: 'course-2',
          courseName: 'Engineering Mathematics III',
          courseCode: 'MAT 302',
          progress: 0.61,
        ),

        const SizedBox(
          height: AppSpacing.sm,
        ),

        const _TemporaryCourseData(
          courseId: 'course-3',
          courseName: 'C++ Programming for Engineers',
          courseCode: 'CEN 304',
          progress: 0.43,
        ),
      ],
    );
  }
}

//=============================================================================
// TEMPORARY COURSE PRESENTATION DATA
//=============================================================================

final class _TemporaryCourseData extends StatelessWidget {
  const _TemporaryCourseData({
    required this.courseId,
    required this.courseName,
    required this.courseCode,
    required this.progress,
  });

  final String courseId;
  final String courseName;
  final String courseCode;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return CourseCard(
      courseName: courseName,
      courseCode: courseCode,
      progress: progress,
      onPressed: () {
        // Future flow:
        //
        // 1. Retrieve the student's last learning position.
        // 2. Open the learning recap.
        // 3. Display completed-section summaries.
        // 4. Present the recap quiz for the most recent section.
        // 5. Allow the student to revisit or continue.
        // 6. Resume the course at the correct position.
        //
        // Navigation will be connected when the learning-resume feature
        // is implemented.
        debugPrint('Selected course: $courseId');
      },
    );
  }
}