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

RESPONSIVE BEHAVIOR
-------------------
Wide desktop:
    Three course cards displayed in one row.

Tablet:
    Course cards automatically wrap according to available width.

Narrow layouts:
    Course cards become single-column.

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

//=============================================================================
// MY COURSES SECTION
//=============================================================================

final class MyCoursesSection extends StatelessWidget {
  const MyCoursesSection({
    required this.onCourseSelected,
    super.key,
  });

  final ValueChanged<String> onCourseSelected;

  @override
  Widget build(BuildContext context) {
    final List<_CourseData> courses = [
      const _CourseData(
        courseId: 'course-1',
        courseName: 'Electromagnetic Fields',
        courseCode: 'ENG 201',
        progress: 0.32,
        imageAsset:
            'assets/images/student/dashboard/Electromagnetic_Fields_image.jpg',
      ),
      const _CourseData(
        courseId: 'course-2',
        courseName: 'Engineering Mathematics III',
        courseCode: 'MATH 205',
        progress: 0.68,
        imageAsset:
            'assets/images/student/dashboard/Engineering_Mathematics_III_MATH_205.jpg',
      ),
      const _CourseData(
        courseId: 'course-3',
        courseName: 'C++ Programming for Engineers',
        courseCode: 'CS 210',
        progress: 0.85,
        imageAsset:
            'assets/images/student/dashboard/C++_Programming_for_Engineers_CS_210.jpg',
      ),
    ];

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
        // RESPONSIVE COURSE GRID
        // ===================================================================

        LayoutBuilder(
          builder: (context, constraints) {
            final double availableWidth = constraints.maxWidth;

            final int columns = _calculateColumns(
              availableWidth,
            );

            const double spacing = AppSpacing.sm;

            final double cardWidth =
                (availableWidth - ((columns - 1) * spacing)) /
                    columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: courses.map(
                (course) {
                  return SizedBox(
                    width: cardWidth,
                    child: _CourseItem(
                      course: course,
                      onSelected: onCourseSelected,
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ],
    );
  }

  //===========================================================================
  // COLUMN CALCULATION
  //===========================================================================

  int _calculateColumns(
    double availableWidth,
  ) {
    if (availableWidth >= 1000) {
      return 3;
    }

    if (availableWidth >= 620) {
      return 2;
    }

    return 1;
  }
}

//=============================================================================
// COURSE ITEM
//=============================================================================

final class _CourseItem extends StatelessWidget {
  const _CourseItem({
    required this.course,
    required this.onSelected,
  });

  final _CourseData course;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return CourseCard(
      courseName: course.courseName,
      courseCode: course.courseCode,
      progress: course.progress,
      imageAsset: course.imageAsset,
      onPressed: () {
        onSelected(course.courseId);
      },
    );
  }
}

//=============================================================================
// COURSE DATA
//=============================================================================

final class _CourseData {
  const _CourseData({
    required this.courseId,
    required this.courseName,
    required this.courseCode,
    required this.progress,
    required this.imageAsset,
  });

  final String courseId;
  final String courseName;
  final String courseCode;
  final double progress;
  final String imageAsset;
}