import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: BlocBuilder(
          bloc: _exercisePlayBloc,
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
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
                  itemCount: _exercisePlayBloc.state.exercise.approaches.length,
                  itemBuilder: (context, index) {
                    final timer =
                        _exercisePlayBloc.state.exercise.approaches[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                        color: _generateSlotColorByState(index, timer),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                textAlign: TextAlign.center,
                                timer.type == ApproachType.rest
                                    ? 'Rest'
                                    : 'Exercise',
                              ),
                              subtitle: Text(
                                textAlign: TextAlign.center,
                                '${_exercisePlayBloc.state.approachesLeftTime[index]}/${timer.value.toString()} seconds',
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
                    _exercisePlayBloc.state.isActiveExercise ? 'PAUSE' : 'GO',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color _generateSlotColorByState(int index, Approach timer) =>
      _exercisePlayBloc.state.approachesIndex == index &&
              _exercisePlayBloc.state.isActiveExercise
          ? (timer.type == ApproachType.rest ? Colors.green : Colors.red)
          : Colors.transparent;

}
