
import 'package:flutter/material.dart';

import '../widgets/academic_calendar_card.dart';
import '../widgets/academic_setup_features_card.dart';
import '../widgets/academic_structure_tree_card.dart';
import '../widgets/curriculum_upload_card.dart';

class AcademicStructureSetupScreen extends StatelessWidget {
  const AcademicStructureSetupScreen({
    super.key,
    this.onBack,
    this.onContinue,
  });

  final VoidCallback? onBack;
  final VoidCallback? onContinue;

  static const Color _purple = Color(0xFF3020D9);
  static const Color _ink = Color(0xFF111827);
  ///static const Color _green = Color(0xFF087443);
  static const Color _pageBackground = Color(0xFFFAF9FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildInstitutionHeader(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 650;
                  final horizontalPadding = isMobile ? 20.0 : 44.0;

                  return Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: _pageBackground,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/institution/academic_setup_background.png',
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        isMobile ? 28 : 32,
                        horizontalPadding,
                        32,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1400,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment:
                                  WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE5E9FF),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'SYSTEM SETUP PHASE 4',
                                    style: TextStyle(
                                      color: _purple,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.circle,
                                  size: 6,
                                  color: Color(0xFFC6C8D6),
                                ),
                                const Text(
                                  'Core Institutional Hierarchy',
                                  style: TextStyle(
                                    fontSize: 12,
                                    letterSpacing: 0.3,
                                    color: _ink,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Set up your academic structure',
                              style: TextStyle(
                                fontSize: isMobile ? 30 : 38,
                                height: 1.15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -1,
                                color: _ink,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const SizedBox(
                              width: 760,
                              child: Text(
                                'Give CourseMind the foundation of your '
                                'academic system. You can add more '
                                'details and delegate course management '
                                'after setup.',
                                style: TextStyle(
                                fontSize: 15,
                                  height: 1.55,
                                  color: Color(0xFF343447),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 32),

                            
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final isDesktop = constraints.maxWidth >= 1000;

                                if (isDesktop) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            AcademicStructureTreeCard(),
                                            SizedBox(height: 24),
                                            AcademicCalendarCard(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            const CurriculumUploadCard(),
                                            const SizedBox(height: 24),
                                            const AcademicSetupFeaturesCard(),
                                            const SizedBox(height: 24),

                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: FilledButton.icon(
                                                onPressed: onContinue,
                                                style: FilledButton.styleFrom(
                                                  backgroundColor: _purple,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 28,
                                                    vertical: 16,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_forward,
                                                  size: 18,
                                                ),
                                                label: const Text('Continue'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return const Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    AcademicStructureTreeCard(),
                                    SizedBox(height: 24),
                                    AcademicCalendarCard(),
                                    SizedBox(height: 24),
                                    CurriculumUploadCard(),
                                    SizedBox(height: 24),
                                    AcademicSetupFeaturesCard(),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstitutionHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 44,
            vertical: 12,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE7E7EF),
                width: 1,
              ),
            ),
          ),
          child: isMobile
              ? _buildMobileHeader()
              : _buildDesktopHeader(context),
        );
      },
    );
  }

  Widget _buildBrand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Image.asset(
            'assets/images/institution/coursemind_logo.png',
            width: 38,
            height: 38,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _purple,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.school_outlined,
                  color: Colors.white,
                  size: 23,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CourseMind',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'INSTITUTIONAL SETUP',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 0.7,
                height: 1.2,
                color: Color(0xFF252538),
              ),
            ),
          ],
        ),
      ],
    );
  }

  
  Widget _buildDesktopHeader(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left: CourseMind branding.
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Back',
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                    color: Color(0xFF25234A),
                  ),
                ),
                const SizedBox(width: 4),
                _buildBrand(),
              ],
            ),
          ),

          // Center: setup progress indicator.
          // The Stack centers this independently of the side sections.
          const Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ProgressStep(
                    number: '1.',
                    label: 'Institution',
                    completed: true,
                  ),
                  _ProgressConnector(),
                  _ProgressStep(
                    number: '2.',
                    label: 'Administrator',
                    completed: true,
                  ),
                  _ProgressConnector(),
                  _ProgressStep(
                    number: '3.',
                    label: 'Verification',
                    completed: true,
                  ),
                  _ProgressConnector(),
                  _ProgressStep(
                    number: '4',
                    label: 'Setup',
                    active: true,
                  ),
                ],
              ),
            ),
          ),

          // Right: Help and profile.
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.help_outline,
                  size: 19,
                  color: _ink,
                ),
                const SizedBox(width: 7),
                const Text(
                  'Help & Support',
                  style: TextStyle(
                    fontSize: 14,
                    color: _ink,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: _purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildMobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildBrand(),
            const Spacer(),
            const Icon(
              Icons.help_outline,
              size: 21,
              color: _ink,
            ),
            const SizedBox(width: 12),
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: _purple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 21,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Institution Setup progress is hardcoded for the current
        // frontend preview. Email verification backend integration is
        // temporarily bypassed, so stages 1–3 are displayed as completed
        // and stage 4 is displayed as active.
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _ProgressStep(
                number: '1.',
                label: 'Institution',
                completed: true,
              ),
              _ProgressConnector(),
              _ProgressStep(
                number: '2.',
                label: 'Administrator',
                completed: true,
              ),
              _ProgressConnector(),
              _ProgressStep(
                number: '3.',
                label: 'Verification',
                completed: true,
              ),
              _ProgressConnector(),
              _ProgressStep(
                number: '4',
                label: 'Setup',
                active: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressStep extends StatelessWidget {
  const _ProgressStep({
    required this.number,
    required this.label,
    this.completed = false,
    this.active = false,
  });

  final String number;
  final String label;
  final bool completed;
  final bool active;

  static const Color _purple = Color(0xFF3020D9);
  static const Color _green = Color(0xFF087443);

  @override
  Widget build(BuildContext context) {
    final color = completed
        ? _green
        : active
            ? _purple
            : const Color(0xFF56566A);

    return Container(
      padding: EdgeInsets.only(
        bottom: active ? 5 : 0,
      ),
      decoration: BoxDecoration(
        border: active
            ? const Border(
                bottom: BorderSide(
                  color: _purple,
                  width: 2,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (active)
            Container(
              width: 21,
              height: 21,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: _purple,
                shape: BoxShape.circle,
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else if (completed)
            const Icon(
              Icons.check_circle_outline,
              color: _green,
              size: 17,
            )
          else
            Text(
              number,
              style: TextStyle(
                color: color,
                fontSize: 13,
              ),
            ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight:
                  active ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressConnector extends StatelessWidget {
  const _ProgressConnector();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFD2D0E2),
    );
  }
}