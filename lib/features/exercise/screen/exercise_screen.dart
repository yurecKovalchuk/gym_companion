import 'package:flutter/material.dart';

import 'package:timer_bloc/style/style.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(decoration: MainBackgroundDecoration.backgroundDecoration,
    child: const Column(
        children: [

        ],
    ),),);
  }
}
