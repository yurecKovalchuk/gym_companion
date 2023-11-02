import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/localization/localization.dart';

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
  ExerciseCreateBloc get _exerciseCreateBloc => BlocProvider.of<ExerciseCreateBloc>(context);

  late final TextEditingController _nameEditingController = TextEditingController(
    text: _exerciseCreateBloc.state.exercise.name,
  );
  late final TextEditingController _descriptionEditingController = TextEditingController(
    text: _exerciseCreateBloc.state.exercise.description,
  );

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () => saveValidation(),
            child: Text(
              context.l10n.saveExercise,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 16.0,
          right: 16.0,
        ),
        child: BlocConsumer<ExerciseCreateBloc, ExerciseCreateState>(
          builder: (context, state) {
            if (state.status == ExercisesCreateScreenStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == ExercisesCreateScreenStatus.error) {
              return Center(
                  child: Text(
                state.errorMessage.toString(),
              ));
            } else {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _nameEditingController,
                    maxLength: 24,
                    onChanged: (name) {
                      _exerciseCreateBloc.setExercisesName(
                        name,
                      );
                    },
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(),
                      labelText: context.l10n.exerciseName,
                      suffixIconColor: Theme.of(context).colorScheme.primary,
                      suffixIcon: InkWell(
                        child: const Icon(Icons.close),
                        onTap: () {
                          _exerciseCreateBloc.setExercisesName('');
                          _nameEditingController.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _descriptionEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 164,
                    onChanged: (description) {
                      _exerciseCreateBloc.setExerciseDescription(
                        description,
                      );
                    },
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(),
                      labelText: context.l10n.exerciseDescription,
                      suffixIconColor: Theme.of(context).colorScheme.primary,
                      suffixIcon: InkWell(
                        child: const Icon(Icons.close),
                        onTap: () {
                          _exerciseCreateBloc.setExerciseDescription('');
                          _descriptionEditingController.clear();
                        },
                      ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                        ),
                        onPressed: () => _showAddTaskDialog(),
                        child: Text(context.l10n.buttonAddApproach),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
          listener: (context, state) {
            if (state.status == ExercisesCreateScreenStatus.success) {
              Navigator.pop(context);
            }
            if (state.status == ExercisesCreateScreenStatus.loading) {
              const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state.status == ExercisesCreateScreenStatus.error) {
              Scaffold(
                body: Center(
                  child: Text(state.errorMessage.toString()),
                ),
              );
            }
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
          title: Center(
            child: Text(context.l10n.warningTitle),
          ),
          content: Text(context.l10n.warningContent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.l10n.textButtonClose),
            ),
          ],
        );
      },
    );
  }

  void saveValidation() async {
    final Exercise currentExercise = _exerciseCreateBloc.state.exercise;
    if (currentExercise.name.isNotEmpty && currentExercise.approaches.isNotEmpty) {
      if (currentExercise.id == null) {
        _exerciseCreateBloc.addExercise(currentExercise);
      } else {
        _exerciseCreateBloc.updateExercise(currentExercise);
      }
    } else {
      _showWarningDialog();
    }
  }
}
