import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:joii_flutter_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:joii_flutter_task/features/auth/presentation/bloc/auth_event.dart';
import 'package:joii_flutter_task/features/auth/presentation/bloc/auth_state.dart';
import 'package:joii_flutter_task/features/auth/presentation/pages/login_page.dart';
import 'package:joii_flutter_task/main.dart';
import 'package:mockito/mockito.dart';


class MockAuthBloc extends Mock implements AuthBloc {
  @override
  Stream<AuthState> get stream => super.noSuchMethod(
    Invocation.getter(#stream),
    returnValue: Stream<AuthState>.value(AuthInitial()),
    returnValueForMissingStub: Stream<AuthState>.value(AuthInitial()),
  );

  @override
  AuthState get state => super.noSuchMethod(
    Invocation.getter(#state),
    returnValue: AuthInitial(),
    returnValueForMissingStub: AuthInitial(),
  );

  @override
  void add(AuthEvent event) {
    super.noSuchMethod(
      Invocation.method(#add, [event]),
      returnValueForMissingStub: null,
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget createApp() {
    return BlocProvider<AuthBloc>(
      create: (context) => MockAuthBloc(),
      child: const MyApp(),
    );
  }

  group('Login Integration Tests', () {
    testWidgets('Login success with valid credentials', (WidgetTester tester) async {
      final mockAuthBloc = MockAuthBloc();
      when(mockAuthBloc.stream).thenAnswer((_) => Stream<AuthState>.value(AuthAuthenticated(userName: '')));
      when(mockAuthBloc.state).thenReturn(AuthAuthenticated(userName: ''));

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Wait for splash screen to navigate to login
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // Find widgets
      final usernameField = find.byKey(const Key('username_field'));
      final passwordField = find.byKey(const Key('password_field'));
      final loginButton = find.byKey(const Key('login_button'));

      // Verify fields and button are found
      expect(usernameField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);

      // Enter valid credentials
      await tester.enterText(usernameField, 'test@joiicare.com');
      await tester.enterText(passwordField, 'Test@123');
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for navigation

      // Verify navigation to dashboard with username
      expect(find.textContaining('Welcome, test@joiicare.com'), findsOneWidget);
    });

    testWidgets('Login failure with invalid credentials', (WidgetTester tester) async {
      final mockAuthBloc = MockAuthBloc();
      when(mockAuthBloc.stream).thenAnswer((_) => Stream<AuthState>.value(AuthError(message: 'Invalid username or password')));
      when(mockAuthBloc.state).thenReturn(AuthError(message: 'Invalid username or password'));

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      // Wait for splash screen to navigate to login
      await tester.pumpAndSettle(const Duration(seconds: 4));

      // Find widgets
      final usernameField = find.byKey(const Key('username_field'));
      final passwordField = find.byKey(const Key('password_field'));
      final loginButton = find.byKey(const Key('login_button'));

      // Verify fields and button are found
      expect(usernameField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);

      // Enter invalid credentials
      await tester.enterText(usernameField, 'invalid@email.com');
      await tester.enterText(passwordField, 'wrongpass');
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for error state

      // Verify error message
      expect(find.text('Invalid username or password'), findsOneWidget);
      expect(find.textContaining('Welcome'), findsNothing);
    });

    testWidgets('Logout from dashboard', (WidgetTester tester) async {
      final mockAuthBloc = MockAuthBloc();
      when(mockAuthBloc.stream).thenAnswer((_) => Stream<AuthState>.value(AuthAuthenticated(userName: '')));
      when(mockAuthBloc.state).thenReturn(AuthAuthenticated(userName: ''));

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle(const Duration(seconds: 4)); // Wait for login navigation
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Simulate login success

      // Assume dashboard has a logout button with key 'logout_button'
      final logoutButton = find.byKey(const Key('logout_button'));

      // Verify dashboard and logout button
      expect(find.textContaining('Welcome'), findsOneWidget);
      expect(logoutButton, findsOneWidget);

      // Tap logout
      await tester.tap(logoutButton);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for logout

      // Verify back to login and toast message
      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.text('Logged out successfully'), findsOneWidget); // Adjust toast message
    });
  });
}

