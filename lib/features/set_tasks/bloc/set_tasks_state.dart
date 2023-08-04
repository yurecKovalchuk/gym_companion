class SetTasksState {
  SetTasksState(
    this.exerciseName,
    this.timerTime,
  );

  String exerciseName;
  List<TimerEntry> timerTime;

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

