import 'dart:async';

import 'package:timer_bloc/features/set_tasks/bloc/bloc.dart';
import 'package:timer_bloc/models/class_exercise.dart';

class SetTasksBloc {
  final StreamController<SetTasksState> _streamController =
      StreamController<SetTasksState>();

  Stream<SetTasksState> get streamSetTasks => _streamController.stream;

  final SetTasksState _state = SetTasksState(
    '',
    [],
  );

  SetTasksState get state => _state;

  int value = 0;

  void setExercisesName(String name) {
    state.exerciseName = name;
    _streamController.sink.add(state);
  }

  void setExercisesTime(String time, TimerType timerType) {
    value = int.tryParse(time)!.toInt();
    final timerEntry = TimerEntry(value, timerType);
    state.time.add(timerEntry);
    _streamController.sink.add(state);
  }

  Exercise get exercise => Exercise(
      state.exerciseName,
      state.time.cast());

  void dispose() {
    _streamController.close();
  }
}
