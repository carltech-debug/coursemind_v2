/*
==============================================================================
FILE: student_dashboard_screen.dart
MODULE: Student
FEATURE: Dashboard
LAYER: Presentation
COMPONENT: Student Dashboard Screen
==============================================================================

DESCRIPTION
-----------
Initial Student Dashboard destination.

This phase creates the dashboard screen and navigation destination only.
Dashboard functionality will be implemented in a later phase.
==============================================================================
*/

import 'package:flutter/material.dart';

//=============================================================================
// DESIGN TOKENS
//=============================================================================

final class StudentDashboardTheme {
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF4B41E1);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF45464D);
  static const Color outlineVariant = Color(0xFFC6C6CD);
}

//=============================================================================
// STUDENT DASHBOARD SCREEN
//=============================================================================

final class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          StudentDashboardTheme.background,
      appBar: AppBar(
        backgroundColor:
            StudentDashboardTheme.surface,
        elevation: 0,
        title: const Text(
          'CourseMind',
          style: TextStyle(
            color: StudentDashboardTheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color:
                  StudentDashboardTheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline,
              color:
                  StudentDashboardTheme.onSurface,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 1100,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  const Text(
                    'Welcome to CourseMind',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color:
                          StudentDashboardTheme
                              .onSurface,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Your personalized learning dashboard.',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          StudentDashboardTheme
                              .onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 32),

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color:
                          StudentDashboardTheme
                              .surface,
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                      border: Border.all(
                        color:
                            StudentDashboardTheme
                                .outlineVariant,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 48,
                          color:
                              StudentDashboardTheme
                                  .primary,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Student Dashboard',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                StudentDashboardTheme
                                    .onSurface,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Dashboard functionality will be added in the next development phase.',
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                StudentDashboardTheme
                                    .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}