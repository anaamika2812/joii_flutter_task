class UserEntity {
  final String? checkoutId;
  final String email;
  final String name;
  final String? uid;
  final String? profilePicture;
  final bool completed2fa;

  UserEntity({
    this.checkoutId,
    required this.email,
    required this.name,
    this.uid,
    this.profilePicture,
    required this.completed2fa,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      checkoutId: json['checkout_id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      uid: json['uid'] as String?,
      profilePicture: json['profile_picture'] as String?,
      completed2fa: json['completed_2fa'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkout_id': checkoutId,
      'email': email,
      'name': name,
      'uid': uid,
      'profile_picture': profilePicture,
      'completed_2fa': completed2fa,
    };
  }
}