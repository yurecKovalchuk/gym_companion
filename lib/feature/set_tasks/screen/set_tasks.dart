import 'package:flutter/material.dart';

import 'package:timer_bloc/feature/tasks/tasks.dart';

class SetTasks extends StatefulWidget {
  final TrainingBloc trainingBloc;

  SetTasks({required this.trainingBloc});

  @override
  _SetTasksState createState() => _SetTasksState();
}

class _SetTasksState extends State<SetTasks> {
  String exerciseName = '';
  int exerciseTime = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (name) {
              setState(() {
                exerciseName = name;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Назва вправи',
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (time) {
              setState(() {
                exerciseTime = int.tryParse(time) ?? 0;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Час тренування',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final exercise = Exercise(exerciseName, exerciseTime);
              widget.trainingBloc.addExercise(exercise);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
