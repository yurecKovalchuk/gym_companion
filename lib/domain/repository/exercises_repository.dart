import 'package:timer_bloc/models/models.dart';

abstract class ExercisesRepository {
  Future<void> signUp(UserAuthentication userAuthentication);

  Future<SignInResponse> signIn(SignInCredentialsDto userAuthentication);

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> removeToken();

  Future<bool> checkIfTokenExists();

  Future<void> postExercise(Exercise exercise);

  Future<List<Exercise>> getExercises();

  Future<void> pathExerciseId(Exercise updatedExercise);

  Future<void> deleteExercise(Exercise exercise);
}
