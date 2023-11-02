import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:timer_bloc/datasource/datasource.dart';
import 'package:timer_bloc/exceptions/exceptions.dart';
import 'package:timer_bloc/models/models.dart';

class RemoteDataSource {
  RemoteDataSource(
    this._baseUrl,
    this.localDataSource,
  );

  final String _baseUrl;

  LocalDataSource localDataSource;

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
      localDataSource.saveToken(SignInResponse.fromJson(data).token!);
      return SignInResponse.fromJson(data);
    } else {
      throw ValidationException(ErrorResponse.fromJson(data));
    }
  }

  Future<void> postExercise(Exercise exercise) async {
    final token = await localDataSource.getToken();
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
    final token = await localDataSource.getToken();
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
    final token = await localDataSource.getToken();
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
    final token = await localDataSource.getToken();
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
    final token = await localDataSource.getToken();
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

  Uri _generateUrl(String path) => Uri.parse('$_baseUrl/$path');
}
