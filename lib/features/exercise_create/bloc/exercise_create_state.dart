import 'package:timer_bloc/models/models.dart';

class ExerciseCreateState {
  ExerciseCreateState({
    required this.exercise,
  });

  Exercise exercise;

  ExerciseCreateState copyWith({
    Exercise? exercise,
  }) {
    return ExerciseCreateState(
      exercise: exercise ?? this.exercise,
    );
  }
}
