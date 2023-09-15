import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/localization/localization.dart';
import 'package:timer_bloc/models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late Exercise exercise;

  final ExercisesBloc exerciseBloc = ExercisesBloc(DataSource());
  final ExerciseCreateBloc exerciseCreateBloc = ExerciseCreateBloc();
  late final ExercisePlayBloc exercisePlayBloc;

  @override
  Widget build(BuildContext context) {
    final exercise = ModalRoute.of(context)!.settings.arguments as Exercise;
    exercisePlayBloc = ExercisePlayBloc(exercise);

    return MaterialApp(
      initialRoute: '/exerciseScreen',
      routes: {
        '/exerciseScreen': (context) => ExerciseScreen(
              exerciseBloc: exerciseBloc,
            ),
        '/exerciseCreate': (context) => ExerciseCreate(
              exerciseCreateBloc: exerciseCreateBloc,
            ),
        '/exercisePlay': (context) => ExercisePlay(
              exercisePlayBloc: exercisePlayBloc,
            ),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
