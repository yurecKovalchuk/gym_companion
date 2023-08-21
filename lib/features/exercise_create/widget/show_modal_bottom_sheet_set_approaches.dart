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
  late final TextEditingController _textEditingController =
      TextEditingController(
    text: widget.value != null
        ? widget.value.toString()
        : _currentSliderValue.toString(),
  );

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
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _currentSliderValue.toString(),
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
                const Text(
                  'seconds',
                  style: TextStyle(fontSize: 18),
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
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: selectedTypeApproachExercise,
                  child: Container(
                    height: 60,
                    width: 140,
                    decoration: BoxDecoration(
                      color: selectedType == ApproachType.exercise
                          ? Colors.green
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: selectedType == ApproachType.exercise
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('Exercise'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: selectedTypeApproachRest,
                  child: Container(
                    height: 60,
                    width: 140,
                    decoration: BoxDecoration(
                      color: selectedType == ApproachType.rest
                          ? Colors.red
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: selectedType == ApproachType.rest
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('Rest'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
