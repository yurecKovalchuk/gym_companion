import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc(this._dataSource)
      : super(ExercisesState(
          [],
        ));

  final DataSource _dataSource;

  void addExercise(Exercise exercise) {
    if (exercise.name.isNotEmpty) {
      _dataSource.postExercise(exercise);
    }
  }

  void loadExercises() async {
    final exercises = await _dataSource.getExercises();
    emit(state.copyWith(exercises: exercises));
  }

  void updateExercise(Exercise oldExercise, Exercise newExercise) async {
    await _dataSource.patchExercise(oldExercise.id!, newExercise);

    loadExercises();
  }

  void deleteExercise(Exercise exercise) async {
    await _dataSource.deleteExercise(exercise.id!);

    loadExercises();
  }
}
