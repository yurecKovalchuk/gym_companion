import 'package:timer_bloc/models/models.dart';

class Exercise {
  Exercise(
    this.description, {
    required this.name,
    required this.approaches,
  });

  String name;
  List<Approach> approaches;
  String description;

  Exercise copyWith({
    String? name,
    List<Approach>? approaches,
    String? description,
  }) {
    return Exercise(
      name: name ?? this.name,
      approaches: approaches ?? this.approaches,
      description ?? this.description,
    );
  }
}

class Approach {
  Approach(
      this.value,
      this.type,
      ) {
    id = DateTime.now().microsecondsSinceEpoch;
  }

  late int id;
  int value;
  ApproachType type;

  Approach copyWith({
    int? value,
    ApproachType? type,
  }) {
    return Approach(
      value ?? this.value,
      type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Approach &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              value == other.value &&
              type == other.type;

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ type.hashCode;
}
