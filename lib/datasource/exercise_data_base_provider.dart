import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:timer_bloc/models/models.dart';

class ExerciseDatabaseProvider {
  late Database _database;

  Future<Database> get database async {
    return _database;
  }

  Future<void> open(String path) async {
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<Database> initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'exercise_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return _database;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exercises(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE approaches(
        id TEXT,
        exercise_id TEXT,
        value TEXT,
        type TEXT,
        FOREIGN KEY (exercise_id) REFERENCES exercises (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<void> insertExercises(List<Exercise> exercises) async {
    final db = await database;

    await db.transaction((txn) async {
      final batch = txn.batch();

      for (var exercise in exercises) {
        final existingExercise = await txn.query(
          'exercises',
          where: 'id = ?',
          whereArgs: [exercise.id],
        );

        if (existingExercise.isEmpty) {
          batch.insert('exercises', {
            'id': exercise.id,
            'name': exercise.name,
            'description': exercise.description,
          });

          final exerciseId = exercise.id ?? '';

          for (var approach in exercise.approaches) {
            batch.insert('approaches', {
              'id': approach.id,
              'exercise_id': exerciseId,
              'value': approach.value.toString(),
              'type': approach.type.name.toString(),
            });
          }
        }
      }
      await batch.commit();
    });
  }

  Future<List<Exercise>> getExercises() async {
    final db = await database;
    final List<Map<String, dynamic>> exerciseMaps = await db.query('exercises');

    final exercises = await Future.wait(
      exerciseMaps.map((exerciseMap) async {
        final List<Map<String, dynamic>> approachMaps = await db.query(
          'approaches',
          where: 'exercise_id = ?',
          whereArgs: [exerciseMap['id']],
        );

        final approaches = approachMaps.map((approachMap) {
          return Approach(
            approachMap['id'],
            (approachMap['value']),
            approachMap['type'] == 'exercise' ? ApproachType.exercise : ApproachType.rest,
          );
        }).toList();

        return Exercise(
          id: exerciseMap['id'],
          name: exerciseMap['name'],
          description: exerciseMap['description'],
          approaches: approaches,
        );
      }),
    );
    return exercises;
  }

  Future<void> deleteExercise(String id) async {
    final db = await database;
    await db.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.delete(
      'approaches',
      where: 'exercise_id = ?',
      whereArgs: [id],
    );
  }
}
