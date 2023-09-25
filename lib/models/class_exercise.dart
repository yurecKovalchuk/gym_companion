import 'package:timer_bloc/models/models.dart';

class Exercise {
  Exercise({
    required this.name,
    required this.approaches,
    this.description = '',
  }) {
    id = DateTime.now().microsecondsSinceEpoch;
  }

  late int id;
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
      description: description ?? this.description,
    );
  }

  factory Exercise.initial() {
    return Exercise(
      description: '',
      name: '',
      approaches: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'approaches': approaches.map((approach) => approach.toJson()).toList(),
    };
  }

  Exercise.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        approaches = (json['approaches'] as List).map((approachJson) => Approach.fromJson(approachJson)).toList();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          approaches == other.approaches &&
  id == other.id;

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ approaches.hashCode;
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

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'type': type.name,
    };
  }

  Approach.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        type = json['type'] == 'exercise' ? ApproachType.exercise : ApproachType.rest;

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
