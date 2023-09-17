import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/localization/localization.dart';
import 'package:timer_bloc/models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/exercisesScreen',
      onGenerateRoute: (settings) {
        late final exercise = settings.arguments as Exercise;
        switch (settings.name) {
          case '/exercisesScreen':
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExercisesBloc(DataSource()),
                child: const ExerciseScreen(),
              ),
            );
          case '/exerciseCreate':
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExerciseCreateBloc(),
                child: const ExerciseCreate(),
              ),
            );
          case '/exercisePlay':
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExercisePlayBloc(exercise),
                child: const ExercisePlay(),
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => Container(),
            );
        }
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
