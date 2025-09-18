import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // app.main(); // Initialize the app
    await Future.delayed(const Duration(milliseconds: 500)); // Allow initial setup
  });

  group('Joii App Integration Tests', () {
    testWidgets('Login success with valid credentials', (WidgetTester tester) async {
      await tester.pumpAndSettle();

      // Verify splash screen
      expect(find.text('Joii'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for splash navigation

      // Verify login form and interact
      expect(find.byType(TextFormField), findsNWidgets(2));
      await tester.enterText(find.byType(TextFormField).first, 'test@joiicare.com');
      await tester.enterText(find.byType(TextFormField).last, 'Test@123');
      await tester.ensureVisible(find.byType(ElevatedButton)); // Scroll to button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 1)); // Wait for state change

      // Verify dashboard with mock user
      expect(find.text('Welcome, Mock User!'), findsOneWidget);
    });

    testWidgets('Login failure with invalid credentials', (WidgetTester tester) async {
      await tester.pumpAndSettle();

      // Verify splash screen
      expect(find.text('Joii'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for splash navigation

      // Verify login form and interact with invalid credentials
      expect(find.byType(TextFormField), findsNWidgets(2));
      await tester.enterText(find.byType(TextFormField).first, 'invalid@joii.com');
      await tester.enterText(find.byType(TextFormField).last, 'wrongpassword');
      await tester.ensureVisible(find.byType(ElevatedButton)); // Scroll to button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 1)); // Wait for error state

      // Verify error message (adjust based on UI)
      expect(find.textContaining('Login failed'), findsOneWidget); // Or find.byType(SnackBar)
    });
  });
}