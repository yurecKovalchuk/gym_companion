class SignInState {
  SignInState({
    required this.obscureText,
    required this.status,
    required this.isEmailValid,
    required this.isPasswordValid,
    this.error,
  });

  final bool isEmailValid;
  final bool isPasswordValid;
  final SignInStatus status;
  final bool obscureText;
  final String? error;

  SignInState copyWith({
    SignInStatus? status,
    bool? obscureText,
    String? error,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return SignInState(
      status: status ?? this.status,
      obscureText: obscureText ?? this.obscureText,
      error: error ?? this.error,
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
