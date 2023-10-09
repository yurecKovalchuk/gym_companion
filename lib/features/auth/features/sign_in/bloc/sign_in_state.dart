class SignInState {
  SignInState(
    this.obscureText, {
    required this.status,
  });

  final SignInStatus status;
  bool obscureText;

  SignInState copyWith({
    SignInStatus? status,
    bool? obscureText,
  }) {
    return SignInState(
      status: status ?? this.status,
      obscureText ?? this.obscureText,
    );
  }
}

enum SignInStatus {
  initial,
  loading,
  success,
  error,
}
