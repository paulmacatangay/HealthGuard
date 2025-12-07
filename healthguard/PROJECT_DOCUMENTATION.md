# HealthGuard: Project Documentation

## Project Overview

**HealthGuard** is a comprehensive wellness monitoring mobile application built with Flutter and Firebase. The app aligns with **SDG 3 (Good Health & Well-Being)** and helps users track their daily wellness metrics, monitor health trends, and access wellness tips and resources.

### Key Features

- **User Authentication**: Secure registration, login, and password reset functionality
- **Daily Check-Ins**: Track mood, energy levels, water intake, sleep hours, and personal notes
- **Statistics & Analytics**: Visual charts and trends for wellness metrics over time
- **Wellness Tips**: Curated health and wellness advice
- **User Profile**: Manage personal information and account settings
- **SDG 3 Alignment**: Promotes good health and well-being through daily tracking

### Technical Stack

- **Framework**: Flutter 3.9.2+
- **Backend**: Firebase (Authentication, Cloud Firestore)
- **State Management**: Provider
- **Charts**: fl_chart
- **UI/UX**: Material Design 3, Google Fonts, Custom Animations
- **Platforms**: Android, iOS

### Project Information

- **Project Name**: HealthGuard
- **Package Name**: `health_guard`
- **Version**: 1.0.0+1
- **SDK**: Dart 3.9.2+
- **Platform Support**: Android, iOS
- **Development Status**: Production Ready

---

## File Structure

```
healthguard/
├── android/                 # Android platform-specific files
│   └── app/
│       └── src/main/
├── ios/                     # iOS platform-specific files
│   └── Runner/
├── lib/                     # Main application code
│   ├── constants/           # App constants and content
│   │   └── sdg_content.dart
│   ├── controllers/         # State management controllers
│   │   └── auth_controller.dart
│   ├── models/              # Data models
│   │   └── app_user.dart
│   ├── screens/             # UI screens
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   ├── home_screen.dart
│   │   ├── checkin_screen.dart
│   │   ├── stats_screen.dart
│   │   ├── tips_screen.dart
│   │   ├── profile_screen.dart
│   │   └── main_navigation.dart
│   ├── services/            # Business logic services
│   │   ├── auth_service.dart
│   │   └── health_service.dart
│   ├── theme/               # App theming
│   │   └── app_theme.dart
│   ├── widgets/             # Reusable UI components
│   │   ├── app_button.dart
│   │   └── app_text_field.dart
│   ├── firebase_options.dart # Firebase configuration
│   └── main.dart            # App entry point
├── assets/                  # App assets
│   ├── logo/                # App logo and icons
│   └── images/              # Image assets
├── test/                    # Unit and widget tests
│   └── widget_test.dart
├── pubspec.yaml             # Dependencies and configuration
└── README.md                  # Project documentation

```

---

## Key Files

### Core Application Files

#### `lib/main.dart`
- **Purpose**: Application entry point
- **Responsibilities**:
  - Initialize Firebase
  - Set up Provider for state management
  - Configure app routing
  - Implement authentication gate
  - Display splash screen

#### `lib/controllers/auth_controller.dart`
- **Purpose**: Authentication state management
- **Key Methods**:
  - `register()`: Handle user registration
  - `signIn()`: Handle user login
  - `signOut()`: Handle user logout
  - `resetPassword()`: Handle password reset
  - `_onAuthStateChanged()`: Listen to auth state changes

#### `lib/services/auth_service.dart`
- **Purpose**: Firebase Authentication wrapper
- **Key Methods**:
  - `signIn()`: Email/password authentication
  - `register()`: Create new user account
  - `signOut()`: Sign out current user
  - `resetPassword()`: Send password reset email
  - `fetchProfile()`: Retrieve user profile from Firestore

#### `lib/services/health_service.dart`
- **Purpose**: Health data management
- **Key Methods**:
  - `saveDailyCheckIn()`: Save daily wellness check-in
  - `getTodayCheckIn()`: Retrieve today's check-in data
  - `getWeeklyStats()`: Get weekly statistics for charts
  - `getCheckInsStream()`: Real-time check-in stream

### Screen Files

#### `lib/screens/splash_screen.dart`
- Animated splash screen with logo
- White background with green branding
- 2-second display duration

