import 'dart:async';

import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisePlayBloc {
  ExercisePlayBloc(Exercise exercise)
      : _state = ExercisePlayState(
          exercise: exercise,
          approachesIndex: 0,
          exercise.approaches[0].value,
          approachesLeftTime: exercise.approaches.map((e) => e.value).toList(),
          false,
          0,
        );

  final ExercisePlayState _state;

  final StreamController<ExercisePlayState> _streamController =
      StreamController<ExercisePlayState>();

  Stream<ExercisePlayState> get streamExercise => _streamController.stream;

  ExercisePlayState get state => _state;

  Timer? _timer;
  Timer? _approachTimer;

  void playExercise() {
    state.isActiveExercise = true;
    _canselPlayTimer();
    _canselApproachTimer();

    _playApproachTimer(state.approachesIndex);

    _timer = Timer.periodic(
      _manageApproachSeconds(),
      (timer) {
        final approachesCount = state.exercise.approaches.length - 1;
        final isApproachAvailable = state.approachesIndex < approachesCount;

        isApproachAvailable ? _switchCurrentApproach() : _stopPlayExercise();
      },
    );
    _streamController.sink.add(state);
  }

  void stopExerciseTimer() {
    _canselApproachTimer();
    _canselPlayTimer();
    state.isActiveExercise = false;
    state.approachLeftTime = state.approachesLeftTime[state.approachesIndex];
    _streamController.sink.add(state);
  }

  void _stopPlayExercise() {
    _resetApproachesLeftTime();
    _canselApproachTimer();
    _canselPlayTimer();
    state.isActiveExercise = false;
  }

  void _switchCurrentApproach() {
    state.approachesIndex++;
    playExercise();
    state.approachLeftTime = 0;
  }

  Duration _manageApproachSeconds() => Duration(
        seconds: state.approachLeftTime == 0
            ? state.exercise.approaches[state.approachesIndex].value
            : state.approachLeftTime,
      );

  void _resetApproachesLeftTime() {
    state.approachesIndex = 0;
    state.approachesLeftTime.clear();
    state.approachesLeftTime.addAll(
      state.exercise.approaches.map((e) => e.value).toList(),
    );
  }

  void _playApproachTimer(int approachesIndex) {
    _approachTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.approachesLeftTime[approachesIndex] > 0) {
          state.approachesLeftTime[approachesIndex]--;
        } else {
          _canselApproachTimer();
        }
        _streamController.sink.add(state);
      },
    );
  }

  void _canselApproachTimer() {
    _approachTimer?.cancel();
    _approachTimer = null;
  }

  void _canselPlayTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _canselApproachTimer();
    _canselPlayTimer();
    _streamController.close();
  }
}
