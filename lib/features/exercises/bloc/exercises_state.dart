import 'package:timer_bloc/models/models.dart';

class ExercisesState {
  ExercisesState(this.exercises);

  final List<Exercise> exercises;

  ExercisesState copyWith({
    List<Exercise>? exercises,
  }) {
    return ExercisesState(
      exercises ?? this.exercises,
    );
  }
}
