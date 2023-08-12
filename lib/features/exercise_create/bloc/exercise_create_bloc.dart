import 'dart:async';

import 'package:timer_bloc/features/exercise_create/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';

class ExerciseCreateBloc {
  final StreamController<ExerciseCreateState> _streamController =
      StreamController<ExerciseCreateState>();

  Stream<ExerciseCreateState> get streamSetTasks => _streamController.stream;

  final ExerciseCreateState _state = ExerciseCreateState(
    Exercise(
      '',
      [],
    ),
  );

  ExerciseCreateState get state => _state;

  void setExercisesName(String name) {
    state.exercise.name = name;
    _streamController.sink.add(state);
  }

  void setExercisesTime(String time, ApproachType timerType) {
    final value = int.tryParse(time)!.toInt();
    final timerEntry = Approach(value, timerType);
    state.exercise.approaches.add(timerEntry);
    _streamController.sink.add(state);
  }

  void dispose() {
    _streamController.close();
  }
}
