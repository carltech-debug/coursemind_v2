/*
==============================================================================
FILE: profile_setup_screen.dart
MODULE: Student
FEATURE: Profile
LAYER: Presentation
COMPONENT: Profile Setup Screen
==============================================================================

DESCRIPTION
-----------
First-time student profile setup screen.

Collects:
• Full name
• University
• Programme of study
• Academic level

The screen connects to the CourseMind ProfileController and saves the
completed profile to Firestore under:

users/{firebaseUid}

==============================================================================
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dashboard/presentation/screens/student_dashboard_screen.dart';
import '../../domain/entities/user_profile.dart';
import '../controllers/profile_controller.dart';

//=============================================================================
// DESIGN TOKENS
//=============================================================================

final class ProfileSetupTheme {
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF131B2E);
  static const Color primary = Color(0xFF4B41E1);
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF45464D);
  static const Color outline = Color(0xFF76777D);
  static const Color outlineVariant = Color(0xFFC6C6CD);
  static const Color fieldBackground = Color(0xFFECEEF0);
  static const Color secondaryFixed = Color(0xFFE2DFFF);
  static const Color tertiary = Color(0xFF6FFBBE);
  static const Color onTertiary = Color(0xFF009668);
  static const Color error = Color(0xFFBA1A1A);
}

//=============================================================================
// PROFILE SETUP SCREEN
//=============================================================================

final class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({
    super.key,
  });

  @override
  ConsumerState<ProfileSetupScreen> createState() =>
      _ProfileSetupScreenState();
}

//=============================================================================
// PROFILE SETUP STATE
//=============================================================================

final class _ProfileSetupScreenState
    extends ConsumerState<ProfileSetupScreen> {
  final TextEditingController _fullNameController =
      TextEditingController();

  final TextEditingController _universityController =
      TextEditingController();

  final TextEditingController _programmeController =
      TextEditingController();

  String? _selectedLevel;

  bool _isSubmitting = false;

  //===========================================================================
  // SAMPLE OPTIONS
  //===========================================================================

  static const List<String> _universities = [
    'Accra Technical University',
    'University of Ghana',
    'Kwame Nkrumah University of Science and Technology',
    'University of Cape Coast',
  ];

  static const List<String> _programmes = [
    'Electrical Engineering',
    'Computer Science',
    'Information Technology',
    'Business Administration',
  ];

  static const List<String> _levels = [
    '100',
    '200',
    '300',
    '400',
  ];

  //===========================================================================
  // LIFECYCLE
  //===========================================================================

  @override
  void dispose() {
    _fullNameController.dispose();
    _universityController.dispose();
    _programmeController.dispose();

    super.dispose();
  }

  //===========================================================================
  // STABLE ID CREATION
  //===========================================================================

  String _createStableId(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
  }

  //===========================================================================
  // VALIDATION
  //===========================================================================

  bool _validateFields() {
    if (_fullNameController.text.trim().isEmpty) {
      _showError('Please enter your full name.');
      return false;
    }

    if (_universityController.text.trim().isEmpty) {
      _showError('Please select your university.');
      return false;
    }

    if (_programmeController.text.trim().isEmpty) {
      _showError('Please select your programme of study.');
      return false;
    }

    if (_selectedLevel == null) {
      _showError('Please select your academic level.');
      return false;
    }

    return true;
  }

  //===========================================================================
  // SAVE PROFILE
  //===========================================================================

    Future<void> _handleContinue() async {
    if (_isSubmitting) {
      return;
    }

    if (!_validateFields()) {
      return;
    }

    final User? user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showError(
        'Your session has expired. Please sign in again.',
      );
      return;
    }

    final String fullName =
        _fullNameController.text.trim();

    final String institutionName =
        _universityController.text.trim();

    final String programmeName =
        _programmeController.text.trim();

    final String academicLevel =
        _selectedLevel!;

    final UserProfile profile = UserProfile(
      uid: user.uid,
      email: user.email ?? '',
      fullName: fullName,
      institutionId:
          _createStableId(institutionName),
      institutionName: institutionName,
      programmeId:
          _createStableId(programmeName),
      programmeName: programmeName,
      academicLevel: academicLevel,
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ref
          .read(
            profileControllerProvider
                .notifier,
          )
          .createProfile(profile);

      if (!mounted) {
        return;
      }

      final profileState =
          ref.read(profileControllerProvider);

      if (profileState.hasError) {
        _showError(
          profileState.error.toString(),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const StudentDashboardScreen(),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
  //===========================================================================
  // SKIP
  //===========================================================================

  void _handleSkip() {
    _showInfo(
      'You can complete your profile later.',
    );
  }

  //===========================================================================
  // MESSAGES
  //===========================================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ProfileSetupTheme.error,
      ),
    );
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  //===========================================================================
  // BUILD
  //===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileSetupTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1100,
                    ),
                    child: _buildContent(),
                  ),
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  //===========================================================================
  // HEADER
  //===========================================================================

  Widget _buildHeader() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      decoration: const BoxDecoration(
        color: ProfileSetupTheme.surface,
        border: Border(
          bottom: BorderSide(
            color: ProfileSetupTheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'CourseMind',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ProfileSetupTheme.primary,
            ),
          ),
          const Spacer(),
          Container(
            width: 160,
            height: 6,
            decoration: BoxDecoration(
              color: ProfileSetupTheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: ProfileSetupTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Setup progress 100%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ProfileSetupTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // CONTENT
  //===========================================================================

  Widget _buildContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop =
            constraints.maxWidth >= 850;

        if (isDesktop) {
          return Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildWelcomePanel(),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: _buildFormPanel(),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildWelcomePanel(),
            const SizedBox(height: 24),
            _buildFormPanel(),
          ],
        );
      },
    );
  }

  //===========================================================================
  // WELCOME PANEL
  //===========================================================================

  Widget _buildWelcomePanel() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 560,
      ),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: ProfileSetupTheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.school_outlined,
            size: 56,
            color: ProfileSetupTheme.tertiary,
          ),
          const SizedBox(height: 32),
          const Text(
            'Welcome, Scholar.',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Let’s personalize your CourseMind experience.',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFB7BDCE),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          _buildWelcomePoint(
            Icons.auto_awesome_outlined,
            'Personalized learning',
          ),
          const SizedBox(height: 20),
          _buildWelcomePoint(
            Icons.menu_book_outlined,
            'Relevant course resources',
          ),
          const SizedBox(height: 20),
          _buildWelcomePoint(
            Icons.psychology_outlined,
            'Smarter academic assistance',
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePoint(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: ProfileSetupTheme.tertiary,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  //===========================================================================
  // FORM PANEL
  //===========================================================================

  Widget _buildFormPanel() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ProfileSetupTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ProfileSetupTheme.outlineVariant
              .withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Step 1 of 1',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: ProfileSetupTheme.primary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tell us about yourself',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ProfileSetupTheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This helps us tailor your learning experience.',
            style: TextStyle(
              fontSize: 15,
              color: ProfileSetupTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          _buildTextField(
            controller: _fullNameController,
            label: 'Full Name',
            hint: 'Enter your full name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 18),
          _buildSelectionField(
            controller: _universityController,
            label: 'University',
            hint: 'Select your university',
            icon: Icons.account_balance_outlined,
            items: _universities,
          ),
          const SizedBox(height: 18),
          _buildSelectionField(
            controller: _programmeController,
            label: 'Programme of Study',
            hint: 'Select your programme',
            icon: Icons.menu_book_outlined,
            items: _programmes,
          ),
          const SizedBox(height: 24),
          const Text(
            'Current Academic Level',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ProfileSetupTheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          _buildLevelSelector(),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isSubmitting
                  ? null
                  : _handleContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    ProfileSetupTheme.primary,
                disabledBackgroundColor:
                    ProfileSetupTheme.primary
                        .withValues(alpha: 0.45),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<
                                Color>(
                          Colors.white,
                        ),
                      ),
                    )
                  : const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Save & Continue',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: TextButton(
              onPressed: _isSubmitting
                  ? null
                  : _handleSkip,
              child: const Text(
                'Skip for now',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color:
                      ProfileSetupTheme
                          .onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //===========================================================================
  // TEXT FIELD
  //===========================================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 15,
        color: ProfileSetupTheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color:
              ProfileSetupTheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor:
            ProfileSetupTheme.fieldBackground,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ProfileSetupTheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  //===========================================================================
  // SELECTION FIELD
  //===========================================================================

  Widget _buildSelectionField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      initialValue:
          controller.text.isEmpty
              ? null
              : controller.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color:
              ProfileSetupTheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor:
            ProfileSetupTheme.fieldBackground,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: ProfileSetupTheme.primary,
            width: 2,
          ),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow:
                    TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }

        setState(() {
          controller.text = value;
        });
      },
    );
  }

  //===========================================================================
  // LEVEL SELECTOR
  //===========================================================================

  Widget _buildLevelSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _levels.map(
        (level) {
          final bool isSelected =
              _selectedLevel == level;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedLevel = level;
              });
            },
            borderRadius:
                BorderRadius.circular(10),
            child: AnimatedContainer(
              duration:
                  const Duration(milliseconds: 180),
              width: 70,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? ProfileSetupTheme.primary
                    : ProfileSetupTheme
                        .fieldBackground,
                borderRadius:
                    BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? ProfileSetupTheme.primary
                      : ProfileSetupTheme
                          .outlineVariant,
                ),
              ),
              child: Text(
                level,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w700,
                  color: isSelected
                      ? Colors.white
                      : ProfileSetupTheme
                          .onSurface,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  //===========================================================================
  // FOOTER
  //===========================================================================

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        8,
        24,
        16,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.verified_user_outlined,
            size: 14,
            color: ProfileSetupTheme.outline,
          ),
          const SizedBox(width: 8),
          Text(
            'Your information is secured by CourseMind',
            style: TextStyle(
              fontSize: 12,
              color: ProfileSetupTheme.outline
                  .withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}