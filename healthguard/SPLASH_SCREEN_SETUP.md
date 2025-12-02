# Splash Screen Setup Guide

## ✅ What's Been Done

1. **App Colors Updated** - Changed to match your green HealthGuard logo:
   - Primary Color: `#2E7D32` (Dark Green)
   - Secondary Color: `#4CAF50` (Medium Green)
   - Accent Color: `#66BB6A` (Light Green)

2. **Splash Screen Created** - Custom animated splash screen with:
   - Fade-in and scale animations
   - Green gradient background matching logo
   - Logo display area
   - "HealthGuard" branding
   - Loading indicator

3. **Assets Folder Created** - Ready for your logo files

## 📁 Adding Your Logo

### Step 1: Place Your Logo Files

Place your logo/icon files in the `assets/logo/` folder:

```
healthguard/
  assets/
    logo/
      app_icon.png  ← Place your logo here (1024x1024px recommended)
```

### Step 2: Update pubspec.yaml (if needed)

The splash screen configuration is already set up in `pubspec.yaml`. Once you add `app_icon.png`, run:

```bash
flutter pub get
flutter pub run flutter_native_splash:create
```

This will generate native splash screens for Android and iOS.

### Step 3: Test the Splash Screen

The splash screen will automatically show for 2 seconds when the app starts. It includes:
- Your logo (or a fallback health icon if logo not found)
- "HealthGuard" text
- "Your Wellness Companion" subtitle
- Animated entrance effects
- Green gradient background matching your logo

## 🎨 Color Scheme

The app now uses a green color scheme matching your logo:
- **Primary**: Dark Green (#2E7D32) - Main brand color
- **Secondary**: Medium Green (#4CAF50) - Accent color
- **Accent**: Light Green (#66BB6A) - Highlights

All UI elements (buttons, cards, gradients) now use these green colors.

## 📱 App Icon Setup

To set your app icon for Android and iOS:

1. **Android**: Replace files in `android/app/src/main/res/mipmap-*/ic_launcher.png`
2. **iOS**: Update files in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

Or use a tool like `flutter_launcher_icons`:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/logo/app_icon.png"
```

Then run: `flutter pub run flutter_launcher_icons`

## ✨ Features

- **Animated Splash**: Smooth fade-in and scale animations
- **Brand Colors**: Green theme throughout the app
- **Fallback Support**: Works even if logo file is missing
- **Native Splash**: Configurable native splash screens for Android/iOS

## 🚀 Next Steps

1. Add your `app_icon.png` to `assets/logo/`
2. Run `flutter pub run flutter_native_splash:create` to generate native splash screens
3. Test the app - you should see the green splash screen on startup!

