import 'package:equatable/equatable.dart';

import 'package:timer_bloc/models/models.dart';

class Exercise extends Equatable {
  const Exercise({
    this.id,
    required this.name,
    required this.approaches,
    this.description = '',
  });

  final String? id;
  final String name;
  final List<Approach> approaches;
  final String description;

  Exercise copyWith({
    String? name,
    List<Approach>? approaches,
    String? description,
    String? id,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      approaches: approaches ?? this.approaches,
      description: description ?? this.description,
    );
  }

  factory Exercise.initial() {
    return const Exercise(
      description: '',
      name: '',
      approaches: [],
      id: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'approaches': approaches.map((approach) => approach.toMap()).toList(),
    };
  }

  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        approaches = (json['approaches'] as List).map((approachJson) => Approach.fromMap(approachJson)).toList();

  @override
  List<Object?> get props => [id, name, description, approaches];
}

class Approach {
  Approach(
    this.id,
    this.value,
    this.type,
  );

  String? id;
  int value;
  ApproachType type;

  Approach copyWith({
    String? id,
    int? value,
    ApproachType? type,
  }) {
    return Approach(
      id ?? this.id,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'value': value.toString(),
      'type': type.name,
    };
  }

  factory Approach.fromMap(Map<String, dynamic> map) {
    return Approach(
      (map['id']),
      int.parse(map['value']),
      map['type'] == 'exercise' ? ApproachType.exercise : ApproachType.rest,
    );
  }
}
