import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/exceptions/validation_exception.dart';
import 'package:timer_bloc/features/exercise_create/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';
import 'package:timer_bloc/repository/repository.dart';

class ExerciseCreateBloc extends Cubit<ExerciseCreateState> {
  ExerciseCreateBloc(
    this._repository,
    Exercise? exercise,
  ) : super(
          ExerciseCreateState(
            exercise: Exercise(
              name: exercise?.name ?? '',
              approaches: exercise?.approaches ?? [],
              description: exercise?.description ?? '',
              id: exercise?.id,
            ),
            '',
            ExercisesCreateScreenStatus.initial,
          ),
        );

  final ExercisesRepository _repository;

  void addExercise(Exercise exercise) async {
    emit(state.copyWith(status: ExercisesCreateScreenStatus.loading));
    try {
      await _repository.postExercise(exercise);
      emit(state.copyWith(status: ExercisesCreateScreenStatus.success));
    } on ValidationException catch (e) {
      emit(state.copyWith(
        status: ExercisesCreateScreenStatus.error,
        errorMessage: e.response.message,
      ));
    }
  }

  void updateExercise(Exercise newExercise) async {
    emit(state.copyWith(status: ExercisesCreateScreenStatus.loading));
    try {
      await _repository.pathExerciseId(newExercise);
      emit(state.copyWith(status: ExercisesCreateScreenStatus.success));
    } on ValidationException catch (e) {
      emit(state.copyWith(
        status: ExercisesCreateScreenStatus.error,
        errorMessage: e.response.message,
      ));
    }
  }

  void setExercisesName(String name) {
    emit(
      state.copyWith(
        exercise: state.exercise.copyWith(name: name),
      ),
    );
  }

  void setExercisesTime(String time, ApproachType timerType) {
    final value = int.tryParse(time) ?? 0;
    final timerEntry = Approach(null, value, timerType);
    final updatedExercise = state.exercise.copyWith(
      approaches: [...state.exercise.approaches, timerEntry],
    );
    emit(
      state.copyWith(exercise: updatedExercise),
    );
  }

  void updateApproach(Approach approach, String time, ApproachType timerType) {
    final value = int.tryParse(time) ?? 0;
    final newApproach = approach.copyWith(value: value, type: timerType);
    final positionOfOldApproach = state.exercise.approaches.indexOf(approach);

    state.exercise.approaches.removeAt(positionOfOldApproach);
    state.exercise.approaches.insert(positionOfOldApproach, newApproach);

    emit(state.copyWith(
      exercise: state.exercise.copyWith(approaches: [...state.exercise.approaches]),
    ));
  }

  void setExerciseDescription(String description) {
    emit(
      state.copyWith(
        exercise: state.exercise.copyWith(description: description),
      ),
    );
  }

  void deleteApproach(Approach approach) {
    state.exercise.approaches.remove(approach);
    emit(state.copyWith(
      exercise: state.exercise,
    ));
  }
}
