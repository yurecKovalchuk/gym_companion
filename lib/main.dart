import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/localization/localization.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/exerciseScreen',
      routes: {
        '/exerciseScreen': (context) => const ExerciseScreen(),
        '/exerciseCreate': (context) => const ExerciseCreate(),
        '/exercisePlay': (context) => const ExercisePlay(),
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
