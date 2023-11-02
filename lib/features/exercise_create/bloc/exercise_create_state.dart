import 'package:timer_bloc/models/models.dart';

class ExerciseCreateState {
  ExerciseCreateState(
    this.errorMessage,
    this.status, {
    required this.exercise,
  });

  Exercise exercise;
  String? errorMessage;
  ExercisesCreateScreenStatus status;

  ExerciseCreateState copyWith({
    Exercise? exercise,
    String? errorMessage,
    ExercisesCreateScreenStatus? status,
  }) {
    return ExerciseCreateState(
      exercise: exercise ?? this.exercise,
      errorMessage ?? this.errorMessage,
      status ?? this.status,
    );
  }
}

enum ExercisesCreateScreenStatus {
  initial,
  loading,
  error,
  success,
}
