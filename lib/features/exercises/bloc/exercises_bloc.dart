import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc(this.dataSource) : super(ExercisesState([]));

  final DataSource dataSource;

  void addExercise(Exercise exercise) {
    if (exercise.name.isNotEmpty) {
      state.exercises.add(exercise);
      emit(
        state.copyWith(exercises: state.exercises),
      );
      dataSource.saveExercises(state.exercises);
    }
  }

  void loadExercises() async {
    final exercises = await dataSource.loadExercises();
    emit(state.copyWith(exercises: exercises));
  }
}
