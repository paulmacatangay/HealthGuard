# Firebase Quick Start Guide

## 🚀 Fastest Method (5 minutes)

### 1. Install FlutterFire CLI
```powershell
dart pub global activate flutterfire_cli
```

### 2. Navigate to Project
```powershell
cd "C:\Users\User\Downloads\mobcom final project\sdg_app"
```

### 3. Login to Firebase
```powershell
firebase login
```

### 4. Configure Firebase (This does everything!)
```powershell
flutterfire configure
```

**Follow the prompts:**
- Select your Firebase project (or create new)
- Choose platforms: `android`, `web`, `windows`
- Done! ✅

### 5. Enable Services in Firebase Console

Go to https://console.firebase.google.com/ → Your Project:

**Enable Authentication:**
- Authentication → Get Started → Sign-in method → Email/Password → Enable → Save

**Enable Firestore:**
- Firestore Database → Create database → Start in test mode → Enable

### 6. Run Your App
```powershell
flutter run
```

---

## ✅ That's It!

Your app is now connected to Firebase. Try registering a new user to test!

---

## 📋 What You Need Before Starting

1. **Google Account** (for Firebase)
2. **Firebase Project** (will be created during `flutterfire configure`)
3. **Flutter SDK** (you have this ✓)

---

## 🆘 If Something Goes Wrong

See the detailed guide: `FIREBASE_SETUP.md`

Common issues:
- **"No Firebase project"** → Create one at https://console.firebase.google.com/
- **"google-services.json missing"** → Run `flutterfire configure` again
- **"Authentication failed"** → Enable Email/Password auth in Firebase Console



