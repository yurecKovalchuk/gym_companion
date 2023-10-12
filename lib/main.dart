import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timer_bloc/datasource/datasource.dart';

import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/localization/localization.dart';
import 'package:timer_bloc/models/models.dart';
import 'app/app.dart';
import 'features/auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final DataSource dataSource = DataSource(baseUrl);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: routWelcomeScreen,
      onGenerateRoute: (settings) {
        late final exercise = settings.arguments as Exercise?;
        switch (settings.name) {
          case routWelcomeScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => WelcomeBloc(),
                child: const WelcomeScreen(),
              ),
            );
          case routSignInScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SignInBloc(dataSource),
                child: SignInScreen(),
              ),
            );
          case routSignUpScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SignUpBloc(dataSource),
                child: SignUpScreen(),
              ),
            );
          case routExerciseScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExercisesBloc(dataSource),
                child: const ExerciseScreen(),
              ),
            );
          case routExerciseCreateScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExerciseCreateBloc(exercise),
                child: const ExerciseCreate(),
              ),
            );
          case routExercisePlayScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExercisePlayBloc(exercise ?? Exercise.initial()),
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
