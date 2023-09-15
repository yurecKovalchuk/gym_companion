import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/localization/localization.dart';

import 'package:timer_bloc/features/exercise_play/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';

class ExercisePlay extends StatefulWidget {
   const ExercisePlay({
    super.key,required this.exercisePlayBloc
  });

  final ExercisePlayBloc exercisePlayBloc;

  @override
  State<ExercisePlay> createState() => _ExercisePlayState();
}

class _ExercisePlayState extends State<ExercisePlay> {
  late final ExercisePlayBloc _exercisePlayBloc = widget.exercisePlayBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          _exercisePlayBloc.state.exercise.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
        ),
      ),
      body: BlocBuilder(
        bloc: _exercisePlayBloc,
        builder: (context, state) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: _exercisePlayBloc.state.exercise.approaches.length,
                itemBuilder: (context, index) {
                  final timer = _exercisePlayBloc.state.exercise.approaches[index];
                  return Card(
                    color: _generateSlotColorByState(index, timer),
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              textAlign: TextAlign.center,
                              timer.type == ApproachType.rest ? context.l10n.rest : context.l10n.exercise,
                            ),
                            subtitle: Text(
                              textAlign: TextAlign.center,
                              '${_exercisePlayBloc.state.approachesLeftTime[index]}/${timer.value.toString()} ${context.l10n.seconds}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () => _exercisePlayBloc.state.isActiveExercise
                    ? _exercisePlayBloc.stopExerciseTimer()
                    : _exercisePlayBloc.playExercise(),
                child: Text(
                  _exercisePlayBloc.state.isActiveExercise ? context.l10n.pause : context.l10n.go,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _generateSlotColorByState(int index, Approach timer) =>
      _exercisePlayBloc.state.approachesIndex == index && _exercisePlayBloc.state.isActiveExercise
          ? (timer.type == ApproachType.rest ? Colors.green : Colors.red)
          : Colors.white;
}
