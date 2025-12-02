import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    await _firestore.collection('users').doc(uid).set({
      'fullName': fullName,
      'email': email,
      'contactNumber': contactNumber,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> signOut() => _auth.signOut();

  Future<AppUser?> fetchProfile(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    if (!snapshot.exists) {
      final user = _auth.currentUser;
      if (user == null) return null;
      final fallback = AppUser(
        uid: uid,
        fullName: user.displayName ?? 'Friend',
        email: user.email ?? '',
      );
      await _firestore.collection('users').doc(uid).set(fallback.toMap());
      return fallback;
    }

    return AppUser.fromMap(uid, snapshot.data()!);
  }
}
