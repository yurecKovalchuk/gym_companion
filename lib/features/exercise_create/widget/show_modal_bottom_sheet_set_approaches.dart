import 'package:flutter/material.dart';

import 'package:timer_bloc/models/models.dart';

class ShowModalBottomSheetSetApproaches extends StatefulWidget {
  const ShowModalBottomSheetSetApproaches({
    super.key,
    this.value,
    this.type,
  });

  final int? value;
  final ApproachType? type;

  @override
  State<ShowModalBottomSheetSetApproaches> createState() =>
      _ShowModalBottomSheetSetApproachesState();
}

class _ShowModalBottomSheetSetApproachesState
    extends State<ShowModalBottomSheetSetApproaches> {
  late ApproachType selectedType = widget.type == ApproachType.exercise
      ? ApproachType.exercise
      : ApproachType.rest;

  int _currentSliderValue = 0;

  @override
  void initState() {
    _currentSliderValue = (widget.value ?? 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(18.0),
            topLeft: Radius.circular(18.0),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Add your new ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.black.withOpacity(0.5)),
                          ),
                          const TextSpan(
                            text: '\n', // New line
                          ),
                          TextSpan(
                              text: selectedType == ApproachType.rest
                                  ? 'Rest'
                                  : 'Exercise',
                              style: Theme.of(context).textTheme.headlineLarge),
                          TextSpan(
                            text: ' of ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.black.withOpacity(0.5)),
                          ),
                          TextSpan(
                              text: _currentSliderValue.toString(),
                              style: Theme.of(context).textTheme.headlineLarge),
                          TextSpan(
                            text: ' seconds ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Card(
                        color: selectedType == ApproachType.exercise
                            ? Colors.green
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: selectedType == ApproachType.exercise
                                ? Colors.black.withOpacity(0.2)
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        child: InkWell(
                          onTap: selectedTypeApproachExercise,
                          child: const SizedBox(
                            height: 40,
                            child: Center(
                              child: Text('Exercise'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: selectedType == ApproachType.rest
                            ? Colors.red
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: selectedType == ApproachType.exercise
                                ? Colors.black.withOpacity(0.2)
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        child: InkWell(
                          onTap: selectedTypeApproachRest,
                          child: const SizedBox(
                            height: 40,
                            child: Center(
                              child: Text('Rest'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: ' Duration: ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black.withOpacity(0.5)),
                    ),
                  )
                ],
              ),
              Slider(
                value: _currentSliderValue.toDouble(),
                max: 120,
                divisions: 5,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value as int;
                  });
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18)),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        final timer = _currentSliderValue.toString();
                        Navigator.pop(context, {
                          'timer': timer,
                          'type': selectedType,
                        });
                      });
                    },
                    child: Text(
                      widget.type == null && widget.value == null
                          ? 'Add'
                          : 'Update',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectedTypeApproachRest() {
    setState(() {
      selectedType = ApproachType.rest;
    });
  }

  void selectedTypeApproachExercise() {
    setState(() {
      selectedType = ApproachType.exercise;
    });
  }
}
