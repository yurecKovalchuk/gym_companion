import 'package:flutter/material.dart';

import 'package:timer_bloc/feature/set_tasks/set_tasks.dart';
import 'package:timer_bloc/feature/tasks/tasks.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TrainingBloc trainingBloc = TrainingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: trainingBloc.exercisesStream,
        initialData: [],
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: trainingBloc.state!.exercises.length,
            itemBuilder: (context, index) {
              final exercise = trainingBloc.state!.exercises[index];
              return ListTile(
                title: Text("${exercise.name}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SetTasks(trainingBloc: trainingBloc),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    trainingBloc.dispose();
    super.dispose();
  }
}
