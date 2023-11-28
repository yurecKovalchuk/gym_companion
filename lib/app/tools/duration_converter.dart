class DurationConverter {
  static Duration intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    return Duration(
      hours: h,
      minutes: m,
      seconds: s,
    );
  }
}
