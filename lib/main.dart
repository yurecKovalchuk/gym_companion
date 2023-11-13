import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'package:timer_bloc/domain/domain.dart';
import 'package:timer_bloc/features/drawer/drawer.dart';
import 'package:timer_bloc/features/exercise_create/exercise_create.dart';
import 'package:timer_bloc/features/exercise_play/exercise_play.dart';
import 'package:timer_bloc/features/exercises/exercises.dart';
import 'package:timer_bloc/localization/localization.dart';
import 'package:timer_bloc/models/models.dart';
import 'app/app.dart';
import 'di/injection.dart';
import 'features/auth/auth.dart';

void main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(di: GetIt.instance));
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.di,
  });

  final GetIt di;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get di => widget.di;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myAppTheme,
      initialRoute: routWelcomeScreen,
      onGenerateRoute: (settings) {
        late final exercise = settings.arguments as Exercise?;
        switch (settings.name) {
          case routWelcomeScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => WelcomeBloc(
                  di<ExercisesRepository>(),
                ),
                child: const WelcomeScreen(),
              ),
            );
          case routSignInScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SignInBloc(
                  di<ExercisesRepository>(),
                ),
                child: SignInScreen(),
              ),
            );
          case routSignUpScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => SignUpBloc(
                  di<ExercisesRepository>(),
                ),
                child: SignUpScreen(),
              ),
            );
          case routExerciseScreen:
            return MaterialPageRoute(
              builder: (context) => MultiBlocProvider(providers: [
                BlocProvider<ExercisesBloc>(
                  create: (context) => ExercisesBloc(
                    di<ExercisesRepository>(),
                  ),
                ),
                BlocProvider<DrawerBloc>(
                  create: (context) => DrawerBloc(
                    di<ExercisesRepository>(),
                  ),
                )
              ], child: const ExerciseScreen()),
            );
          case routExerciseCreateScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExerciseCreateBloc(
                  di<ExercisesRepository>(),
                  exercise,
                ),
                child: const ExerciseCreate(),
              ),
            );
          case routExercisePlayScreen:
            return MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => ExercisePlayBloc(
                  exercise ?? Exercise.initial(),
                ),
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
