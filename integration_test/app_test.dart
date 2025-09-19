import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:joii_flutter_task/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await _setupTestEnvironment();

  group('Login Integration Tests', () {
    testWidgets('Login success with valid credentials', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Debug: Check if TextFormFields and Login button are found
      final emailFinder = find.byKey(const Key('email_field'));
      final passwordFinder = find.byKey(const Key('password_field'));
      final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');
      print('Email field found: ${emailFinder.evaluate().isNotEmpty}');
      print('Password field found: ${passwordFinder.evaluate().isNotEmpty}');
      print('Login button found: ${loginButtonFinder.evaluate().isNotEmpty}');
      print('Total ElevatedButtons found: ${find.byType(ElevatedButton).evaluate().length}');

      // Fallback to byType if keys are not used
      if (emailFinder.evaluate().isEmpty) {
        expect(find.byType(TextFormField), findsNWidgets(2)); // Expect 2 TextFormFields
        await tester.enterText(find.byType(TextFormField).at(0), 'test@joiicare.com');
      } else {
        await tester.enterText(emailFinder, 'test@joiicare.com');
      }
      if (passwordFinder.evaluate().isEmpty) {
        await tester.enterText(find.byType(TextFormField).at(1), 'Test@123');
      } else {
        await tester.enterText(passwordFinder, 'Test@123');
      }

      // Wait for the login button to appear
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(loginButtonFinder, findsOneWidget);

      // Tap the login button
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify navigation to dashboard
      expect(find.text('Welcome Joel Kalel'), findsOneWidget);
    });

    testWidgets('Login failure with invalid credentials', (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Debug: Check if TextFormFields and Login button are found
      final emailFinder = find.byKey(const Key('email_field'));
      final passwordFinder = find.byKey(const Key('password_field'));
      final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');
      print('Email field found: ${emailFinder.evaluate().isNotEmpty}');
      print('Password field found: ${passwordFinder.evaluate().isNotEmpty}');
      print('Login button found: ${loginButtonFinder.evaluate().isNotEmpty}');
      print('Total ElevatedButtons found: ${find.byType(ElevatedButton).evaluate().length}');

      // Fallback to byType if keys are not used
      if (emailFinder.evaluate().isEmpty) {
        expect(find.byType(TextFormField), findsNWidgets(2)); // Expect 2 TextFormFields
        await tester.enterText(find.byType(TextFormField).at(0), 'invalid@example.com');
      } else {
        await tester.enterText(emailFinder, 'invalid@example.com');
      }
      if (passwordFinder.evaluate().isEmpty) {
        await tester.enterText(find.byType(TextFormField).at(1), 'wrongpass');
      } else {
        await tester.enterText(passwordFinder, 'wrongpass');
      }

      // Wait for the login button to appear
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(loginButtonFinder, findsOneWidget);

      // Tap the login button
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify error message (adjust based on actual error text)
      expect(find.textContaining('Invalid'), findsOneWidget); // More flexible match
    });
  });
}

Future<void> _setupTestEnvironment() async {
  // Add any async setup (e.g., mocking API responses)
  await Future.delayed(Duration.zero); // Placeholder
}