#### `lib/screens/login_screen.dart`
- Email and password input
- "Forgot Password?" link
- Navigation to registration
- Form validation

#### `lib/screens/register_screen.dart`
- User registration form
- Full name, email, password, contact number
- Success dialog and auto-logout
- Redirect to login

#### `lib/screens/forgot_password_screen.dart`
- Email input for password reset
- Success confirmation screen
- Firebase password reset integration

#### `lib/screens/home_screen.dart`
- Welcome message with user's first name
- SDG 3 information card
- Quick check-in card
- Quick action buttons
- Emergency contact display

#### `lib/screens/checkin_screen.dart`
- Mood selection (Happy, Good, Neutral, Sad, Stressed)
- Energy level slider (1-10)
- Water intake counter
- Sleep hours slider (0-12)
- Optional notes field
- Save/update functionality

#### `lib/screens/stats_screen.dart`
- Weekly statistics overview
- Summary cards (Avg Energy, Total Water, Avg Sleep)
- Interactive line charts for trends
- Pull-to-refresh functionality

#### `lib/screens/tips_screen.dart`
- 8 wellness tips with icons
- Categorized by health topics
- Scrollable list view

#### `lib/screens/profile_screen.dart`
- User profile header with avatar
- User information display
- Settings section
- Logout functionality

#### `lib/screens/main_navigation.dart`
- Bottom navigation bar
- 5 main tabs: Home, Check-In, Tips, Stats, Profile
- IndexedStack for screen management

### Model Files

#### `lib/models/app_user.dart`
- User data model
- Fields: uid, fullName, email, contactNumber
- `fromMap()` and `toMap()` methods for Firestore

### Theme Files

#### `lib/theme/app_theme.dart`
- Color scheme (Green theme matching logo)
- Material Design 3 configuration
- Google Fonts (Poppins) integration
- Custom gradient decorations
- Consistent styling across app

### Widget Files

#### `lib/widgets/app_button.dart`
- Reusable button component
- Loading state support
- Consistent styling

#### `lib/widgets/app_text_field.dart`
- Reusable text input component
- Validation support
- Consistent styling
- Optional suffix icon support

---

## UI/UX Design

### Design System

#### Color Palette
- **Primary Color**: `#2E7D32` (Dark Green) - Main brand color
- **Secondary Color**: `#4CAF50` (Medium Green) - Accent color
- **Accent Color**: `#66BB6A` (Light Green) - Highlights
- **Background**: `#F5F7FA` (Light Gray)
- **Surface**: `#FFFFFF` (White)
- **Error**: `#E57373` (Light Red)
- **Success**: `#4CAF50` (Green)
- **Warning**: `#FFB74D` (Orange)

#### Typography
- **Font Family**: Poppins (Google Fonts)
- **Display Large**: 32px, Bold
- **Display Medium**: 28px, Bold
- **Display Small**: 24px, Semi-bold
- **Title Large**: 18px, Semi-bold
- **Body Large**: 16px
- **Body Medium**: 14px

#### Design Principles
- **Material Design 3**: Modern, clean interface
- **Gradient Backgrounds**: Green gradient for headers
- **Rounded Corners**: 16-30px border radius
- **Card-based Layout**: Elevated cards with shadows
- **Smooth Animations**: Fade and scale transitions
- **Consistent Spacing**: 8px, 16px, 24px, 32px grid

### Screen Layouts

#### Splash Screen
- White background
- Centered logo (200x200)
- "HealthGuard" branding
- Loading indicator
- 2-second animation

#### Authentication Screens
- Green gradient background
- White card container
- Centered logo/icon
- Form inputs with validation
- Clear call-to-action buttons

#### Main App Screens
- Green gradient header
- White content area
- Card-based information display
- Bottom navigation bar
- Consistent spacing and padding

### User Experience Features
- **Smooth Transitions**: Page transitions and animations
- **Loading States**: Clear feedback during async operations
- **Error Handling**: User-friendly error messages
- **Form Validation**: Real-time input validation
- **Pull-to-Refresh**: Data refresh on stats screen
- **Responsive Design**: Adapts to different screen sizes

---

## System Flow

### Authentication Flow

