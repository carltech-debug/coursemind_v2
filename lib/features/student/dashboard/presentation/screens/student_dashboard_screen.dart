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
Root screen for the Student Dashboard.

RESPONSIBILITIES
----------------
• Obtain the authenticated student's profile.
• Load the profile through the existing ProfileController.
• Provide responsive desktop and tablet dashboard navigation.
• Compose the dashboard presentation widgets.

RESPONSIVE BEHAVIOR
-------------------
Desktop:
    Uses the existing left DashboardSidebar.

Tablet / smaller layouts:
    Removes the sidebar and uses DashboardNavigation at the top.

DATA STATUS
-----------
Profile information:
    Connected to the existing Firestore profile architecture.

Dashboard learning data:
    Presentation placeholders at this stage.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/academic_health_card.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/ai_tutor_card.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/continue_learning_card.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/dashboard_greeting.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/dashboard_navigation.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/dashboard_sidebar.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/my_courses_section.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/recent_materials_section.dart';
import 'package:coursemind/features/student/profile/domain/entities/user_profile.dart';
import 'package:coursemind/features/student/profile/presentation/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//=============================================================================
// RESPONSIVE BREAKPOINT
//=============================================================================

const double _desktopBreakpoint = 1100;

//=============================================================================
// STUDENT DASHBOARD SCREEN
//=============================================================================

final class StudentDashboardScreen extends ConsumerStatefulWidget {
  const StudentDashboardScreen({
    super.key,
  });

  @override
  ConsumerState<StudentDashboardScreen> createState() =>
      _StudentDashboardScreenState();
}

//=============================================================================
// STUDENT DASHBOARD STATE
//=============================================================================

