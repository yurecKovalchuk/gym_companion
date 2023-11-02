import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/exceptions/validation_exception.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';
import 'package:timer_bloc/repository/repository.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc(
    this._repository,
  ) : super(const ExercisesState(
          [],
          ExercisesScreenStatus.initial,
          '',
        ));

  final ExercisesRepository _repository;

  void loadExercises() async {
    emit(state.copyWith(status: ExercisesScreenStatus.loading));

    try {
      final localExercises = await _repository.getExercises();

      emit(state.copyWith(
        exercises: localExercises,
        status: ExercisesScreenStatus.success,
      ));
    } on ValidationException catch (e) {
      emit(state.copyWith(
        status: ExercisesScreenStatus.error,
        errorMessage: e.response.message.toString(),
      ));
    }
  }

  void deleteExercise(Exercise exercise) async {
    emit(state.copyWith(status: ExercisesScreenStatus.loading));
    try {
      await _repository.deleteExercise(exercise);

      loadExercises();
    } on ValidationException catch (e) {
      emit(state.copyWith(
        status: ExercisesScreenStatus.error,
        errorMessage: e.response.message.toString(),
      ));
    }
  }
}
