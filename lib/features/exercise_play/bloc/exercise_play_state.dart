import 'package:timer_bloc/models/models.dart';

class ExercisePlayState {
  ExercisePlayState(
    this.seconds,
    this.isActiveExercise,
    this.approachLeftTime, {
    required this.exercise,
    required this.approachesIndex,
    required this.approachesLeftTime,
  });

  final Exercise exercise;
  final List<int> approachesLeftTime;

  int approachesIndex;
  int approachLeftTime;
  int seconds;
  bool isActiveExercise;
}
