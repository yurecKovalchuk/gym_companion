import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisePlayBloc extends Cubit<ExercisePlayState> {
  ExercisePlayBloc(Exercise exercise)
      : super(
          ExercisePlayState(
            exercise: exercise,
            approachesIndex: 0,
            approachLeftTime: exercise.approaches[0].value,
            approachesLeftTime: exercise.approaches.map((e) => e.value).toList(),
            isActiveExercise: false,
          ),
        );

  Timer? _timer;
  Timer? _approachTimer;

  void playExercise() {
    emit(state.copyWith(isActiveExercise: true));
    _cancelPlayTimer();
    _cancelApproachTimer();

    _playApproachTimer(state.approachesIndex);

    _timer = Timer.periodic(
      _manageApproachSeconds(),
      (timer) {
        final approachesCount = state.exercise.approaches.length - 1;
        final isApproachAvailable = state.approachesIndex < approachesCount;

        isApproachAvailable ? _switchCurrentApproach() : _stopPlayExercise();
      },
    );
  }

  void stopExerciseTimer() {
    _cancelApproachTimer();
    _cancelPlayTimer();
    emit(state.copyWith(
      isActiveExercise: false,
      approachLeftTime: state.approachesLeftTime[state.approachesIndex],
    ));
  }

  void _stopPlayExercise() {
    _resetApproachesLeftTime();
    _cancelApproachTimer();
    _cancelPlayTimer();
    emit(state.copyWith(isActiveExercise: false));
  }

  void _switchCurrentApproach() {
    emit(state.copyWith(
      approachesIndex: ++state.approachesIndex,
      approachLeftTime: 0,
    ));
    playExercise();
  }

  Duration _manageApproachSeconds() => Duration(
        seconds: state.approachLeftTime == 0
            ? state.exercise.approaches[state.approachesIndex].value
            : state.approachLeftTime,
      );

  void _resetApproachesLeftTime() {
    final List<int> newApproachesLeftTime = state.exercise.approaches.map((e) => e.value).toList();
    emit(state.copyWith(
      approachesIndex: 0,
      approachesLeftTime: newApproachesLeftTime,
    ));
  }

  void _playApproachTimer(int approachesIndex) {
    _approachTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.approachesLeftTime[approachesIndex] > 0) {
          final List<int> newApproachesLeftTime = List.from(state.approachesLeftTime);
          newApproachesLeftTime[approachesIndex]--;
          emit(state.copyWith(approachesLeftTime: newApproachesLeftTime));
        } else {
          _cancelApproachTimer();
        }
      },
    );
  }

  void _cancelApproachTimer() {
    _approachTimer?.cancel();
    _approachTimer = null;
  }

  void _cancelPlayTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
