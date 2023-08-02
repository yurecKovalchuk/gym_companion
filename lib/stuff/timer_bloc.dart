import 'dart:async';

import 'package:timer_bloc/stuff/timer_periodic.dart';

class TimerBloc {
  final StreamController<int> _timerStreamController = StreamController<int>();
  Timer? _timer;
  int _seconds = 0;
  int _timerLimit = 0;
  List<TimerPeriodic> timerPeriodic = [];

  Stream<int> get timerStream => _timerStreamController.stream;

  bool get isNotActive => _timer == null || !_timer!.isActive;

  bool get isActive => !isNotActive;

  void getTimerLimit(int timerLimit){
    _timerLimit = timerLimit;
  }

  void startTimer() {
    if (isNotActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        _timerStreamController.sink.add(_seconds);

        if(_timerLimit > 0 && _seconds >= _timerLimit){
          stopTimer();
        }
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _timerStreamController.sink.add(_seconds);
    timerPeriodic.add(TimerPeriodic(timerPeriodic.length+1, _seconds));
  }

  void resetTimerPeriodic(){
    timerPeriodic.clear();
  }

  void dispose() {
    _timerStreamController.close();
  }
}
