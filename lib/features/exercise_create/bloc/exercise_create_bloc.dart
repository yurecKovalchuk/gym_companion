import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/features/exercise_create/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';

class ExerciseCreateBloc extends Cubit<ExerciseCreateState> {
  ExerciseCreateBloc()
      : super(
          ExerciseCreateState(
            exercise: Exercise(
              name: '',
              approaches: [],
            ),
          ),
        );

  void setExercisesName(String name) {
    emit(
      state.copyWith(
        exercise: state.exercise.copyWith(name: name),
      ),
    );
  }

  void setExercisesTime(String time, ApproachType timerType) {
    final value = int.tryParse(time) ?? 0;
    final timerEntry = Approach(value, timerType);
    final updatedExercise = state.exercise.copyWith(
      approaches: [...state.exercise.approaches, timerEntry],
    );
    emit(
      state.copyWith(exercise: updatedExercise),
    );
  }
}
