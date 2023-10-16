import 'package:equatable/equatable.dart';

import 'package:timer_bloc/models/models.dart';

class ExercisesState extends Equatable {
  const ExercisesState(this.exercises);

  final List<Exercise> exercises;

  @override
  List<Object?> get props => [exercises];

  ExercisesState copyWith({
    List<Exercise>? exercises,
  }) {
    return ExercisesState(
      exercises ?? this.exercises,
    );
  }
}
