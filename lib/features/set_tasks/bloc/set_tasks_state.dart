class SetTasksState {
  SetTasksState(
    this.exerciseName,
    this.time,
  );

  String exerciseName;
  List<TimerEntry> time;
}

class TimerEntry {
  TimerEntry(
    this.value,
    this.type,
  );

  int value;
  TimerType type;
}

enum TimerType {
  Exercise,
  Rest,
}
