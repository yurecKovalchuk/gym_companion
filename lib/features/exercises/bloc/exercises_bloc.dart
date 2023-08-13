import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc() : super(ExercisesState([]));

  void addExercise(Exercise exercise) {
    if (exercise.name.isNotEmpty) {
      state.exercises.add(exercise);
      emit(
        state.copyWith(exercises: state.exercises),
      );
    }
  }
}
