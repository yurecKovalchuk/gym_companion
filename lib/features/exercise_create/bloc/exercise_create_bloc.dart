import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercise_create/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';

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
          ),
        );

  final ExercisesRepository _repository;

  void addExercise(Exercise exercise) async {
    if (exercise.name.isNotEmpty) {
      await _repository.postExercise(exercise);
    }
  }

  void updateExercise(Exercise newExercise) async {
    await _repository.pathExerciseId(newExercise);
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
