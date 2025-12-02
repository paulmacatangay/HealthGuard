import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD4fmeNOS8DJKxi82JqzEKPb0_eJVohmcQ',
    appId: '1:529477966822:web:61d76bb4a8e3720156d427',
    messagingSenderId: '529477966822',
    projectId: 'healthguard-71183',
    authDomain: 'healthguard-71183.firebaseapp.com',
    storageBucket: 'healthguard-71183.firebasestorage.app',
    measurementId: 'G-6G2H18WWEW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPeNrtyjDF1nzuB1FIiuvQvTPC5Yx4mdA',
    appId: '1:529477966822:android:d4ab62dbe08343ca56d427',
    messagingSenderId: '529477966822',
    projectId: 'healthguard-71183',
    storageBucket: 'healthguard-71183.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-XY_DDgfAW9xB07J8WMceSh-rY4o8GH4',
    appId: '1:529477966822:ios:f2f6aff6c28c97f556d427',
    messagingSenderId: '529477966822',
    projectId: 'healthguard-71183',
    storageBucket: 'healthguard-71183.firebasestorage.app',
    iosBundleId: 'com.example.sdgApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-XY_DDgfAW9xB07J8WMceSh-rY4o8GH4',
    appId: '1:529477966822:ios:f2f6aff6c28c97f556d427',
    messagingSenderId: '529477966822',
    projectId: 'healthguard-71183',
    storageBucket: 'healthguard-71183.firebasestorage.app',
    iosBundleId: 'com.example.sdgApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD4fmeNOS8DJKxi82JqzEKPb0_eJVohmcQ',
    appId: '1:529477966822:web:4056918f09e53ed456d427',
    messagingSenderId: '529477966822',
    projectId: 'healthguard-71183',
    authDomain: 'healthguard-71183.firebaseapp.com',
    storageBucket: 'healthguard-71183.firebasestorage.app',
    measurementId: 'G-FEBE6N7X0N',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'LINUX_API_KEY',
    appId: 'LINUX_APP_ID',
    messagingSenderId: 'LINUX_SENDER_ID',
    projectId: 'SDG_PROJECT_ID',
    storageBucket: 'your-project.appspot.com',
  );
}