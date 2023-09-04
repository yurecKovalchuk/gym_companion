import 'package:flutter/material.dart';

import 'package:timer_bloc/models/models.dart';

class ContainerApproachesList extends StatelessWidget {
  const ContainerApproachesList({
    super.key,
    required this.approaches,
    required this.onDeleteApproach,
    required this.onEditApproach,
  });

  final List<Approach> approaches;

  final Function(Approach approach) onDeleteApproach;
  final Function(Approach approach) onEditApproach;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            approaches.isEmpty
                ? Expanded(
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'No approaches yet', style: Theme.of(context).textTheme.headlineMedium),
                            const TextSpan(text: '\n'),
                            TextSpan(
                              text: 'Please, tab on button and start adding approaches',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: approaches.length,
                      itemBuilder: (context, index) {
                        final timer = approaches[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Card(
                            elevation: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      '${timer.value.toString()} seconds',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 5,
                                  color: timer.type == ApproachType.rest ? Colors.red : Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: SizedBox(
                                    width: 60,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        timer.type == ApproachType.rest ? 'Rest' : 'Exercise',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  itemBuilder: (context) => [
                                    const PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      onEditApproach(approaches[index]);
                                    } else if (value == 'delete') {
                                      onDeleteApproach(approaches[index]);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
