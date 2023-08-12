import 'package:flutter/material.dart';

import 'package:timer_bloc/models/models.dart';

class AddTimerExercises extends StatefulWidget {
  const AddTimerExercises({super.key});

  @override
  State<AddTimerExercises> createState() => _AddTimerExercisesState();
}

class _AddTimerExercisesState extends State<AddTimerExercises> {
  final TextEditingController _textEditingController = TextEditingController();

  ApproachType selectedType = ApproachType.exercise;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set timer'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: Column(children: [
          TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: _textEditingController,
            decoration: const InputDecoration(
              labelText: 'time',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<ApproachType>(
                value: ApproachType.exercise,
                groupValue: selectedType,
                onChanged: (value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
              ),
              const Text('Exercise'),
              Radio<ApproachType>(
                value: ApproachType.rest,
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
      ),
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
          child: const Text(
            'add',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }
}
