import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:timer_bloc/exceptions/exceptions.dart';
import 'package:timer_bloc/models/models.dart';

class AuthDataSource {
  AuthDataSource(
    this._baseUrl,
  );

  final String _baseUrl;

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

  Uri _generateUrl(String path) => Uri.parse('$_baseUrl/$path');
}
