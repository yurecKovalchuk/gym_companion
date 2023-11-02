class SignInState {
  SignInState({
    required this.obscureText,
    required this.status,
    required this.isEmailValid,
    required this.isPasswordValid,
    this.errorMessage,
  });

  final bool isEmailValid;
  final bool isPasswordValid;
  final SignInStatus status;
  final bool obscureText;
  final String? errorMessage;

  SignInState copyWith({
    SignInStatus? status,
    bool? obscureText,
    String? errorMessage,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return SignInState(
      status: status ?? this.status,
      obscureText: obscureText ?? this.obscureText,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }
}

enum SignInStatus {
  initial,
  loading,
  success,
  error,
}
