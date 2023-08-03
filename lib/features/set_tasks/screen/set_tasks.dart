import 'package:flutter/material.dart';

import 'package:timer_bloc/features/set_tasks/set_tasks.dart';
import 'package:timer_bloc/models/models.dart';

class SetTasks extends StatefulWidget {
  const SetTasks({super.key});

  @override
  State<SetTasks> createState() => _SetTasksState();
}

class _SetTasksState extends State<SetTasks> {
  SetTasksBloc setTasksBloc = SetTasksBloc();

  @override
  void initState() {
    setTasksBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: setTasksBloc.streamSetTasks,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                onChanged: (name) {
                  setTasksBloc.getName(name);
                },
                decoration: const InputDecoration(
                  labelText: 'Назва вправи',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: setTasksBloc.state.exerciseTime.length,
                itemBuilder: (context, index) {
                  final timer = setTasksBloc.state.exerciseTime[index];
                  return ListTile(
                    title: Text(timer.toString()),
                  );
                },
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return const AddTimerExercises();
      },
    );
    if (result != null) {
      setTasksBloc.getTime(result);
    }
  }
}
