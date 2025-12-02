class AppUser {
  AppUser({
    required this.uid,
    required this.fullName,
    required this.email,
    this.contactNumber,
  });

  final String uid;
  final String fullName;
  final String email;
  final String? contactNumber;

  factory AppUser.fromMap(String uid, Map<String, dynamic> data) {
    return AppUser(
      uid: uid,
      fullName: data['fullName'] as String? ?? 'Friend',
      email: data['email'] as String? ?? '',
      contactNumber: data['contactNumber'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'contactNumber': contactNumber,
    };
  }
}
