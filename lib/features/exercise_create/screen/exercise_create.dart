import 'package:flutter/material.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';

class ExerciseCreate extends StatefulWidget {
  const ExerciseCreate({
    super.key,
  });

  @override
  State<ExerciseCreate> createState() => _ExerciseCreateState();
}

class _ExerciseCreateState extends State<ExerciseCreate> {
  final ExerciseCreateBloc _exerciseCreateBloc = ExerciseCreateBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _exerciseCreateBloc.streamSetTasks,
        builder: (context, snapshot) {
          return Column(
            children: [
              TextField(
                onChanged: (name) {
                  _exerciseCreateBloc.setExercisesName(name);
                },
                decoration: const InputDecoration(
                  labelText: 'Назва вправи',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _exerciseCreateBloc.state.exercise.approaches.length,
                itemBuilder: (context, index) {
                  final timer = _exerciseCreateBloc.state.exercise.approaches[index];
                  return ListTile(
                    title: Text(timer.value.toString()),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _exerciseCreateBloc.state.exercise);
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
      _exerciseCreateBloc.setExercisesTime(
        time,
        type,
      );
    }
  }
}