```
1. App Launch
   ↓
2. Splash Screen (2 seconds)
   ↓
3. AuthGate Check
   ├─→ If not authenticated → Login Screen
   └─→ If authenticated → Load User Profile → Main Navigation
```

### Registration Flow

```
1. User clicks "Register" on Login Screen
   ↓
2. Fill Registration Form
   ├─→ Full Name (required)
   ├─→ Email (required, validated)
   ├─→ Password (required, min 6 chars)
   ├─→ Confirm Password (must match)
   └─→ Contact Number (optional)
   ↓
3. Submit Registration
   ├─→ Create Firebase Auth Account
   ├─→ Save User Data to Firestore
   ├─→ Show Success Dialog
   ├─→ Auto Sign Out
   └─→ Redirect to Login Screen
```

### Login Flow

```
1. User enters Email and Password
   ↓
2. Form Validation
   ↓
3. Firebase Authentication
   ├─→ Success → Fetch User Profile → Main Navigation
   └─→ Error → Show Error Message
```

### Password Reset Flow

```
1. User clicks "Forgot Password?" on Login Screen
   ↓
2. Enter Email Address
   ↓
3. Submit Reset Request
   ├─→ Firebase sends reset email
   ├─→ Show Success Screen
   └─→ User receives email with reset link
```

### Daily Check-In Flow

```
1. User navigates to Check-In tab
   ↓
2. Fill Check-In Form
   ├─→ Select Mood
   ├─→ Set Energy Level (1-10)
   ├─→ Set Water Intake (glasses)
   ├─→ Set Sleep Hours (0-12)
   └─→ Add Notes (optional)
   ↓
3. Save Check-In
   ├─→ Save to Firestore (users/{userId}/checkIns/{date})
   ├─→ Show Success Message
   └─→ Update Home Screen Quick Check-In Card
```

### Statistics Flow

```
1. User navigates to Stats tab
   ↓
2. Load Weekly Data
   ├─→ Query Firestore for last 7 days
   ├─→ Calculate averages and totals
   └─→ Display Summary Cards
   ↓
3. Display Charts
   ├─→ Energy Level Trend
   ├─→ Water Intake Trend
   └─→ Sleep Hours Trend
```

### Data Flow Architecture

```
UI Layer (Screens)
    ↓
Controller Layer (AuthController)
    ↓
Service Layer (AuthService, HealthService)
    ↓
Firebase (Authentication, Firestore)
```

---

## Firebase Integration

### Firebase Services Used

#### 1. Firebase Authentication
- **Service**: Email/Password Authentication
- **Features**:
  - User registration
  - User login
  - Password reset
  - Session management
- **Configuration**: `lib/firebase_options.dart`

#### 2. Cloud Firestore
- **Database Structure**:
  ```
  users/
    {userId}/
      - fullName: string
      - email: string
      - contactNumber: string (optional)
      - createdAt: timestamp
      
      checkIns/
        {dateKey}/  (format: YYYY-MM-DD)
          - mood: string
          - energyLevel: number
          - waterGlasses: number
          - sleepHours: number
          - notes: string
          - timestamp: timestamp
          - date: string
  ```

### Firebase Setup

#### Configuration Files
- **Android**: `android/app/google-services.json`
- **iOS**: `ios/Runner/GoogleService-Info.plist`
- **Flutter**: `lib/firebase_options.dart`

#### Security Rules (Recommended)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      match /checkIns/{checkInId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

### Data Operations

#### User Profile
- **Create**: On registration, save to `users/{userId}`
- **Read**: On login, fetch from `users/{userId}`
- **Update**: (Future enhancement)

#### Check-Ins
- **Create/Update**: Daily check-ins saved to `users/{userId}/checkIns/{date}`
- **Read**: Query by date range for statistics
- **Stream**: Real-time updates for check-ins

### Error Handling
- **Network Errors**: Timeout handling (10 seconds)
- **Authentication Errors**: User-friendly error messages
- **Firestore Errors**: Fallback to Firebase Auth data
- **Validation**: Client-side and server-side validation

---

## Future Enhancements

### Planned Features

#### 1. Enhanced Health Tracking
- Exercise tracking
- Nutrition logging
- Medication reminders
- Health goal setting
- Progress milestones

