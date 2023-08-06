import 'dart:async';

import 'package:timer_bloc/features/set_tasks/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';

class SetTasksBloc {
  final StreamController<SetTasksState> _streamController =
      StreamController<SetTasksState>();

  Stream<SetTasksState> get streamSetTasks => _streamController.stream;

  final SetTasksState _state = SetTasksState(
    Exercise(
      '',
      [],
    ),
  );

  SetTasksState get state => _state;

  void setExercisesName(String name) {
    state.exercise.name = name;
    _streamController.sink.add(state);
  }

  void setExercisesTime(String time, TimerType timerType) {
    final value = int.tryParse(time)!.toInt();
    final timerEntry = SetTimer(value, timerType);
    state.exercise.time.add(timerEntry);
    _streamController.sink.add(state);
  }

  void dispose() {
    _streamController.close();
  }
}
