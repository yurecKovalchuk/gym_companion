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
                return GestureDetector(
                  onTap: () {
                    _navigatorPushToPlayScreen(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      exercise.name,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () async {
          _navigatorPushToCreateScreen();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigatorPushToCreateScreen() async {
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

  void _navigatorPushToPlayScreen(int index) {
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
