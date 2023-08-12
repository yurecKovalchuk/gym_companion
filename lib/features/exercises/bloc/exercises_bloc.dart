import 'dart:async';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc {
  final StreamController<ExercisesState> _exercisesController =
      StreamController<ExercisesState>();

  Stream<ExercisesState> get exercisesStream => _exercisesController.stream;

  final ExercisesState _state = ExercisesState();

  ExercisesState get state => _state;

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
