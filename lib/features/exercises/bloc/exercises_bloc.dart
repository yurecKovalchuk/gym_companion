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

  void updateExercise(Exercise oldExercise, Exercise newExercise) async {
    final currentList = [...state.exercises];
    final indexOldExercise = currentList.indexOf(oldExercise);
    currentList.removeAt(indexOldExercise);
    currentList.insert(indexOldExercise, newExercise);

    await _dataSource.saveExercises(currentList);

    loadExercises();
  }

  void deleteExercise(Exercise exercise) async {
    await _dataSource.removeExercise(exercise);
    loadExercises();
  }
}
