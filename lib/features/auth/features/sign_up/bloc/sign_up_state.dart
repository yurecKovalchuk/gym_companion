class SignUpState {
  SignUpState({
    required this.obscureText,
    required this.isPasswordValid,
    required this.isEmailValid,
    required this.status,
    this.error,
  });

  final SignUpStatus status;
  final bool obscureText;
  final bool isPasswordValid;
  final String? error;
  final bool isEmailValid;

  SignUpState copyWith({
    SignUpStatus? status,
    bool? obscureText,
    String? error,
    bool? isPasswordValid,
    bool? isEmailValid,
  }) {
    return SignUpState(
      status: status ?? this.status,
      obscureText: obscureText ?? this.obscureText,
      error: error ?? this.error,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
    );
  }
}

enum SignUpStatus {
  initial,
  loading,
  success,
  error,
}
