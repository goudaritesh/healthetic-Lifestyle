import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healtheticlifestyle/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HealtheticApp());

    // Verify that the splash screen shows image logo.
    expect(find.byType(Image), findsOneWidget);

    // Wait for the timer to finish and navigate to the LoginScreen
    await tester.pump(const Duration(seconds: 4));
  });
}
