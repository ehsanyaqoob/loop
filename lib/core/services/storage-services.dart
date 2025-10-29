import 'package:flutter/foundation.dart';

class StorageService with ChangeNotifier {
  static const String _tokenKey = 'user_token';
  static const String _emailKey = 'user_email';
  static const String _nameKey = 'user_name';
  static const String _userIdKey = 'user_id';
  static const String _loginStatusKey = 'login_status';

  Future<void> setToken(String token) async {
    // Implementation depends on your storage solution
    // Example: await shared_preferences.setString(_tokenKey, token);
    notifyListeners();
  }

  Future<String?> getAuthToken() async {
    // Implementation depends on your storage solution
    // Example: return shared_preferences.getString(_tokenKey);
    return null;
  }

  Future<void> setEmail(String email) async {
    // await shared_preferences.setString(_emailKey, email);
    notifyListeners();
  }

  Future<String> getEmail() async {
    // return shared_preferences.getString(_emailKey) ?? '';
    return '';
  }

  Future<void> setName(String name) async {
    // await shared_preferences.setString(_nameKey, name);
    notifyListeners();
  }

  Future<String> getName() async {
    // return shared_preferences.getString(_nameKey) ?? '';
    return '';
  }

  Future<void> setUserId(String userId) async {
    // await shared_preferences.setString(_userIdKey, userId);
    notifyListeners();
  }

  Future<String?> getUserId() async {
    // return shared_preferences.getString(_userIdKey);
    return null;
  }

  Future<void> setLoginStatus(bool status) async {
    // await shared_preferences.setBool(_loginStatusKey, status);
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    // return shared_preferences.getBool(_loginStatusKey) ?? false;
    return false;
  }

  Future<void> saveUserSession({
    required String token,
    required String email,
    required String name,
    required String userId,
  }) async {
    await setToken(token);
    await setEmail(email);
    await setName(name);
    await setUserId(userId);
    await setLoginStatus(true);
    notifyListeners();
  }

  Future<void> clearUserData() async {
    // await shared_preferences.remove(_tokenKey);
    // await shared_preferences.remove(_emailKey);
    // await shared_preferences.remove(_nameKey);
    // await shared_preferences.remove(_userIdKey);
    // await shared_preferences.remove(_loginStatusKey);
    notifyListeners();
  }

  Future<bool> hasValidSession() async {
    final token = await getAuthToken();
    final loggedIn = await isLoggedIn();
    final userId = await getUserId();
    return token != null && token.isNotEmpty && loggedIn && userId != null;
  }
}