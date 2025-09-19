class UserEntity {
  final int? id;
  final String? email;
  final String? name;
  final String? secretEncryptionKey;
  final String? uuid;
  final String? profilePicture;
  final String? emailVerifiedAt;
  final bool? completed2fa;

  UserEntity({
    this.id,
    this.email,
    this.name,
    this.secretEncryptionKey,
    this.uuid,
    this.profilePicture,
    this.emailVerifiedAt,
    this.completed2fa,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      secretEncryptionKey: json['secret_encryption_key'],
      uuid: json['uuid'],
      profilePicture: json['profile_picture'],
      emailVerifiedAt: json['email_verified_at'],
      completed2fa: json['completed_2fa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'secret_encryption_key': secretEncryptionKey,
      'uuid': uuid,
      'profile_picture': profilePicture,
      'email_verified_at': emailVerifiedAt,
      'completed_2fa': completed2fa,
    };
  }
}