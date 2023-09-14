import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasourse/datasourse.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc() : super(ExercisesState([]));

  final ExerciseDataSource _dataSource = ExerciseDataSource();

  void addExercise(Exercise exercise) {
    if (exercise.name.isNotEmpty) {
      state.exercises.add(exercise);
      emit(
        state.copyWith(exercises: state.exercises),
      );
      _dataSource.saveExercises(state.exercises);
    }
  }

  void loadExercises() async {
    final exercises = await _dataSource.loadExercises();
    emit(state.copyWith(exercises: exercises));
  }
}
