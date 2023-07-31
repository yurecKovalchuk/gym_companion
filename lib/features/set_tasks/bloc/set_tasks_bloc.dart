import 'dart:async';

import 'package:timer_bloc/features/set_tasks/bloc/bloc.dart';

class SetTasksBloc {
  final StreamController<SetTasksState> _streamController =
      StreamController<SetTasksState>();

  Stream<SetTasksState> get streamString => _streamController.stream;

  final SetTasksState _state = SetTasksState();

  SetTasksState get state => _state;

  void getName(String name) {
    state.exerciseName = name;
    _streamController.sink.add(state);
  }

  void getTime(String time) {
    state.exerciseTime = int.tryParse(time) ?? 0;
    _streamController.sink.add(state);
  }

  void dispose() {
    _streamController.close();
  }
}
