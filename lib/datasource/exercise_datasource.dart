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
      return SignInResponse.fromJson(data);
    } else {
      throw ValidationException(ErrorResponse.fromJson(data));
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