final class _StudentDashboardScreenState
    extends ConsumerState<StudentDashboardScreen> {
  int _activeNavigationIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(_loadStudentProfile);
  }

  //===========================================================================
  // LOAD STUDENT PROFILE
  //===========================================================================

  Future<void> _loadStudentProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    await ref
        .read(profileControllerProvider.notifier)
        .loadProfile(user.uid);
  }

  //===========================================================================
  // BUILD
  //===========================================================================

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: profileState.when(
          loading: _buildLoadingState,
          error: _buildErrorState,
          data: (profile) {
            if (profile == null) {
              return _buildProfileUnavailableState();
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final bool isDesktop =
                    constraints.maxWidth >= _desktopBreakpoint;

                return _buildDashboard(
                  profile,
                  isDesktop: isDesktop,
                );
              },
            );
          },
        ),
      ),
    );
  }

  //===========================================================================
  // DASHBOARD
  //===========================================================================

  Widget _buildDashboard(
    UserProfile profile, {
    required bool isDesktop,
  }) {
    if (isDesktop) {
      return _buildDesktopDashboard(profile);
    }

    return _buildTabletDashboard(profile);
  }

  //===========================================================================
  // DESKTOP DASHBOARD
  //===========================================================================

  Widget _buildDesktopDashboard(UserProfile profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // =====================================================================
        // DESKTOP SIDEBAR
        // =====================================================================

        DashboardSidebar(
          activeIndex: _activeNavigationIndex,
          onItemSelected: (index) {
            setState(() {
              _activeNavigationIndex = index;
            });
          },
        ),

        // =====================================================================
        // DESKTOP CONTENT
        // =====================================================================

        Expanded(
          child: _buildDashboardContent(
            profile,
            isDesktop: true,
          ),
        ),
      ],
    );
  }

  //===========================================================================
  // TABLET DASHBOARD
  //===========================================================================

  Widget _buildTabletDashboard(UserProfile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // =====================================================================
        // HEADER
        // =====================================================================

        const DashboardHeader(),

        // =====================================================================
        // TABLET TOP NAVIGATION
        // =====================================================================

        DashboardNavigation(
          activeIndex: _activeNavigationIndex,
          onItemSelected: (index) {
            setState(() {
              _activeNavigationIndex = index;
            });
          },
        ),

        // =====================================================================
        // TABLET CONTENT
        // =====================================================================

        Expanded(
          child: _buildDashboardContent(
            profile,
            isDesktop: false,
          ),
        ),
      ],
    );
  }

  //===========================================================================
  // DASHBOARD CONTENT
  //===========================================================================

  Widget _buildDashboardContent(
    UserProfile profile, {
    required bool isDesktop,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        isDesktop
            ? AppSpacing.lg
            : AppSpacing.md,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.dashboardMaxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================================
              // DESKTOP HEADER
              // =================================================================

              if (isDesktop) ...[
                const DashboardHeader(),

                const SizedBox(
                  height: AppSpacing.xl,
                ),
              ],

              // =================================================================
              // GREETING
              // =================================================================

              DashboardGreeting(
                profile: profile,
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              // =================================================================
              // CONTINUE LEARNING + AI TUTOR
              // =================================================================

              _buildTopDashboardRow(),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              // =================================================================
              // MY COURSES
              // =================================================================

              MyCoursesSection(
                onCourseSelected: _openCourse,
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              // =================================================================
              // RECENT MATERIALS + ACADEMIC HEALTH
              // =================================================================

              _buildBottomDashboardRow(),

              const SizedBox(
                height: AppSpacing.xl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // TOP DASHBOARD ROW
  //===========================================================================

  Widget _buildTopDashboardRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ContinueLearningCard(
                onPressed: () {
                  _openCourse('course-1');
                },
              ),

              const SizedBox(
                height: AppSpacing.lg,
              ),

              AiTutorCard(
                onPressed: _openAiTutor,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: ContinueLearningCard(),
            ),

            const SizedBox(
              width: AppSpacing.lg,
            ),

            Expanded(
              child: AiTutorCard(
                onPressed: _openAiTutor,
              ),
            ),
          ],
        );
      },
    );
  }

  //===========================================================================
  // BOTTOM DASHBOARD ROW
  //===========================================================================

  Widget _buildBottomDashboardRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RecentMaterialsSection(
                onMaterialSelected: _openMaterial,
              ),

              const SizedBox(
                height: AppSpacing.xl,
              ),

              const AcademicHealthCard(
                expectedProgress: 0.50,
                actualProgress: 0.42,
                currentMonth: 2,
                totalMonths: 4,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RecentMaterialsSection(
                onMaterialSelected: _openMaterial,
              ),
            ),

            const SizedBox(
              width: AppSpacing.lg,
            ),

            const Expanded(
              child: AcademicHealthCard(
                expectedProgress: 0.50,
                actualProgress: 0.42,
                currentMonth: 2,
                totalMonths: 4,
              ),
            ),
          ],
        );
      },
    );
  }

  //===========================================================================
  // AI TUTOR
  //===========================================================================

  void _openAiTutor() {
    // Navigation will be connected when the AI Tutor platform is created.
  }

  //===========================================================================
  // COURSE
  //===========================================================================

  void _openCourse(String courseId) {
    // Future flow:
    //
    // 1. Retrieve last learning position.
    // 2. Open learning recap.
    // 3. Display previous section summaries.
    // 4. Present the most recent-section quiz.
    // 5. Allow revisit or progression.
    // 6. Resume at the student's last position.
  }

  //===========================================================================
  // MATERIAL
  //===========================================================================

  void _openMaterial(String materialId) {
    // Material navigation will be connected when the learning-material
    // platform is implemented.
  }

  //===========================================================================
  // LOADING STATE
  //===========================================================================

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  //===========================================================================
  // ERROR STATE
  //===========================================================================

  Widget _buildErrorState(
    Object error,
    StackTrace stackTrace,
  ) {
    return Center(
      child: Padding(
        padding: AppSpacing.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            const Text(
              'Unable to load your profile.',
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            ElevatedButton(
              onPressed: _loadStudentProfile,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  //===========================================================================
  // PROFILE UNAVAILABLE STATE
  //===========================================================================

  Widget _buildProfileUnavailableState() {
    return const Center(
      child: Padding(
        padding: AppSpacing.paddingLg,
        child: Text(
          'Your profile could not be found.',
        ),
      ),
    );
  }
}