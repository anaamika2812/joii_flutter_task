import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/storage_keys.dart';
import '../../../domain/entities/user_entity.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveUser(UserEntity user) async {
    await prefs.setString(StorageKeys.userData, jsonEncode(user.toJson()));
  }

  @override
  Future<UserEntity?> getUser() async {
    final jsonString = prefs.getString(StorageKeys.userData);
    if (jsonString != null) {
      return UserEntity.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await prefs.remove(StorageKeys.userData);
  }
}