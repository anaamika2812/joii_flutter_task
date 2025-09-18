# Joii flutter Task 

# README.md


This is a simple Flutter app built as per the requirements for the Joii interview task (September 2025).

### Features
- Splash screen with auto-navigation based on login status.
- Login form (email as username + password) integrated with the QA API[](https://api-staging.joiicare.com/api/login).
- Dashboard showing logged-in user's name at the top, with an animated pie chart as sample content.
- Logout button that clears session, shows a toast message, and navigates back to login.
- Persistent login: After successful login, killing and reopening the app lands directly on the dashboard.
- Error handling for invalid login attempts (displays API error messages).
- Clean architecture with layers: presentation, domain, data.
- BLoC for state management.
- Dio for API calls.
- GetX for routing.
- Integration tests for login success and failure.
- Good UI/UX with Material Design, Google Fonts, animations, and responsive layout.

### Dependencies
- `dio`: For HTTP requests.
- `flutter_bloc`: For state management.
- `get`: For routing.
- `shared_preferences`: For persistent storage (token and user name).
- `fluttertoast`: For toast messages.
- `fl_chart`: For animated chart on dashboard.
- `google_fonts`: For custom fonts.

No Equatable or Dependency Injection used as per instructions.

### Project Structure
- `lib/core/`: Constants and utils (e.g., storage helper).
- `lib/data/`: Data sources, models, repositories.
- `lib/domain/`: Entities, repositories (abstract), use cases.
- `lib/presentation/`: BLoCs, pages, widgets.
- `lib/routes/`: App routes with GetX.
- `test/integration/`: Integration tests.

### How to Run
1. Create a new Flutter project.
2. Replace `pubspec.yaml` with the provided one and run `flutter pub get`.
3. Copy the lib/ and test/ folders.
4. Run on iOS/Android emulator/device: `flutter run`.
5. For integration tests: `flutter test integration_test/app_test.dart`.

### Approach Notes
- **Architecture**: Followed clean architecture principles with separation of concerns. Use cases handle business logic, repositories abstract data sources.
- **State Management**: BLoC for auth states (loading, success, error).
- **Routing**: GetX for named routes and navigation without context.
- **Storage**: SharedPreferences to store token and name for persistence.
- **UI**: Used Material widgets with custom styling, Google Fonts (Roboto), animations (e.g., FadeTransition), and a responsive layout. Dashboard has an animated pie chart showing sample data.
- **API Integration**: Dio for POST login request. Handles 201 success and errors.
- **Tests**: Two integration tests for login success (valid creds) and failure (invalid creds).
- **Edge Cases**: Handles no internet, API errors, invalid inputs.

Test Credentials (from provided):
- Email: test@joiicare.com
- Password: Test@123

