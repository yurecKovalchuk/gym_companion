import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc(this._dataSource) : super(ExercisesState([]));

  final DataSource _dataSource;

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

  void updateExercise(Exercise oldExercise, Exercise newExercise) {
    final indexOldExercise = state.exercises.indexOf(oldExercise);
    state.exercises.remove(oldExercise);
    _dataSource.removeExercise(oldExercise);
    state.copyWith(exercises: state.exercises);
    state.exercises.insert(indexOldExercise, newExercise);
    _dataSource.saveExercises(state.exercises);

    emit(state.copyWith(exercises: state.exercises));
  }

  void deleteExercise(Exercise exercise) {
    state.exercises.remove(exercise);
    _dataSource.removeExercise(exercise);
    emit(state.copyWith(exercises: state.exercises));
  }
}
