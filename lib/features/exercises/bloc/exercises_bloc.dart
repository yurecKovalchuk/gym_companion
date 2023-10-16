import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc(
    this._repository,
  ) : super(const ExercisesState(
          [],
        ));

  final ExercisesRepository _repository;

  void loadExercises() async {
    await _repository.getExercises();
    final localExercises = await _repository.getExercises();
    emit(state.copyWith(exercises: localExercises));
  }

  void deleteExercise(Exercise exercise) async {
    await _repository.deleteExercise(exercise);

    loadExercises();
  }
}
