import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/localization/l10n/l10n.dart';

import 'package:timer_bloc/features/drawer/drawer.dart';
import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/models/models.dart';
import 'package:timer_bloc/app/app.dart';

const _editOnExercisePopupMenu = 'edit';
const _deleteOnExercisePopupMenu = 'delete';

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(context.l10n.projectName),
        ),
        drawer: const DrawerScreen(),
        body: BlocBuilder(
            bloc: _exerciseBloc,
            builder: (context, state) {
              if (_exerciseBloc.state.status == ExercisesScreenStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (_exerciseBloc.state.status == ExercisesScreenStatus.error) {
                return Center(
                  child: Text(_exerciseBloc.state.errorMessage.toString()),
                );
              } else {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  exercise.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 22.0),
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              itemBuilder: (context) => [
                                PopupMenuItem<String>(
                                  value: _editOnExercisePopupMenu,
                                  child: Text(context.l10n.popupMenuEdit),
                                ),
                                PopupMenuItem<String>(
                                  value: _deleteOnExercisePopupMenu,
                                  child: Text(context.l10n.popupMenuDelete),
                                ),
                              ],
                              onSelected: (value) => _popupMenu(value, exercise),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigatorPushToCreateScreen(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _popupMenu(String value, Exercise exercise) {
    if (value == _editOnExercisePopupMenu) {
      _onEditExercise(exercise);
    } else if (value == _deleteOnExercisePopupMenu) {
      _exerciseBloc.deleteExercise(exercise);
    }
  }

  void _navigatorPushToCreateScreen() async {
    await Navigator.pushNamed(context, routExerciseCreateScreen);
    _exerciseBloc.loadExercises();
  }

  void _navigatorPushToPlayScreen(int index) {
    if (_exerciseBloc.state.exercises[index].approaches.isNotEmpty) {
      Navigator.pushNamed(
        context,
        routExercisePlayScreen,
        arguments: _exerciseBloc.state.exercises[index],
      );
    }
  }

  void _onEditExercise(Exercise exercise) async {
    await Navigator.pushNamed(context, routExerciseCreateScreen, arguments: exercise);
    _exerciseBloc.loadExercises();
  }
}
