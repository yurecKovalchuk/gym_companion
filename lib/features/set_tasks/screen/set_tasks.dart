import 'package:flutter/material.dart';

import 'package:timer_bloc/features/tasks/tasks.dart';
import 'package:timer_bloc/features/set_tasks/set_tasks.dart';

class SetTasks extends StatelessWidget {
  SetTasks({
    super.key,
  });


  SetTasksBloc setTasksBloc = SetTasksBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (name) {
              setTasksBloc.getName(name);
            },
            decoration: const InputDecoration(
              labelText: 'Назва вправи',
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (time) {
              setTasksBloc.getTime(time);
            },
            decoration: const InputDecoration(
              labelText: 'Час тренування',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final exercise = Exercise(
                setTasksBloc.state.exerciseName,
                setTasksBloc.state.exerciseTime,
              );
              Navigator.pop(context, exercise);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}