import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HealthService {
  HealthService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> saveDailyCheckIn({
    required String mood,
    required int energyLevel,
    required int waterGlasses,
    required int sleepHours,
    String? notes,
  }) async {
    if (_userId.isEmpty) {
      throw Exception('User not authenticated');
    }

    try {
      final today = DateTime.now();
      final dateKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('checkIns')
          .doc(dateKey)
          .set({
        'mood': mood,
        'energyLevel': energyLevel,
        'waterGlasses': waterGlasses,
        'sleepHours': sleepHours,
        'notes': notes ?? '',
        'timestamp': FieldValue.serverTimestamp(),
        'date': dateKey,
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to save check-in: $e');
    }
  }

  Future<Map<String, dynamic>?> getTodayCheckIn() async {
    if (_userId.isEmpty) return null;

    final today = DateTime.now();
    final dateKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final doc = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkIns')
        .doc(dateKey)
        .get();

    return doc.exists ? doc.data() : null;
  }

  Stream<QuerySnapshot> getCheckInsStream({int limit = 30}) {
    if (_userId.isEmpty) {
      return const Stream.empty();
    }

    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('checkIns')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }

  Future<List<Map<String, dynamic>>> getWeeklyStats() async {
    if (_userId.isEmpty) return [];

    try {
      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));
      final startDate = '${weekAgo.year}-${weekAgo.month.toString().padLeft(2, '0')}-${weekAgo.day.toString().padLeft(2, '0')}';
      final endDate = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('checkIns')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThanOrEqualTo: endDate)
          .orderBy('date', descending: false)
          .get();

      final data = snapshot.docs.map((doc) {
        final docData = doc.data();
        return {
          ...docData,
          'date': docData['date'] ?? doc.id,
        };
      }).toList();

      // Sort by date to ensure proper order for charts
      data.sort((a, b) {
        final dateA = a['date'] as String? ?? '';
        final dateB = b['date'] as String? ?? '';
        return dateA.compareTo(dateB);
      });

      return data;
    } catch (e) {
      // Return empty list on error instead of throwing
      return [];
    }
  }
}

