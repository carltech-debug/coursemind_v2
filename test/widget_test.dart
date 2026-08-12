import 'package:coursemind/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'CourseMind application starts successfully',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: CourseMindApp(),
        ),
      );

      // Allow the splash screen initialization timer to complete.
      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(CourseMindApp), findsOneWidget);
    },
  );
}