import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/datasource/datasource.dart';
import 'package:timer_bloc/models/models.dart';
import 'package:timer_bloc/exceptions/exceptions.dart';
import '../sign_in.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInBloc(this._repository)
      : super(SignInState(
          status: SignInStatus.initial,
          obscureText: true,
          isEmailValid: true,
          isPasswordValid: true,
        ));

  final ExercisesRepository _repository;

  void signIn(String email, String password) async {
    emit(state.copyWith(status: SignInStatus.loading));
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await _repository.signIn(SignInCredentialsDto(
          email: email,
          password: password,
        ));
        _repository.saveToken(response.token!);
        emit(state.copyWith(status: SignInStatus.success));
      } on ValidationException catch (e) {
        emit(state.copyWith(status: SignInStatus.error, error: e.response.message.toString()));
      } catch (e) {
        emit(state.copyWith(
          status: SignInStatus.error,
          error: e.toString(),
        ));
      }
    }
  }

  void isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final isValid = emailRegex.hasMatch(email);
    emit(state.copyWith(isEmailValid: isValid));
  }

  void isPasswordValid(String password) {
    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[a-z]'))) {
      emit(state.copyWith(isPasswordValid: false));
    } else {
      emit(state.copyWith(isPasswordValid: true));
    }
  }

  void showPassword() {
    emit(state.copyWith(obscureText: true));
  }

  void hidePassword() {
    emit(state.copyWith(obscureText: false));
  }
}
