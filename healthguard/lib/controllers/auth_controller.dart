import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  AuthController({AuthService? authService})
    : _authService = authService ?? AuthService() {
    _authSubscription = _authService.authChanges.listen(_onAuthStateChanged);
  }

  final AuthService _authService;
  StreamSubscription<User?>? _authSubscription;

  AppUser? _currentUser;
  User? _firebaseUser;
  bool _isBusy = false;
  bool _isInitializing = true;
  String? _lastError;

  AppUser? get currentUser => _currentUser;
  User? get firebaseUser => _firebaseUser;
  bool get isBusy => _isBusy;
  bool get isInitializing => _isInitializing;
  String? get lastError => _lastError;

  Future<String?> register({
    required String fullName,
    required String email,
    required String password,
    String? contactNumber,
  }) async {
    return _runWithLoading(() async {
      try {
        await _authService.register(
          fullName: fullName,
          email: email,
          password: password,
          contactNumber: contactNumber,
        );
        return null;
      } on FirebaseAuthException catch (e) {
        return _mapError(e);
      }
    });
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    return _runWithLoading(() async {
      try {
        await _authService.signIn(email, password);
        return null;
      } on FirebaseAuthException catch (e) {
        return _mapError(e);
      }
    });
  }

  Future<void> signOut() => _authService.signOut();

  Future<void> _onAuthStateChanged(User? user) async {
    _firebaseUser = user;
    if (user == null) {
      _currentUser = null;
      _isInitializing = false;
      notifyListeners();
      return;
    }

    _isBusy = true;
    _isInitializing = false;
    notifyListeners();

    _currentUser = await _authService.fetchProfile(user.uid);

    _isBusy = false;
    notifyListeners();
  }

  Future<String?> _runWithLoading(Future<String?> Function() action) async {
    _isBusy = true;
    _lastError = null;
    notifyListeners();
    final result = await action();
    _lastError = result;
    _isBusy = false;
    notifyListeners();
    return result;
  }

  String _mapError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Choose a stronger password (min. 6 characters).';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'user-not-found':
      case 'wrong-password':
        return 'Incorrect email or password.';
      default:
        return 'Something went wrong (${exception.code}). Please try again.';
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
