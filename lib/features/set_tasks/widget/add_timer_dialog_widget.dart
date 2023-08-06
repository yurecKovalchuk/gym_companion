import 'package:flutter/material.dart';

import 'package:timer_bloc/models/models.dart';

class AddTimerExercises extends StatefulWidget {
  const AddTimerExercises({super.key});

  @override
  State<AddTimerExercises> createState() => _AddTimerExercisesState();
}

class _AddTimerExercisesState extends State<AddTimerExercises> {
  final TextEditingController _textEditingController = TextEditingController();

  TimerType selectedType = TimerType.exercise;

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
              value: TimerType.exercise,
              groupValue: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),
            const Text('Exercise'),
            Radio<TimerType>(
              value: TimerType.rest,
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
