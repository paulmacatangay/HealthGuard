# Firebase Setup Guide for HealthGuard App

This guide will help you connect your Flutter app to Firebase. Choose **Method 1 (Recommended)** for the easiest setup, or **Method 2** for manual configuration.

---

## Method 1: Using FlutterFire CLI (Recommended - Easiest)

### Step 1: Install FlutterFire CLI
Open your terminal and run:
```powershell
dart pub global activate flutterfire_cli
```

### Step 2: Navigate to Your Project
```powershell
cd "C:\Users\User\Downloads\mobcom final project\sdg_app"
```

### Step 3: Login to Firebase
```powershell
firebase login
```
This will open your browser to authenticate with your Google account.

### Step 4: Configure Firebase
```powershell
flutterfire configure
```

**What this command does:**
- Lists your Firebase projects (or lets you create a new one)
- Asks which platforms to configure (Android, iOS, Web, Windows, etc.)
- Automatically generates `lib/firebase_options.dart` with correct values
- Downloads `google-services.json` for Android
- Downloads `GoogleService-Info.plist` for iOS

**Follow the prompts:**
1. Select your Firebase project (or create a new one)
2. Choose platforms: Select `android`, `web`, and `windows` (or all you need)
3. The tool will automatically update your files

### Step 5: Enable Firebase Services

Go to [Firebase Console](https://console.firebase.google.com/) → Your Project:

#### A. Enable Authentication
1. Click **Authentication** in the left menu
2. Click **Get Started**
3. Click **Sign-in method** tab
4. Click **Email/Password**
5. Toggle **Enable** to ON
6. Click **Save**

#### B. Enable Firestore Database
1. Click **Firestore Database** in the left menu
2. Click **Create database**
3. Choose **Start in test mode** (for development)
4. Select a location (choose closest to you)
5. Click **Enable**

**⚠️ Important:** For production, you'll need to set up Firestore security rules. For now, test mode is fine for development.

### Step 6: Test the Connection
```powershell
flutter run
```

---

## Method 2: Manual Setup (If CLI doesn't work)

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **Add project** or **Create a project**
3. Enter project name: `healthguard-sdg` (or your choice)
4. Disable Google Analytics (optional) or enable it
5. Click **Create project**

### Step 2: Add Android App

1. In Firebase Console, click the **Android icon** (or **Add app** → Android)
2. **Android package name:** `com.example.sdg_app`
   - (Check `android/app/build.gradle.kts` line 24 to confirm)
3. **App nickname:** `HealthGuard Android` (optional)
4. **Debug signing certificate:** Leave blank for now
5. Click **Register app**
6. Download `google-services.json`
7. Place it in: `sdg_app/android/app/google-services.json`

### Step 3: Add Web App

1. In Firebase Console, click the **Web icon** (</>)
2. **App nickname:** `HealthGuard Web`
3. Click **Register app**
4. **Copy the Firebase configuration object** (you'll need this)

### Step 4: Add Windows App (Optional)

1. In Firebase Console, click **Add app** → **Windows**
2. **App nickname:** `HealthGuard Windows`
3. Click **Register app**
4. **Copy the configuration values**

### Step 5: Update Android Configuration

Edit `sdg_app/android/build.gradle.kts` and add at the top:

```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

Edit `sdg_app/android/app/build.gradle.kts` and add at the bottom:

```kotlin
plugins {
    // ... existing plugins
    id("com.google.gms.google-services")
}
```

### Step 6: Update firebase_options.dart

Open `sdg_app/lib/firebase_options.dart` and replace the placeholder values with your actual Firebase config:

**For Android:**
- Get values from `google-services.json` you downloaded
- Or from Firebase Console → Project Settings → Your Android app

**For Web:**
- Use the config object from Step 3

**Example (replace with YOUR values):**
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSy...',  // From google-services.json
  appId: '1:123456789:android:abc123',  // From google-services.json
  messagingSenderId: '123456789',  // From google-services.json
  projectId: 'your-project-id',  // Your Firebase project ID
  storageBucket: 'your-project-id.appspot.com',
);
```

### Step 7: Enable Firebase Services

Same as Method 1, Step 5:
- Enable **Email/Password Authentication**
- Enable **Firestore Database** (test mode for development)

---

## Getting Your Firebase Configuration Values

### From Firebase Console:
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click the **gear icon** ⚙️ → **Project settings**
4. Scroll down to **Your apps** section
5. Click on your app (Android/Web/Windows)
6. Copy the configuration values

### From google-services.json (Android):
Open `android/app/google-services.json` and find:
- `project_id` → `projectId`
- `api_key` → `apiKey`
- `app_id` → `appId`
- `mobilesdk_app_id` → `appId`
- `current_key` → `apiKey`

---

## Verify Setup

### Check 1: Files Exist
- ✅ `lib/firebase_options.dart` has real values (not placeholders)
- ✅ `android/app/google-services.json` exists (for Android)

### Check 2: Run the App
```powershell
cd "C:\Users\User\Downloads\mobcom final project\sdg_app"
flutter clean
flutter pub get
flutter run
```

### Check 3: Test Registration
1. Open the app
2. Click "Need an account? Register here."
3. Fill in the form and register
4. Check Firebase Console → Authentication → Users (should see your user)
5. Check Firebase Console → Firestore → Data (should see user document)

---

## Troubleshooting

### Error: "FirebaseApp not initialized"
- Make sure `firebase_options.dart` has real values (not placeholders)
- Run `flutter clean` and `flutter pub get`

### Error: "Missing google-services.json"
- Download it from Firebase Console
- Place in `android/app/google-services.json`
- Make sure the package name matches

### Error: "Authentication failed"
- Enable Email/Password auth in Firebase Console
- Check that Firestore is enabled

### Error: "Permission denied" in Firestore
- Go to Firestore → Rules
- For development, temporarily use:
  ```
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {
      match /{document=**} {
        allow read, write: if request.auth != null;
      }
    }
  }
  ```

---

## Quick Checklist

- [ ] Firebase project created
- [ ] Android app added to Firebase
- [ ] Web app added to Firebase (if using web)
- [ ] `google-services.json` downloaded and placed in `android/app/`
- [ ] `firebase_options.dart` updated with real values
- [ ] Email/Password Authentication enabled
- [ ] Firestore Database enabled
- [ ] App runs without Firebase errors
- [ ] Can register a new user
- [ ] User appears in Firebase Console

---

## Need Help?

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [FlutterFire CLI Docs](https://firebase.flutter.dev/docs/cli/)



