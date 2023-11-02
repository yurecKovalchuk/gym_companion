class WelcomeState {
  WelcomeState(
    this.status,
    this.errorMessage,
  );

  final List<dynamic>? errorMessage;
  final WelcomeScreenStatus status;

  WelcomeState copyWith({
    WelcomeScreenStatus? status,
    List<dynamic>? errorMessage,
  }) {
    return WelcomeState(
      status ?? this.status,
      errorMessage ?? this.errorMessage,
    );
  }
}

enum WelcomeScreenStatus {
  initial,
  loading,
  error,
  hasToken,
}
