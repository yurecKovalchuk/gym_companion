import 'package:timer_bloc/models/models.dart';

class ExercisePlayState {
  ExercisePlayState(
    this.seconds,
    this.isActiveTimer,
    this.slotLeftTime, {
    required this.exercise,
    required this.approachesIndex,
    required this.approachesLeftTime,
  });

  final Exercise exercise;
  final List<int> approachesLeftTime;

  int approachesIndex;
  int seconds;
  bool isActiveTimer;
  int slotLeftTime;
}
