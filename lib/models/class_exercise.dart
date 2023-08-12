import 'package:timer_bloc/models/models.dart';

class Exercise {
  Exercise(
    this.name,
    this.approaches,
  );

  String name;
  List<Approach> approaches;
}

class Approach {
  Approach(
    this.value,
    this.type,
  );

  int value;
  ApproachType type;
}
