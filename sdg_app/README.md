# HealthGuard: SDG 3 Wellness App

HealthGuard is a Flutter + Firebase starter that satisfies the Mobile Computing
final project requirements:

- SDG alignment → Supports SDG 3 (Good Health & Well-Being)
- Secure registration & login using Firebase Authentication (email/password)
- Stores user profile data (full name, email, optional contact) in Firestore
- Fetches the logged-in user’s name for the home screen
- Introduces the SDG purpose immediately after login

## Prerequisites

1. Flutter 3.35+ (run `flutter doctor`)
2. Firebase project with Email/Password auth enabled
3. FlutterFire CLI (`dart pub global activate flutterfire_cli`)

## Firebase setup

1. Inside this folder run `flutterfire configure` and select your Firebase
   project/targets.
2. The command will generate a `lib/firebase_options.dart`.  
   Replace the placeholder values currently in `lib/firebase_options.dart`
   with the generated file or update the constants manually.
3. For Android: download `google-services.json` into `android/app/`.  
   For iOS: place `GoogleService-Info.plist` in `ios/Runner/`.

## Run locally

```bash
flutter pub get
flutter run
```

## System flow

`Registration → Store data in Firestore → Login → Fetch user doc → Home Screen → Logout`

## Project structure (lib)

- `main.dart` – initializes Firebase, sets up routing/auth gate
- `controllers/auth_controller.dart` – listens to Firebase auth, exposes state
- `services/auth_service.dart` – wraps Firebase Auth + Firestore calls
- `screens/` – login, registration, and post-login home experience
- `constants/sdg_content.dart` – SDG title and narrative copy
- `widgets/` – shared form field and button components

## Validation & error handling

Both forms include validation states with descriptive error messages. Firebase
exceptions (duplicate email, weak password, wrong credentials, etc.) are mapped
to student-friendly text before being shown in SnackBars.

## Next steps

- Customize the SDG content, colors, and dashboard cards to fit your scope.
- Extend Firestore data (e.g., age, gender, goals) by editing
  `AppUser` and the registration form.
- Replace placeholder Firebase configuration with real keys before submission.
