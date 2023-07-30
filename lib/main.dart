import 'package:flutter/material.dart';

import 'package:timer_bloc/feature/tasks/tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TasksScreen());
  }
}
