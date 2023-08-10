import 'package:flutter/material.dart';

import 'package:timer_bloc/features/exercise_play/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';

import 'package:timer_bloc/style/style.dart';

class ExercisePlay extends StatefulWidget {
  const ExercisePlay({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  State<ExercisePlay> createState() => _ExercisePlayState();
}

class _ExercisePlayState extends State<ExercisePlay> {
  late final ExercisePlayBloc _exercisePlayBloc =
      ExercisePlayBloc(widget.exercise);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MainBackgroundDecoration.backgroundDecoration,
        child: StreamBuilder(
          stream: _exercisePlayBloc.streamExercise,
          builder: (context, snapshot) {
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                     Text(
                        _exercisePlayBloc.state.exercise.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 30),
                      ),

                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        _exercisePlayBloc.state.exercise.approaches.length,
                    itemBuilder: (context, index) {
                      final timer =
                          _exercisePlayBloc.state.exercise.approaches[index];
                      return Container(
                        color: _exercisePlayBloc.state.approachesIndex == index && _exercisePlayBloc.state.isActiveTimer
                            ? (timer.type == ApproachType.rest
                                ? Colors.green
                                : Colors.red)
                            : Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text('${timer.value}'),
                                subtitle: Text(
                                  timer.type == ApproachType.rest
                                      ? 'Rest'
                                      : 'Exercise',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: Text(
                                '${_exercisePlayBloc.state.approachesLeftTime[index]}/${timer.value.toString()}',
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 15,),
                ElevatedButton(
                    onPressed: () {
                      _exercisePlayBloc.state.isActiveTimer
                          ? _exercisePlayBloc.stopExerciseTimer()
                          : _exercisePlayBloc.startTimer();
                    },
                    child: Text(_exercisePlayBloc.state.isActiveTimer ? 'PAUSE' : 'GO')),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _exercisePlayBloc.dispose();
    super.dispose();
  }
}
