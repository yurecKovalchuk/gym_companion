import 'dart:async';

import 'package:timer_bloc/features/set_tasks/bloc/bloc.dart';

class SetTasksBloc {
  final StreamController<SetTasksState> _streamController =
      StreamController<SetTasksState>();

  Stream<SetTasksState> get streamSetTasks => _streamController.stream;

  final SetTasksState _state = SetTasksState('', []);

  SetTasksState get state => _state;

  int value = 0;

  void getName(String name) {
    state.exerciseName = name;
    _streamController.sink.add(state);
  }

  void getTime(String time) {
    value = int.tryParse(time)!.toInt();
    state.exerciseTime.add(value);
    _streamController.sink.add(state);
  }

  void dispose() {
    _streamController.close();
  }
}
