import 'dart:async';

import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisePlayBloc {
  ExercisePlayBloc(Exercise exercise)
      : _state = ExercisePlayState(
            exercise: exercise,
            approachesIndex: 0,
            exercise.approaches[0].value,
            approachesLeftTime:
                exercise.approaches.map((e) => e.value).toList(),
            false,
            0);

  final ExercisePlayState _state;

  final StreamController<ExercisePlayState> _streamController =
      StreamController<ExercisePlayState>();

  Stream<ExercisePlayState> get streamExercise => _streamController.stream;

  ExercisePlayState get state => _state;

  Timer? _timer;
  Timer? _timerSlot;

  void startTimer() {
    state.isActiveTimer = true;
    _canselTimer();
    _canselSlotTimer();

    _playSlotTimer(state.approachesIndex);

    _timer = Timer.periodic(
      Duration(
          seconds: state.slotLeftTime == 0
              ? state.exercise.approaches[state.approachesIndex].value
              : state.slotLeftTime),
      (timer) {
        if (state.approachesIndex < state.exercise.approaches.length - 1) {
          state.approachesIndex++;
          startTimer();
          state.slotLeftTime = 0;
        } else {
          _resetApproachesLeftTime();
          _canselSlotTimer();
          _canselTimer();
          state.isActiveTimer = false;
        }
      },
    );
    _streamController.sink.add(state);
  }

  void _resetApproachesLeftTime() {
    state.approachesIndex = 0;
    state.approachesLeftTime.clear();
    state.approachesLeftTime.addAll(
      state.exercise.approaches.map((e) => e.value).toList(),
    );
  }

  void _playSlotTimer(int approachesIndex) {
    _timerSlot = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.approachesLeftTime[approachesIndex] > 0) {
          state.approachesLeftTime[approachesIndex]--;
        } else {
          _canselSlotTimer();
        }
        _streamController.sink.add(state);
      },
    );
  }

  void _canselSlotTimer() {
    _timerSlot?.cancel();
    _timerSlot = null;
  }

  void _canselTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void stopExerciseTimer() {
    _canselSlotTimer();
    _canselTimer();
    state.isActiveTimer = false;
    state.slotLeftTime = state.approachesLeftTime[state.approachesIndex];
    _streamController.sink.add(state);
  }

  void dispose() {
    _canselSlotTimer();
    _canselTimer();
    _streamController.close();
  }
}
