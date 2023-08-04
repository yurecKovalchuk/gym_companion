import 'package:flutter/material.dart';

import 'package:timer_bloc/features/set_tasks/set_tasks.dart';

class AddTimerExercises extends StatefulWidget {
  const AddTimerExercises({super.key});

  @override
  State<AddTimerExercises> createState() => _AddTimerExercisesState();
}

class _AddTimerExercisesState extends State<AddTimerExercises> {
  final TextEditingController _textEditingController = TextEditingController();

  TimerType selectedType = TimerType.Exercise;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set timer'),
      content: Column(children: [
        TextField(
          keyboardType: TextInputType.number,
          controller: _textEditingController,
          decoration: const InputDecoration(
            labelText: 'time',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<TimerType>(
              value: TimerType.Exercise,
              groupValue: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),
            const Text('Exercise'),
            Radio<TimerType>(
              value: TimerType.Rest,
              groupValue: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),
            const Text('Rest'),
          ],
        ),
      ]),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              final timer = _textEditingController.text;
              Navigator.pop(context, {
                'timer': timer,
                'type': selectedType,
              });
            });
          },
          child: const Text('add'),
        ),
      ],
    );
  }
}
