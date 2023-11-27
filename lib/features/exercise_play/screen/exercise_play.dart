import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/features/exercise_play/widget/timer_widget.dart';

import 'package:timer_bloc/localization/localization.dart';

import 'package:timer_bloc/features/exercise_play/bloc/bloc.dart';
import 'package:timer_bloc/models/models.dart';
import 'package:timer_bloc/app/tools/tools.dart';

const double itemTimerHeight = 192.0;

class ExercisePlay extends StatefulWidget {
  const ExercisePlay({
    super.key,
  });

  @override
  State<ExercisePlay> createState() => _ExercisePlayState();
}

class _ExercisePlayState extends State<ExercisePlay> {
  ExercisePlayBloc get _exercisePlayBloc => BlocProvider.of<ExercisePlayBloc>(context);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      scrollToActiveIndex;
    });
    super.initState();
  }

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
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: _exercisePlayBloc.state.exercise.approaches.length,
                      itemBuilder: (context, index) {
                        final timer = _exercisePlayBloc.state.exercise.approaches[index];
                        if (_exercisePlayBloc.state.isActiveExercise &&
                            index == _exercisePlayBloc.state.approachesIndex) {
                          scrollToActiveIndex(index);
                        }
                        return Container(
                          height: itemTimerHeight,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: _generateSlotColorByState(index, timer),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2.0,
                                blurRadius: 5.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: ListTile(
                                    title: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: timer.type == ApproachType.rest
                                                  ? context.l10n.rest
                                                  : context.l10n.exercise,
                                              style: Theme.of(context).textTheme.headlineMedium),
                                          const TextSpan(text: '\n'),
                                          TextSpan(
                                            text: '/${timer.value.toString()} ${context.l10n.seconds}',
                                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                  color: Colors.black.withOpacity(0.5),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              (_exercisePlayBloc.state.isActiveExercise &&
                                      index == _exercisePlayBloc.state.approachesIndex)
                                  ? TimerWidget(
                                      duration: DurationConverter.intToTimeLeft(
                                        _exercisePlayBloc.state.approachLeftTime == 0
                                            ? timer.value
                                            : _exercisePlayBloc.state.approachLeftTime,
                                      ),
                                      onTimerFinish: () {
                                        _exercisePlayBloc.stopExerciseTimer();
                                      },
                                      onTimerActive: _exercisePlayBloc.state.isActiveExercise,
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: ElevatedButton(
                  onPressed: () {
                    _exercisePlayBloc.state.isActiveExercise
                        ? _exercisePlayBloc.stopExerciseTimer()
                        : _exercisePlayBloc.playExercise();
                  },
                  child: Text(
                    _exercisePlayBloc.state.isActiveExercise ? context.l10n.pause : context.l10n.go,
                  ),
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

  void scrollToActiveIndex(int index) {
    if (index < _exercisePlayBloc.state.exercise.approaches.length - 1) {
      final double offset = (itemTimerHeight + 16) * index;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
    }
  }
}
