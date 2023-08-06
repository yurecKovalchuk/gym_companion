import 'package:flutter/material.dart';

import 'package:timer_bloc/features/set_tasks/set_tasks.dart';

class SetTasks extends StatefulWidget {
  const SetTasks({super.key});

  @override
  State<SetTasks> createState() => _SetTasksState();
}

class _SetTasksState extends State<SetTasks> {
  SetTasksBloc setTasksBloc = SetTasksBloc();

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
                  setTasksBloc.setExercisesName(name);
                },
                decoration: const InputDecoration(
                  labelText: 'Назва вправи',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: setTasksBloc.state.time.length,
                itemBuilder: (context, index) {
                  final timer = setTasksBloc.state.time[index];
                  return ListTile(
                    title: Text(timer.value.toString()),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, setTasksBloc.exercise);
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
      final time = result['timer'];
      final type = result['type'];
      setTasksBloc.setExercisesTime(time, type);
    }
  }
}
