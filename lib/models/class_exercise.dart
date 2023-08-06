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
  TypeTimer type;
}

class TypeTimer {
  TypeTimer(
    this.Exercise,
    this.Rest,
  );

  String Exercise;
  String Rest;
}
