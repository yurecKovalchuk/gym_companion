import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/models/models.dart';
import 'package:timer_bloc/style/style.dart';

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
      body: Container(
        decoration: MainBackgroundDecoration.backgroundDecoration,
        child: BlocBuilder(
         bloc: _exerciseCreateBloc,
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (name) {
                    _exerciseCreateBloc.setExercisesName(name);
                  },
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Exercise Name',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        _exerciseCreateBloc.state.exercise.approaches.length,
                    itemBuilder: (context, index) {
                      final timer =
                          _exerciseCreateBloc.state.exercise.approaches[index];
                      return ListTile(
                        title: Text('${timer.value.toString()} - ${timer.type == ApproachType.rest
                            ? 'Rest'
                            : 'Exercise'}'),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.purpleAccent),
                  ),
                  onPressed: () {
                    Navigator.pop(context, _exerciseCreateBloc.state.exercise);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
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
