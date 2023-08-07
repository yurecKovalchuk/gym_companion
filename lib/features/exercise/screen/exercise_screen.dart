import 'package:flutter/material.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/features/exercise/exercise.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final TrainingBloc _trainingBloc = TrainingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _trainingBloc.exercisesStream,
        initialData: const [],
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: _trainingBloc.state.exercises.length,
            itemBuilder: (context, index) {
              final exercise = _trainingBloc.state.exercises[index];
              return ListTile(
                title: Text(exercise.name),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _navigatorPush();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigatorPush() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExerciseCreate(),
      ),
    );
    if (result != null) {
      _trainingBloc.addExercise(result);
    }
  }

  @override
  void dispose() {
    _trainingBloc.dispose();
    super.dispose();
  }
}
