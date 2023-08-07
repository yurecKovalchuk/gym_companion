import 'dart:async';

import 'package:timer_bloc/features/exercise/exercise.dart';
import 'package:timer_bloc/models/models.dart';

class TrainingBloc {
  final StreamController<TrainingState> _exercisesController =
      StreamController<TrainingState>();

  Stream<TrainingState> get exercisesStream => _exercisesController.stream;

  final TrainingState _state = TrainingState();

  TrainingState get state => _state;

  void addExercise(Exercise exercise) {
    state.exercises.add(exercise);
    _exercisesController.add(state);
  }

  void dispose() {
    _exercisesController.close();
  }
}
