import 'package:flutter/material.dart';
import 'package:timer_bloc/timer_stream.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TimerStream _timerBloc = TimerStream();

  @override
  void dispose() {
    _timerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder<int>(
              stream: _timerBloc.timerStream,
              initialData: 0,
              builder: (context, snapshot) {
                return Column(children: [
                  Text(
                    '${snapshot.data}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _timerBloc.isActive
                            ? _timerBloc.stopTimer()
                            : _timerBloc.startTimer();
                      },
                      child: Text(_timerBloc.isActive ? "stop" : "go")),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _setTimerLimited(context);
                    },
                    child: const Text('enter limit'),
                  ),
                ]);
              })
        ]),
      ),
    );
  }

  void _setTimerLimited(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          int? enteredLimit;
          return AlertDialog(
            title: const Text("set timer limit"),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                enteredLimit = int.tryParse(value);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (enteredLimit != null) {
                    _timerBloc.getTimerLimit(enteredLimit!);
                  }
                  Navigator.pop(context);
                },
                child: const Text("ok"),
              ),
            ],
          );
        });
  }
}
