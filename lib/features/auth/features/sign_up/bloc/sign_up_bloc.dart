import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:timer_bloc/exceptions/exceptions.dart';
import 'package:timer_bloc/models/class_user_authentication.dart';
import 'package:timer_bloc/repository/repository.dart';
import '../sign_up.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc(this._repository)
      : super(SignUpState(
          status: SignUpStatus.initial,
          obscureText: true,
          isPasswordValid: true,
          isEmailValid: true,
        ));

  final ExercisesRepository _repository;

  void signUp(String email, String password, String displayName) async {
    if (state.isPasswordValid && state.isEmailValid) {
      if (email.isNotEmpty && password.isNotEmpty && displayName.isNotEmpty) {
        emit(state.copyWith(status: SignUpStatus.loading));
        try {
          await _repository.signUp(UserAuthentication(
            email: email,
            password: password,
            displayName: displayName,
          ));
          emit(state.copyWith(status: SignUpStatus.success));
        } on ValidationException catch (e) {
          emit(state.copyWith(
            status: SignUpStatus.error,
            error: e.response.message.toString(),
          ));
        }
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
