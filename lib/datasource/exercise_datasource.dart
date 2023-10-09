import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:timer_bloc/models/models.dart';

class DataSource {
  DataSource(this.baseUrl);

  final String baseUrl;

  Future<void> signUpRequest(UserAuthentication userAuthentication) async {
    try {
      await http.post(
        _generateUrl('auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userAuthentication.toJson()),
      );
    } catch (e) {
      throw Exception('Something happened during sign in');
    }
  }

  Future<SignInResponse> signInRequest(SignInCredentialsDto userAuthentication) async {
    try {
      final response = await http.post(
        _generateUrl('auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userAuthentication.toJson()),
      );
      return SignInResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Something happened during sign in');
    }
  }

  Future<void> saveExercises(List<Exercise> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    final exercisesJson = exercises.map((exercise) => exercise.toJson()).toList();
    await prefs.setString('exercises', jsonEncode(exercisesJson));
  }

  Future<List<Exercise>> loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final exercisesJson = prefs.getString('exercises');
    if (exercisesJson != null) {
      final exercisesList = jsonDecode(exercisesJson) as List;
      final exercises = exercisesList.map<Exercise>((exerciseJson) => Exercise.fromJson(exerciseJson)).toList();
      return exercises;
    }
    return [];
  }

  Future<void> removeExercise(Exercise exercise) async {
    final prefs = await SharedPreferences.getInstance();
    final exercisesJson = prefs.getString('exercises');
    if (exercisesJson != null) {
      final exercisesList = jsonDecode(exercisesJson) as List;
      List<Exercise> exercises =
          exercisesList.map<Exercise>((exerciseJson) => Exercise.fromJson(exerciseJson)).toList();
      exercises.remove(exercise);
      await prefs.setString('exercises', jsonEncode(exercises));
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
