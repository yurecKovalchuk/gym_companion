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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<int>(
              stream: _timerBloc.timerStream,
              initialData: 0,
              builder: (context, snapshot) {
                return Text('${snapshot.data}',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 20),
           InkWell(
             child: Text('go'),
             onTap: (){_timerBloc.startTimer();}
             ,
           ),
          ],
        ),
      ),
    );
  }
}