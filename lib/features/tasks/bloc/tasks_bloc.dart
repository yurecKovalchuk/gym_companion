import 'dart:async';

import 'package:timer_bloc/features/tasks/tasks.dart';
import 'package:timer_bloc/models/models.dart';

class TrainingBloc {
  final StreamController<TrainingState> _exercisesController =
      StreamController<TrainingState>();

  Stream<TrainingState> get exercisesStream => _exercisesController.stream;

  final TrainingState _state = TrainingState();

  TrainingState get state => _state;

  void addExercise(SetTasksState exercise) {
    state.exercises.add(exercise);
    _exercisesController.add(state);
  }

  void dispose() {
    _exercisesController.close();
  }
}
