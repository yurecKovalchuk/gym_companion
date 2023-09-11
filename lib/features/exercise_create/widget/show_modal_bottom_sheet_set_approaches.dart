import 'package:flutter/material.dart';

import 'package:timer_bloc/localization/localization.dart';

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
  State<ShowModalBottomSheetSetApproaches> createState() => _ShowModalBottomSheetSetApproachesState();
}

class _ShowModalBottomSheetSetApproachesState extends State<ShowModalBottomSheetSetApproaches> {
  late ApproachType selectedType = widget.type == ApproachType.exercise ? ApproachType.exercise : ApproachType.rest;

  int _currentSliderValue = 0;

  @override
  void initState() {
    _currentSliderValue = (widget.value ?? 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(18.0),
            topLeft: Radius.circular(18.0),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Text(
                context.l10n.buttonAddApproach,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: selectedType == ApproachType.rest ? context.l10n.rest : context.l10n.exercise,
                        style: Theme.of(context).textTheme.headlineLarge),
                    TextSpan(
                      text: ' ${context.l10n.articleOf} ',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                    ),
                    TextSpan(
                      text: _currentSliderValue.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black.withOpacity(0.75)),
                    ),
                    TextSpan(
                      text: context.l10n.seconds,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black.withOpacity(0.5)),
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
                      child: GestureDetector(
                        onTap: selectedTypeApproachExercise,
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: selectedType == ApproachType.exercise ? 2 : 4,
                          shadowColor: selectedType == ApproachType.exercise ? Colors.red : Colors.grey,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Text(context.l10n.exercise),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: selectedTypeApproachRest,
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: selectedType == ApproachType.rest ? 2 : 4,
                          shadowColor: selectedType == ApproachType.rest ? Colors.green : Colors.grey,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Center(
                              child: Text(context.l10n.rest),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                '${context.l10n.duration}: ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black.withOpacity(0.5)),
              ),
              SliderTheme(
                data: SliderThemeData(
                  // here
                  trackShape: CustomTrackShape(),
                ),
                child: Slider(
                  value: _currentSliderValue.toDouble(),
                  max: 120,
                  divisions: 60,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value.toInt();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
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
                    widget.type == null && widget.value == null ? context.l10n.add : context.l10n.update,
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

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
