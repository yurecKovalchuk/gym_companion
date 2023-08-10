import 'package:flutter/material.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/features/exercise/exercise.dart';
import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/style/style.dart';

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
      body: Container(
        decoration: MainBackgroundDecoration.backgroundDecoration,
        child: StreamBuilder(
          stream: _trainingBloc.exercisesStream,
          initialData: const [],
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: _trainingBloc.state.exercises.length,
              itemBuilder: (context, index) {
                final exercise = _trainingBloc.state.exercises[index];
                return ListTile(
                    title: Text(exercise.name),
                    onTap: () {
                      _navigatorPushToPlay(index);
                    });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _navigatorPushToCreate();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigatorPushToCreate() async {
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

  void _navigatorPushToPlay(int index) {
     if (_trainingBloc.state.exercises[index].approaches.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (
            context,
          ) =>
              ExercisePlay(exercise: _trainingBloc.state.exercises[index]),
        ),
      );
     }
  }

  @override
  void dispose() {
    _trainingBloc.dispose();
    super.dispose();
  }
}
