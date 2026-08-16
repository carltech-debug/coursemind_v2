import 'package:flutter/material.dart';

import '../config/ai_container.dart';
import '../context/academic_context.dart';
//import '../context/ai_context_service.dart';
//import '../context/dev_academic_context_authorizer.dart';
//import '../context/firestore_academic_context_provider.dart';
//import '../models/ai_request.dart';
//import '../prompts/academic_prompt_builder.dart';
//import '../prompts/ai_prompts.dart';
//import '../providers/gemini_provider.dart';
import '../services/ai_orchestrator.dart';
//import '../services/ai_service.dart';

class AiConnectionTestScreen extends StatefulWidget {
  const AiConnectionTestScreen({super.key});

  @override
  State<AiConnectionTestScreen> createState() =>
      _AiConnectionTestScreenState();
}

class _AiConnectionTestScreenState
    extends State<AiConnectionTestScreen> {
  late final AiOrchestrator _aiOrchestrator;
String _response = 'Press the button to test Gemini.';
  bool _loading = false;

@override
void initState() {
  super.initState();

  _aiOrchestrator = AiContainer.createOrchestrator();
}

  Future<void> _testGemini() async {
  setState(() {
    _loading = true;
    _response = 'Running CourseMind AI orchestration...';
  });

  try {
    const context = AcademicContext(
      institution: 'Accra Technical University',
      programme: 'Electrical and Electronic Engineering',
      level: '100',
      semester: 'Semester 1',
      course: 'Engineering Mathematics',
      courseOutline: '''
Functions
Indices, Surds and Logarithms
Rational Functions and Partial Fractions
Sequences and Finite Series
Binomial Theorem
Trigonometry
Matrix Algebra
Complex Numbers
''',
    );

    final response =
        await _aiOrchestrator.generateAcademicResponse(
      studentId: 'development-test-student',
      context: context,
      studentRequest:
          'Explain what topics this course contains and organize '
          'them into a logical learning sequence.',
    );

    if (!mounted) return;

    setState(() {
      _response = response.text;
      _loading = false;
    });
  } catch (error) {
    if (!mounted) return;

    setState(() {
      _response = 'Generation failed:\n$error';
      _loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CourseMind AI Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text(
              'Gemini Connection Test',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _response,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading ? null : _testGemini,
              child: Text(
                _loading ? 'Connecting...' : 'Test Gemini',
              ),
            ),
          ],
        ),
      ),
    );
  }
}