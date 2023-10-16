import 'package:timer_bloc/datasource/datasource.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesRepository {
  ExercisesRepository(
    this.localDataSource,
    this.remoteDataSource,
    this.authDataSource,
  );

  AuthDataSource authDataSource;
  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;

  Future<void> signUp(UserAuthentication userAuthentication) async {
    await authDataSource.signUpRequest(userAuthentication);
  }

  Future<SignInResponse> signIn(SignInCredentialsDto userAuthentication) async {
    return authDataSource.signInRequest(userAuthentication);
  }

  Future<void> saveToken(String token) async {
    await AuthDataSource.saveToken(token);
  }

  Future<String?> getToken() async {
    return AuthDataSource.getToken();
  }

  Future<void> removeToken() async {
    await AuthDataSource.removeToken();
  }

  Future<void> postExercise(Exercise exercise) async {
    remoteDataSource.postExercise(exercise);
  }

  Future<List<Exercise>> getExercises() async {
    final exercises = await remoteDataSource.getExercises();
    localDataSource.saveExercises(exercises);
    return localDataSource.loadExercises();
  }

  Future<void> pathExerciseId(Exercise updatedExercise) async {
    final exerciseId = updatedExercise.id;
    await remoteDataSource.patchExercise(exerciseId!, updatedExercise);
  }

  Future<void> deleteExercise(Exercise exercise) async {
    final exerciseId = exercise.id;
    await remoteDataSource.deleteExercise(exerciseId!);
  }
}
