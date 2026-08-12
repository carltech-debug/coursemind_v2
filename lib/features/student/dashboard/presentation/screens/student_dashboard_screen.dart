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

The dashboard obtains the authenticated student's profile through the
existing ProfileController and UserProfile architecture.

RESPONSIBILITIES
----------------
• Obtain the authenticated Firebase user.
• Request the user's profile through ProfileController.
• React to loading, error, and successful profile states.
• Compose the dashboard presentation widgets.

DATA STATUS
-----------
Profile information:
    Connected to the existing Firestore profile architecture.

Dashboard learning data:
    Presentation placeholders at this stage.

The individual dashboard widgets are intentionally separated from the
data/repository layer and will be connected to real learning data later.

==============================================================================
*/

import 'package:coursemind/app/theme/app_colors.dart';
import 'package:coursemind/app/theme/app_spacing.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/academic_health_card.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/ai_tutor_card.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/continue_learning_card.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/dashboard_greeting.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/dashboard_sidebar.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/my_courses_section.dart';
import 'package:coursemind/features/student/dashboard/presentation/widgets/recent_materials_section.dart';
import 'package:coursemind/features/student/profile/domain/entities/user_profile.dart';
import 'package:coursemind/features/student/profile/presentation/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

            return _buildDashboard(profile);
          },
        ),
      ),
    );
  }

  //===========================================================================
  // DASHBOARD
  //===========================================================================

  Widget _buildDashboard(UserProfile profile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // =====================================================================
        // SIDEBAR
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
        // MAIN CONTENT
        // =====================================================================

        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.paddingLg,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSpacing.dashboardMaxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================================
                    // HEADER
                    // ==========================================================

                    const DashboardHeader(),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ==========================================================
                    // GREETING
                    // ==========================================================

                    DashboardGreeting(
                      profile: profile,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ==========================================================
                    // CONTINUE LEARNING
                    // ==========================================================

                    const ContinueLearningCard(),

                    const SizedBox(
                      height: AppSpacing.lg,
                    ),

                    // ==========================================================
                    // AI TUTOR
                    // ==========================================================

                    AiTutorCard(
                      onPressed: _openAiTutor,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ==========================================================
                    // MY COURSES
                    // ==========================================================

                    MyCoursesSection(
                      onCourseSelected: _openCourse,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ==========================================================
                    // RECENT MATERIALS
                    // ==========================================================

                    RecentMaterialsSection(
                      onMaterialSelected: _openMaterial,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    // ==========================================================
                    // ACADEMIC HEALTH
                    // ==========================================================

                    const AcademicHealthCard(
                      expectedProgress: 0.50,
                      actualProgress: 0.42,
                      currentMonth: 2,
                      totalMonths: 4,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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