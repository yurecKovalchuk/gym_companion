import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';
import 'package:timer_bloc/models/models.dart';
import '../sign_in.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInBloc(this._dataSource)
      : super(SignInState(
          true,
          status: SignInStatus.initial,
        ));

  final DataSource _dataSource;

  void getSignIn(String email, String password) async {
    emit(state.copyWith(status: SignInStatus.loading));
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await _dataSource.signInRequest(SignInCredentialsDto(
          email: email,
          password: password,
        ));
        TokenManager.saveToken(response.token!);
        emit(state.copyWith(status: SignInStatus.success));
      } catch (e) {
        emit(state.copyWith(status: SignInStatus.error));
      }
    }
  }

  void showPassword() {
    emit(state.copyWith(obscureText: true));
  }

  void hidePassword() {
    emit(state.copyWith(obscureText: false));
  }
}
