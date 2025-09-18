import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'constants.dart';

class SharedPrefsHelper {

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }


  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<bool> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(userKey, jsonEncode(user));
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(userKey);
    if (userString == null) return null;
    return jsonDecode(userString);
  }

  static Future<bool> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKey);
    return prefs.remove(userKey);
  }
}