import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/localization/l10n/l10n.dart';
import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({
    super.key,
  });

  @override
  ExerciseScreenState createState() => ExerciseScreenState();
}

class ExerciseScreenState extends State<ExerciseScreen> {
  ExercisesBloc get _exerciseBloc => BlocProvider.of<ExercisesBloc>(context);

  @override
  void initState() {
    _exerciseBloc.loadExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(context.l10n.projectName),
      ),
      body: BlocBuilder(
        bloc: _exerciseBloc,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: _exerciseBloc.state.exercises.length,
            itemBuilder: (context, index) {
              final exercise = _exerciseBloc.state.exercises[index];
              return GestureDetector(
                onTap: () {
                  _navigatorPushToPlayScreen(index);
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      exercise.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigatorPushToCreateScreen(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigatorPushToCreateScreen() async {
    final result = await Navigator.pushNamed(context, '/exerciseCreate') as Exercise;
    _exerciseBloc.addExercise(result);
  }

  void _navigatorPushToPlayScreen(int index) {
    if (_exerciseBloc.state.exercises[index].approaches.isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/exercisePlay',
        arguments: _exerciseBloc.state.exercises[index],
      );
    }
  }
}
