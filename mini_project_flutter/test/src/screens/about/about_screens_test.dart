import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_project_flutter/src/screens/about/about_screen.dart';

void main() {
  group('Test About', () {
    testWidgets('Test Title', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
      final title = find.byKey(const Key('title'));
      expect(title, findsOneWidget);
    });

    testWidgets('Test Logo', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
      final logo = find.byType(Lottie);
      expect(logo, findsOneWidget);
    });
    testWidgets('Test Text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
      final slogan = find.text('die Besten');
      expect(slogan, findsOneWidget);
    });

    testWidgets('Negative Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
      final negative = find.byIcon(Icons.home);
      expect(negative, findsNothing);
    });
  });
}
