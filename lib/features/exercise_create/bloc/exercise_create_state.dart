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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ExerciseCreateState && runtimeType == other.runtimeType && exercise == other.exercise;

  @override
  int get hashCode => exercise.hashCode;
}
