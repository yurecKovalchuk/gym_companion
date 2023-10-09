import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';
import 'package:timer_bloc/models/class_user_authentication.dart';
import '../sign_up.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc(this._dataSource)
      : super(SignUpState(
          true,
          status: SignUpStatus.initial,
        ));

  final DataSource _dataSource;

  void signUp(String email, String password, String displayName) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    if (email.isNotEmpty && password.isNotEmpty && displayName.isNotEmpty) {
      try {
        await _dataSource.signUpRequest(UserAuthentication(
          email: email,
          password: password,
          displayName: displayName,
        ));
        emit(state.copyWith(status: SignUpStatus.success));
      } catch (e) {
        emit(state.copyWith(status: SignUpStatus.error));
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
