import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static const String _tokenKey = 'token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<bool> checkIfTokenExists() async {
    final token = await getToken();
    if (token != null) {
      return true;
    }
    return false;
  }
}
