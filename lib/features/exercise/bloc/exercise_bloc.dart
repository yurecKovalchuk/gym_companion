import 'dart:async';

import 'package:timer_bloc/features/exercise/exercise.dart';
import 'package:timer_bloc/models/models.dart';

class ExerciseBloc {
  final StreamController<ExerciseState> _exercisesController =
      StreamController<ExerciseState>();

  Stream<ExerciseState> get exercisesStream => _exercisesController.stream;

  final ExerciseState _state = ExerciseState();

  ExerciseState get state => _state;

  void addExercise(Exercise exercise) {
    if (exercise.name.isNotEmpty) {
      state.exercises.add(exercise);
      _exercisesController.add(state);
    }
  }

  void dispose() {
    _exercisesController.close();
  }
}
