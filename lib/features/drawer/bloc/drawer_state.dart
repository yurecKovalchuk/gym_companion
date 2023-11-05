class DrawerState {
  DrawerState(
    this.status,
  );

  final DrawerStatus status;

  DrawerState copyWith({
    DrawerStatus? status,
  }) {
    return DrawerState(
      status ?? this.status,
    );
  }
}

enum DrawerStatus {
  initial,
  loading,
  error,
  logOutSuccess,
}
