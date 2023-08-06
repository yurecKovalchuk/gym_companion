import 'dart:async';

import 'package:timer_bloc/models/set_task_state.dart';

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

  SetTasksState get exercise => SetTasksState(
        state.exerciseName,
        state.time,
      );

  void dispose() {
    _streamController.close();
  }
}
