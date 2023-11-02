import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/repository/repository.dart';
import '../welcome.dart';

class WelcomeBloc extends Cubit<WelcomeState> {
  WelcomeBloc(
    this.exercisesRepository,
  ) : super(
          WelcomeState(
            WelcomeScreenStatus.initial,
            [],
          ),
        );

  ExercisesRepository exercisesRepository;

  void checkToken() async {
    emit(state.copyWith(status: WelcomeScreenStatus.loading));
    final result = await exercisesRepository.localDataSource.checkIfTokenExists();
    if (result == true) {
      emit(state.copyWith(status: WelcomeScreenStatus.hasToken));
    }
    if (result == false) {
      emit(state.copyWith(status: WelcomeScreenStatus.initial));
    } else {
      emit(state.copyWith(status: WelcomeScreenStatus.error));
    }
  }
}
