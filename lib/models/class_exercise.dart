import 'package:timer_bloc/models/models.dart';

class Exercise {
  Exercise(
    this.name,
    this.time,
  );

  String name;
  List<Approach> time;
}

class Approach {
  Approach(
    this.value,
    this.type,
  );

  int value;
  ApproachType type;
}
git