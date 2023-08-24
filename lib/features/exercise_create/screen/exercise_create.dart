import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/models/models.dart';

class ExerciseCreate extends StatefulWidget {
  const ExerciseCreate({
    super.key,
  });

  @override
  State<ExerciseCreate> createState() => _ExerciseCreateState();
}

class _ExerciseCreateState extends State<ExerciseCreate> {
  final ExerciseCreateBloc _exerciseCreateBloc = ExerciseCreateBloc();

  final TextEditingController _textEditingControllerName = TextEditingController();
  final TextEditingController _textEditingControllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 180, 170, 103),
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () {
              saveValidation();
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          right: 16.0,
        ),
        child: BlocBuilder<ExerciseCreateBloc, ExerciseCreateState>(
          bloc: _exerciseCreateBloc,
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textEditingControllerName,
                  maxLength: 24,
                  onChanged: (name) {
                    _exerciseCreateBloc.setExercisesName(
                      name,
                    );
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Exercise Name',
                    labelStyle: const TextStyle(color: Colors.black26),
                    suffixIcon: state.exercise.name.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _textEditingControllerName.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _textEditingControllerDescription,
                  maxLength: 164,
                  onChanged: (description) {
                    _exerciseCreateBloc.setExerciseDescription(
                      description,
                    );
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Colors.black26),
                    suffixIcon: state.exercise.description.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _textEditingControllerDescription.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ContainerApproachesList(
                  approaches: state.exercise.approaches,
                  onDeleteApproach: (Approach approach) => _exerciseCreateBloc.deleteApproach(approach),
                  onEditApproach: (Approach approach) => _showAddTaskDialog(approach),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 180, 170, 103),
                    ),
                    child: const Text('ADD APPROACH'),
                    onPressed: () => _showAddTaskDialog(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showAddTaskDialog([Approach? approach]) async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (context) => ShowModalBottomSheetSetApproaches(
        value: approach?.value,
        type: approach?.type,
      ),
    );
    if (result != null) {
      final time = result['timer'];
      final type = result['type'];

      if (approach == null) {
        _exerciseCreateBloc.setExercisesTime(
          time,
          type,
        );
      } else {
        _exerciseCreateBloc.updateApproach(
          approach,
          time,
          type,
        );
      }
    }
  }

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Warning')),
          content: const Text('Enter the name of the exercise and the approaches you want to perform'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void saveValidation() {
    if (_exerciseCreateBloc.state.exercise.name.isNotEmpty &&
        _exerciseCreateBloc.state.exercise.approaches.isNotEmpty) {
      Navigator.pop(context, _exerciseCreateBloc.state.exercise);
    } else {
      _showWarningDialog();
    }
  }
}
