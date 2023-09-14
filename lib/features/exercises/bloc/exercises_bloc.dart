import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisesBloc extends Cubit<ExercisesState> {
  ExercisesBloc() : super(ExercisesState([]));

  void addExercise(Exercise exercise) {
    if (exercise.name.isNotEmpty) {
      state.exercises.add(exercise);
      emit(
        state.copyWith(exercises: state.exercises),
      );
    }
  }

  Future<void> saveExercises(List<Exercise> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    final exercisesJson = exercises.map((exercise) => exercise.toJson()).toList();
    await prefs.setString('exercises', jsonEncode(exercisesJson));
  }

  void loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final exercisesJson = prefs.getString('exercises');
    if (exercisesJson != null) {
      final exercisesList = jsonDecode(exercisesJson) as List;
      final exercises = exercisesList
          .map<Exercise>((exerciseJson) => Exercise.fromJson(exerciseJson))
          .toList();
      emit(state.copyWith(exercises: exercises));
    }
  }
}
