import 'package:flutter/material.dart';

import 'package:timer_bloc/features/set_tasks/set_tasks.dart';

class AddTimerExercises extends StatefulWidget {
  const AddTimerExercises({super.key});

  @override
  State<AddTimerExercises> createState() => _AddTimerExercisesState();
}

class _AddTimerExercisesState extends State<AddTimerExercises> {
  final TextEditingController _textEditingController = TextEditingController();

  SetTasksBloc setTasksBloc = SetTasksBloc();

  @override
  void initState() {
    setTasksBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set timer'),
      content: TextField(
        controller: _textEditingController,
        decoration: const InputDecoration(
          labelText: 'time',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              final title = _textEditingController.text;
              Navigator.pop(context, title);
            });},
          child: Text('add'),
        ),
      ],
    );
  }
}
