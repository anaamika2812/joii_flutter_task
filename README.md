# Joii flutter Task 

## Overview
This is a Flutter app built for the Joii technical interview. It demonstrates clean architecture, BLoC state management, Dio for API integration, GetX for routing, and polished UI with animations.

### Tech Stack
- **State Management**: BLoC (no Equatable)
- **Architecture**: Clean (data/domain/presentation layers)
- **HTTP Client**: Dio
- **Routing**: GetX
- **Persistence**: shared_preferences
- **UI/Animations**: Material Design + fl_chart (animated pie chart)
- **Testing**: Widget tests (login success/failure)

## Features
- **Splash Screen**: 2s branded animation; checks auth persistence and routes accordingly.
- **Login**: Form with validation; integrates QA API. Success: stores token/user, goes to dashboard. Failure: shows API error Snackbar.
- **Dashboard**: Shows user name/profile pic. Animated pie chart for demo content. Logout button.
- **Logout**: Clears data, shows green Snackbar, returns to login.
- **Manual Criteria**:
    - Persistence: Kill/reopen app → dashboard if logged in.
    - Errors: Invalid login shows API message (e.g., "Invalid credentials").
- **UI**: Responsive, orange-themed, shadows/gradients for polish. Works on iOS/Android.

## Setup & Run
1. Clone or create project: `flutter create joii_app`.
2. Copy files into place.
3. Install deps: `flutter pub get`.
4. Run: `flutter run` (use test creds: email=`test@joiicare.com`, pw=`Test@123`).
5. Test API: Ensure internet; QA endpoint is staging.

## Tests
- Run: `flutter test`.
- Covers: Login success (UI loads, no error) & failure (error displayed).
- Uses Mockito for bloc mocking.
- 
## Integration Tests
- `joii_integration_test.dart` includes:
  - **Login Success**: Verifies login with `test@joiicare.com` and `Test@123`, navigates to dashboard, and persists after app kill/reopen.
  - **Login Failure**: Verifies login with `invalid@joii.com` and `wrongpassword`, displays API error message.
    Run with `flutter test test/integration_test/joii_integration_test.dart`.

## Approach Notes
- **Clean Arch**: Data layer (Dio datasource), Domain (entities/usecases/repos), Presentation (BLoC/pages/widgets).
- **No DI**: Manual instantiation in providers (e.g., Dio → Repo → UseCase → BLoC).
- **Error Handling**: Dio exceptions parsed for API messages.
- **UI Choices**: Pre-filled creds for ease; pie chart for "any content" (animated, simple). Toast via Get.snackbar.
- **Improvements**: Add more tests, error boundaries, profile pic caching.

Questions? Reach out!

Best,  
[Your Name]