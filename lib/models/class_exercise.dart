import 'package:timer_bloc/models/models.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.approaches,
  });

  String name;
  List<Approach> approaches;

  Exercise copyWith({
    String? name,
    List<Approach>? approaches,
  }) {
    return Exercise(
      name: name ?? this.name,
      approaches: approaches ?? this.approaches,
    );
  }
}

class Approach {
  Approach(
    this.value,
    this.type,
  );

  int value;
  ApproachType type;
}
