import 'package:equatable/equatable.dart';

import 'package:timer_bloc/models/models.dart';

class ExercisesState extends Equatable {
  const ExercisesState(
    this.exercises,
    this.status,
    this.errorMessage,
  );

  final List<Exercise> exercises;
  final ExercisesScreenStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        exercises,
        status,
        errorMessage,
      ];

  ExercisesState copyWith({
    List<Exercise>? exercises,
    ExercisesScreenStatus? status,
    String? errorMessage,
  }) {
    return ExercisesState(
      exercises ?? this.exercises,
      status ?? this.status,
      errorMessage ?? this.errorMessage,
    );
  }
}

enum ExercisesScreenStatus {
  initial,
  loading,
  error,
  success,
}
