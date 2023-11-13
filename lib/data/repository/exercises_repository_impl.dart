import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:injectable/injectable.dart';

import 'package:timer_bloc/datasource/datasource.dart';
import 'package:timer_bloc/models/models.dart';
import 'package:timer_bloc/domain/domain.dart';

@Injectable(as: ExercisesRepository)
class ExercisesRepositoryImpl implements ExercisesRepository {
  ExercisesRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._authDataSource,
    this._databaseSQL,
  );

  final AuthDataSource _authDataSource;
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;
  final SQLiteDataSource _databaseSQL;

  @override
  Future<void> signUp(UserAuthentication userAuthentication) async {
    await _authDataSource.signUpRequest(userAuthentication);
  }

  @override
  Future<SignInResponse> signIn(SignInCredentialsDto userAuthentication) async {
    return _authDataSource.signInRequest(userAuthentication);
  }

  @override
  Future<void> saveToken(String token) async {
    await _localDataSource.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return _localDataSource.getToken();
  }

  @override
  Future<void> removeToken() async {
    await _localDataSource.removeToken();
  }

  @override
  Future<bool> checkIfTokenExists() {
    return _localDataSource.checkIfTokenExists();
  }

  @override
  Future<void> postExercise(Exercise exercise) async {
    await _remoteDataSource.postExercise(exercise);
  }

  @override
  Future<List<Exercise>> getExercises() async {
    final exercises = await _remoteDataSource.getExercises();
    if (kIsWeb) {
      return exercises;
    } else {
      await _databaseSQL.initDatabase();
      await _databaseSQL.insertExercises(exercises);
      return _databaseSQL.getExercises();
    }
  }

  @override
  Future<void> pathExerciseId(Exercise updatedExercise) async {
    final exerciseId = updatedExercise.id;
    if (kIsWeb) {
      await _remoteDataSource.patchExercise(exerciseId!, updatedExercise);
    } else {
      await _databaseSQL.deleteExercise(exerciseId!);
      await _remoteDataSource.patchExercise(exerciseId, updatedExercise);
    }
  }

  @override
  Future<void> deleteExercise(Exercise exercise) async {
    final exerciseId = exercise.id;
    if (kIsWeb) {
      await _remoteDataSource.deleteExercise(exerciseId!);
    } else {
      await _remoteDataSource.deleteExercise(exerciseId!);
      _databaseSQL.deleteExercise(exerciseId);
    }
  }
}
