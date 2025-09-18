
import '../../domain/entities/user_entity.dart';

class UserModel extends User {
  UserModel({required String name}) : super(name: name);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name'] ?? '');
  }
}