import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:timer_bloc/models/models.dart';

class DataSource {
  Future<void> saveExercises(List<Exercise> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    final exercisesJson = exercises.map((exercise) => exercise.toJson()).toList();
    await prefs.setString('exercises', jsonEncode(exercisesJson));
  }

  Future<List<Exercise>> loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final exercisesJson = prefs.getString('exercises');
    if (exercisesJson != null) {
      final exercisesList = jsonDecode(exercisesJson) as List;
      final exercises = exercisesList.map<Exercise>((exerciseJson) => Exercise.fromJson(exerciseJson)).toList();
      return exercises;
    }
    return [];
  }
}