#### 2. Social Features
- Community forum
- Wellness challenges
- Friend connections
- Share achievements
- Group statistics

#### 3. Advanced Analytics
- Monthly/yearly reports
- Health insights and recommendations
- Trend predictions
- Export data functionality
- Custom date range selection

#### 4. Notifications
- Daily check-in reminders
- Goal achievement notifications
- Wellness tips notifications
- Community updates

#### 5. Health Resources
- Local healthcare provider directory
- Emergency services
- Mental health resources
- Wellness articles and guides
- Video tutorials

#### 6. Profile Enhancements
- Profile picture upload
- Health goals management
- Privacy settings
- Data export
- Account deletion

#### 7. Offline Support
- Offline data storage
- Sync when online
- Offline mode indicator

#### 8. Accessibility
- Screen reader support
- High contrast mode
- Font size adjustment
- Voice commands

#### 9. Multi-language Support
- Internationalization (i18n)
- Language selection
- Localized content

#### 10. Advanced Security
- Biometric authentication
- Two-factor authentication
- Session management
- Privacy controls

---

## Conclusion

HealthGuard is a comprehensive wellness monitoring application that successfully combines modern mobile development practices with Firebase backend services. The app provides users with an intuitive interface to track their daily wellness metrics, view trends, and access health resources.

### Key Achievements

✅ **Complete Authentication System**: Registration, login, password reset  
✅ **Daily Wellness Tracking**: Comprehensive check-in system  
✅ **Data Visualization**: Interactive charts and statistics  
✅ **Modern UI/UX**: Material Design 3 with custom theming  
✅ **Firebase Integration**: Secure backend with Firestore  
✅ **SDG 3 Alignment**: Promotes good health and well-being  
✅ **Error Handling**: Robust error handling and user feedback  
✅ **Responsive Design**: Works on Android and iOS  

### Technical Highlights

- **Clean Architecture**: Separation of concerns (UI, Controller, Service)
- **State Management**: Provider pattern for reactive UI
- **Type Safety**: Strong typing with Dart
- **Error Handling**: Comprehensive error handling at all layers
- **Performance**: Optimized queries and efficient data loading
- **Scalability**: Modular structure for easy feature additions

### Project Status

The application is **production-ready** with core features fully implemented. The codebase is well-structured, documented, and follows Flutter best practices. Future enhancements can be easily integrated into the existing architecture.

### Learning Outcomes

This project demonstrates:
- Flutter mobile app development
- Firebase Authentication and Firestore integration
- State management with Provider
- Material Design 3 implementation
- Data visualization with charts
- Form validation and error handling
- Responsive UI design
- SDG-aligned application development

---

## Project Information

### Development Details

- **Project Name**: HealthGuard
- **Package Name**: `health_guard`
- **Version**: 1.0.0+1
- **Build Number**: 1
- **SDK Version**: Dart 3.9.2+
- **Flutter Version**: 3.35+

### Platform Support

- ✅ Android (Minimum SDK: 21)
- ✅ iOS (Minimum Version: 12.0)

### Dependencies

#### Core Dependencies
- `flutter`: SDK
- `firebase_core: ^3.6.0`
- `firebase_auth: ^5.3.2`
- `cloud_firestore: ^5.4.3`
- `provider: ^6.1.2`

#### UI Dependencies
- `google_fonts: ^6.2.1`
- `fl_chart: ^0.69.0`
- `animations: ^2.0.11`
- `cupertino_icons: ^1.0.8`

#### Utility Dependencies
- `intl: ^0.19.0`

### Development Tools

- **IDE**: VS Code / Android Studio
- **Version Control**: Git
- **Package Manager**: Pub
- **Build Tools**: Flutter CLI, Gradle, CocoaPods

### Build Instructions

```bash
# Install dependencies
flutter pub get

# Run on connected device
flutter run

# Build Android APK
flutter build apk

# Build iOS app
flutter build ios
```

### Testing

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

### Project Repository

- **Location**: `healthguard/`
- **Main Entry**: `lib/main.dart`
- **Configuration**: `pubspec.yaml`

---

**Documentation Version**: 1.0  
**Last Updated**: 2025  
**Maintained By**: Development Team

