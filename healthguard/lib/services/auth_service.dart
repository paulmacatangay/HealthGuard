import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';

class AuthService {
  AuthService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _auth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Stream<User?> get authChanges => _auth.authStateChanges();

  Future<void> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    String? contactNumber,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;
    try {
      await _firestore.collection('users').doc(uid).set({
        'fullName': fullName,
        'email': email,
        'contactNumber': contactNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // If Firestore fails, still consider registration successful
      // The user can be created from Firebase Auth data later
      debugPrint('Warning: Failed to save user profile to Firestore: $e');
    }
  }

  Future<void> signOut() => _auth.signOut();

  Future<AppUser?> fetchProfile(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .get()
          .timeout(const Duration(seconds: 10));
      
      if (!snapshot.exists) {
        final user = _auth.currentUser;
        if (user == null) return null;
        final fallback = AppUser(
          uid: uid,
          fullName: user.displayName ?? 'Friend',
          email: user.email ?? '',
        );
        try {
          await _firestore.collection('users').doc(uid).set(fallback.toMap());
        } catch (e) {
          // If Firestore write fails, still return the fallback user
          debugPrint('Failed to write fallback user to Firestore: $e');
        }
        return fallback;
      }

      return AppUser.fromMap(uid, snapshot.data()!);
    } catch (e) {
      // If Firestore fails, create a fallback user from Firebase Auth
      debugPrint('Error fetching profile from Firestore: $e');
      final user = _auth.currentUser;
      if (user == null) return null;
      return AppUser(
        uid: uid,
        fullName: user.displayName ?? user.email?.split('@')[0] ?? 'User',
        email: user.email ?? '',
      );
    }
  }
}
