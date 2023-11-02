import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:timer_bloc/datasource/datasource.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesRepository {
  ExercisesRepository(
    this.localDataSource,
    this.remoteDataSource,
    this.authDataSource,
    this.databaseSQL,
  );

  AuthDataSource authDataSource;
  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;
  SQLiteDataSource databaseSQL;

  Future<void> signUp(UserAuthentication userAuthentication) async {
    await authDataSource.signUpRequest(userAuthentication);
  }

  Future<SignInResponse> signIn(SignInCredentialsDto userAuthentication) async {
    return authDataSource.signInRequest(userAuthentication);
  }

  Future<void> saveToken(String token) async {
    await localDataSource.saveToken(token);
  }

  Future<String?> getToken() async {
    return localDataSource.getToken();
  }

  Future<void> removeToken() async {
    await localDataSource.removeToken();
  }

  Future<void> postExercise(Exercise exercise) async {
    await remoteDataSource.postExercise(exercise);
  }

  Future<List<Exercise>> getExercises() async {
    final exercises = await remoteDataSource.getExercises();
    if (kIsWeb) {
      return exercises;
    } else {
      await databaseSQL.initDatabase();
      await databaseSQL.insertExercises(exercises);
      return databaseSQL.getExercises();
    }
  }

  Future<void> pathExerciseId(Exercise updatedExercise) async {
    final exerciseId = updatedExercise.id;
    if (kIsWeb) {
      await remoteDataSource.patchExercise(exerciseId!, updatedExercise);
    } else {
      await databaseSQL.deleteExercise(exerciseId!);
      await remoteDataSource.patchExercise(exerciseId, updatedExercise);
    }
  }

  Future<void> deleteExercise(Exercise exercise) async {
    final exerciseId = exercise.id;
    if (kIsWeb) {
      await remoteDataSource.deleteExercise(exerciseId!);
    } else {
      await remoteDataSource.deleteExercise(exerciseId!);
      databaseSQL.deleteExercise(exerciseId);
    }
  }
}
