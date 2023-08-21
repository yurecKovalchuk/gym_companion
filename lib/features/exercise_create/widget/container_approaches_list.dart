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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            approaches.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 220.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          textAlign: TextAlign.end,
                          'Add approaches time and type',
                          style: TextStyle(fontSize: 18)),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: approaches.length,
                    itemBuilder: (context, index) {
                      final timer = approaches[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 88, 110, 69),
                            borderRadius: BorderRadius.circular(22.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    '${timer.value.toString()} seconds',
                                  ),
                                ),
                              ),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: timer.type == ApproachType.rest
                                      ? Colors.red
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(timer.type == ApproachType.rest
                                      ? 'Rest'
                                      : 'Exercise'),
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
          ],
        ),
      ),
    );
  }
}
