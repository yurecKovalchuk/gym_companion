class SetTasksState {
  SetTasksState(
    this.exerciseName,
    this.time,
  );

  String exerciseName;
  List<TimerEntry> time;
}

class TimerEntry {
  int value;
  TimerType type;

  TimerEntry(this.value, this.type);
}

enum TimerType {
  Exercise,
  Rest,
}

