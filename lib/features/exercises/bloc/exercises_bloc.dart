import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc(
    this._remoteDataSource,
    this._localDataSource,
  ) : super(const ExercisesState(
          [],
        ));

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  void loadExercises() async {
    final exercises = await _remoteDataSource.getExercises();
    await _localDataSource.saveExercises(exercises);
    final localExercises = await _localDataSource.loadExercises();
    emit(state.copyWith(exercises: localExercises));
  }

  void updateExercise(Exercise oldExercise, Exercise newExercise) async {
    await _remoteDataSource.patchExercise(oldExercise.id!, newExercise);
    await _localDataSource.removeExercise(oldExercise);

    loadExercises();
  }

  void deleteExercise(Exercise exercise) async {
    await _remoteDataSource.deleteExercise(exercise.id!);
    await _localDataSource.removeExercise(exercise);

    loadExercises();
  }
}
