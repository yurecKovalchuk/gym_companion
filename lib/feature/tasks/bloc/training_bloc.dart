import 'dart:async';

import 'package:timer_bloc/feature/tasks/tasks.dart';

class TrainingBloc {
  final StreamController<TrainingState> _exercisesController =
      StreamController<TrainingState>();

  Stream<TrainingState> get exercisesStream => _exercisesController.stream;

  TrainingState state = TrainingState();

  void addExercise(Exercise exercise) {
    state.exercises.add(exercise);
    _exercisesController.add(state);
  }

  void dispose() {
    _exercisesController.close();
  }
}

class TrainingState {
  final List<Exercise> exercises = [];
}
