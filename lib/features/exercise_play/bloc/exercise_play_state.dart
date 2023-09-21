import 'package:timer_bloc/models/models.dart';

class ExercisePlayState {
  ExercisePlayState({
    required this.isActiveExercise,
    required this.approachLeftTime,
    required this.exercise,
    required this.approachesIndex,
    required this.approachesLeftTime,
  });

  final Exercise exercise;
  final List<int> approachesLeftTime;
  int approachesIndex;
  int approachLeftTime;
  bool isActiveExercise;

  ExercisePlayState copyWith({
    Exercise? exercise,
    int? approachesIndex,
    List<int>? approachesLeftTime,
    bool? isActiveExercise,
    int? approachLeftTime,
  }) {
    return ExercisePlayState(
      exercise: exercise ?? this.exercise,
      approachesIndex: approachesIndex ?? this.approachesIndex,
      approachesLeftTime: approachesLeftTime ?? this.approachesLeftTime,
      isActiveExercise: isActiveExercise ?? this.isActiveExercise,
      approachLeftTime: approachLeftTime ?? this.approachLeftTime,
    );
  }
}
