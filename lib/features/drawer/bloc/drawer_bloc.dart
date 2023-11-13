import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/domain/domain.dart';

import 'drawer_state.dart';

class DrawerBloc extends Cubit<DrawerState> {
  DrawerBloc(
    this._repository,
  ) : super(DrawerState(
          DrawerStatus.initial,
        ));

  final ExercisesRepository _repository;

  void logOutAccount() async {
    emit(state.copyWith(status: DrawerStatus.loading));
    await _repository.removeToken();
    emit(state.copyWith(status: DrawerStatus.logOutSuccess));
  }
}
