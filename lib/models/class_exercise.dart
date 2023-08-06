import 'package:timer_bloc/models/models.dart';

class Exercise {
  Exercise(
    this.name,
    this.time,
  );

  String name;
  List<SetTimer> time;
}

class SetTimer {
  SetTimer(
    this.value,
    this.type,
  );

  int value;
  TimerType type;
}
