import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timer_bloc/models/models.dart';
import '../exceptions/exceptions.dart';

class DataSource {
  DataSource(this.baseUrl);

  final String baseUrl;

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
      TokenManager.saveToken(SignInResponse.fromJson(data).token!);
      return SignInResponse.fromJson(data);
    } else {
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Future<void> postExercise(Exercise exercise) async {
    final token = await TokenManager.getToken();
    final url = _generateUrl('exercises');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(exercise.toJson()),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode < 300) {
    } else {
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Future<List<Exercise>> getExercises() async {
    final token = await TokenManager.getToken();
    final response = await http.get(
      _generateUrl('exercises'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode < 300) {
      final data = jsonDecode(response.body) as List;
      final List<Exercise> exercises = data.map<Exercise>((data) => Exercise.fromJson(data)).toList();
      return exercises;
    } else {
      final data = jsonDecode(response.body);
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Future<Exercise> getExerciseId(String exerciseId) async {
    final token = await TokenManager.getToken();
    final response = await http.get(
      _generateUrl('exercise/$exerciseId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final data = jsonDecode(response.body);
    if (response.statusCode < 300) {
      return Exercise.fromJson(data);
    } else {
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Future<void> patchExercise(String exerciseId, Exercise updatedExercise) async {
    final token = await TokenManager.getToken();
    final response = await http.patch(
      _generateUrl('exercises/$exerciseId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updatedExercise.toJson()),
    );

    if (response.statusCode < 300) {
    } else {
      final data = jsonDecode(response.body);
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Future<void> deleteExercise(String exerciseId) async {
    final token = await TokenManager.getToken();
    final response = await http.delete(
      _generateUrl('exercises/$exerciseId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode < 300) {
    } else {
      final data = jsonDecode(response.body);
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Uri _generateUrl(String path) => Uri.parse('$baseUrl/$path');
}

class TokenManager {
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
}
