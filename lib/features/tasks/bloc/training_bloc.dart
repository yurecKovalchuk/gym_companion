import 'dart:async';

import 'package:timer_bloc/features/tasks/tasks.dart';

class TrainingBloc {
  final StreamController<TrainingState> _exercisesController =
      StreamController<TrainingState>();

  Stream<TrainingState> get exercisesStream => _exercisesController.stream;

  TrainingState state = TrainingState();

  TrainingBloc() {
    _addDataList();
  }

  //TODO: temporary variable
  void _addDataList() {
    state.exercises.addAll(_getDataList());
    _exercisesController.add(state);
  }

  void addExercise(Exercise exercise) {
    state.exercises.add(exercise);
    _exercisesController.add(state);
  }

//TODO: temporary variable
  List<Exercise> _getDataList() {
    return [
      Exercise("Name1", 100),
      Exercise("Nam2e1", 100),
      Exercise("Namew1", 100),
      Exercise("Name1w", 100),
      Exercise("Namee1", 100),
    ];
  }

  void dispose() {
    _exercisesController.close();
  }
}

