import 'package:flutter/material.dart';

import 'package:timer_bloc/features/set_tasks/set_tasks.dart';
import 'package:timer_bloc/features/tasks/tasks.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TrainingBloc _trainingBloc = TrainingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _trainingBloc.exercisesStream,
        initialData: const [],
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: _trainingBloc.state!.exercises.length,
            itemBuilder: (context, index) {
              final exercise = _trainingBloc.state!.exercises[index];
              return ListTile(
                title: Text(exercise.name),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SetTasks(),
            ),
          );
          if (result != null) {
            _trainingBloc.addExercise(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _trainingBloc.dispose();
    super.dispose();
  }
}
