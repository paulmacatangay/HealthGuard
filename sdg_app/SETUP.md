# How to Run the SDG App

## Prerequisites
1. Flutter SDK installed (you have Flutter 3.35.5 ✓)
2. Firebase project created
3. Android Studio / VS Code with Flutter extensions

## Step 1: Navigate to Project Directory
Open your terminal/command prompt and navigate to the project:

```powershell
cd "C:\Users\User\Downloads\mobcom final project\sdg_app"
```

## Step 2: Install Dependencies
```powershell
flutter pub get
```

## Step 3: Configure Firebase (Required Before Running)

### Option A: Using FlutterFire CLI (Recommended)
```powershell
# Install FlutterFire CLI globally
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

This will:
- Connect to your Firebase project
- Generate `lib/firebase_options.dart` with your credentials
- Configure Android/iOS/Web as needed

### Option B: Manual Configuration
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing one
3. Add Android/iOS/Web apps to your project
4. Download configuration files:
   - Android: `google-services.json` → place in `android/app/`
   - iOS: `GoogleService-Info.plist` → place in `ios/Runner/`
   - Web: Copy config to `lib/firebase_options.dart`
5. Enable Authentication (Email/Password) in Firebase Console
6. Enable Firestore Database in Firebase Console

## Step 4: Check Connected Devices
```powershell
flutter devices
```

## Step 5: Run the App

### For Android Emulator/Device:
```powershell
flutter run
```

### For Specific Device:
```powershell
flutter run -d <device-id>
```

### For Web:
```powershell
flutter run -d chrome
```

### For Windows Desktop:
```powershell
flutter run -d windows
```

## Troubleshooting

### Error: "No pubspec.yaml file found"
- Make sure you're in the `sdg_app` directory, not the parent directory
- Run: `cd sdg_app` from the parent folder

### Error: "Firebase not initialized"
- Complete Step 3 (Firebase Configuration) above
- Make sure `lib/firebase_options.dart` has valid Firebase credentials

### Error: "No devices found"
- Start an Android emulator from Android Studio
- Or connect a physical device via USB (with USB debugging enabled)
- Or run on web: `flutter run -d chrome`

## Project Structure
```
sdg_app/
├── lib/
│   ├── main.dart              # App entry point
│   ├── screens/               # Login, Register, Home screens
│   ├── services/              # Firebase auth service
│   ├── controllers/           # Auth controller (Provider)
│   ├── models/                # User model
│   ├── widgets/               # Reusable UI components
│   └── firebase_options.dart  # Firebase configuration
├── pubspec.yaml               # Dependencies
└── README.md                  # Project documentation
```

## Quick Start Checklist
- [ ] Navigate to `sdg_app` directory
- [ ] Run `flutter pub get`
- [ ] Configure Firebase (Step 3)
- [ ] Enable Email/Password auth in Firebase Console
- [ ] Enable Firestore in Firebase Console
- [ ] Run `flutter devices` to see available devices
- [ ] Run `flutter run`


