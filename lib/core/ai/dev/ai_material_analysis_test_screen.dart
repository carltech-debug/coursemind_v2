import 'package:flutter/material.dart';

import '../context/academic_context.dart';
import '../materials/ai_material_container.dart';
import '../materials/models/ai_material.dart';

final class AiMaterialAnalysisTestScreen extends StatefulWidget {
  const AiMaterialAnalysisTestScreen({
    super.key,
  });

  @override
  State<AiMaterialAnalysisTestScreen> createState() =>
      _AiMaterialAnalysisTestScreenState();
}

final class _AiMaterialAnalysisTestScreenState
    extends State<AiMaterialAnalysisTestScreen> {
  bool _loading = false;
  String _response = 'Press the button to analyze the sample material.';

  Future<void> _analyzeMaterial() async {
    setState(() {
      _loading = true;
      _response = 'Analyzing academic material...';
    });

    try {
      const material = AiMaterial(
        id: 'dev-material-001',
        name: 'Engineering Mathematics Sample',
        type: AiMaterialType.text,
        source: '''
Functions

A function is a relation between two sets in which every
element of the first set is associated with exactly one
element of the second set.

Important concepts include domain, range, function notation,
composition of functions, and inverse functions.
''',
      );

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

      final service =
          AiMaterialContainer.createAnalysisService();

      final analysis = await service.analyze(
        material: material,
        context: context,
      );

      if (!mounted) return;

      setState(() {
        _response = '''
Topics:
${analysis.topics.join('\n')}

Concepts:
${analysis.concepts.entries.map(
  (entry) => '${entry.key}: ${entry.value.join(', ')}',
).join('\n')}

Key Points:
${analysis.keyPoints.join('\n')}

Learning Sequence:
${analysis.learningSequence.join('\n')}

Issues:
${analysis.issues.join('\n')}
''';
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _response = 'Material analysis failed:\n$error';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CourseMind AI Material Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text(
              'AI Material Analysis Test',
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
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading ? null : _analyzeMaterial,
              child: Text(
                _loading ? 'Analyzing...' : 'Analyze Material',
              ),
            ),
          ],
        ),
      ),
    );
  }
}