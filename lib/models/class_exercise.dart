import 'package:equatable/equatable.dart';
import 'package:timer_bloc/models/models.dart';

class Exercise extends Equatable {
  Exercise({
    required this.id,
    required this.name,
    required this.approaches,
    this.description = '',
  });

  int id;
  String name;
  List<Approach> approaches;
  String description;

  Exercise copyWith({
    String? name,
    List<Approach>? approaches,
    String? description,
    int? id,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      approaches: approaches ?? this.approaches,
      description: description ?? this.description,
    );
  }

  factory Exercise.initial() {
    return Exercise(
      description: '',
      name: '',
      approaches: const [],
      id: DateTime.now().microsecondsSinceEpoch,
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
  List<Object> get props => [id, name, description, approaches];
}

class Approach {
  Approach(
    this.id,
    this.value,
    this.type,
  );

  int id = DateTime.now().microsecondsSinceEpoch;
  int value;
  ApproachType type;

  Approach copyWith({
    int? id,
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
      'id': id,
      'value': value,
      'type': type.name,
    };
  }

  factory Approach.fromMap(Map<String, dynamic> map) {
    return Approach(
      map['id'] as int,
      map['value'] as int,
      map['type'] == 'exercise' ? ApproachType.exercise : ApproachType.rest,
    );
  }
}
