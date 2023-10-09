class SignUpState {
  SignUpState(
    this.obscureText, {
    required this.status,
  });

  final SignUpStatus status;
  bool obscureText;

  SignUpState copyWith({
    SignUpStatus? status,
    bool? obscureText,
  }) {
    return SignUpState(
      status: status ?? this.status,
      obscureText ?? this.obscureText,
    );
  }
}

enum SignUpStatus {
  initial,
  loading,
  success,
  error,
}
