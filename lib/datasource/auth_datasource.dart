import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_bloc/exceptions/exceptions.dart';
import 'package:timer_bloc/models/models.dart';

class AuthDataSource {
  AuthDataSource(
    this._baseUrl,
  );

  final String _baseUrl;
  static const String _tokenKey = 'token';

  Future<void> signUpRequest(UserAuthentication userAuthentication) async {
    final response = await http.post(
      _generateUrl('auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userAuthentication.toJson()),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode < 300) {
    } else {
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Future<SignInResponse> signInRequest(SignInCredentialsDto userAuthentication) async {
    final response = await http.post(
      _generateUrl('auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userAuthentication.toJson()),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode < 300) {
      return SignInResponse.fromJson(data);
    } else {
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

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

  Uri _generateUrl(String path) => Uri.parse('$_baseUrl/$path');
}
