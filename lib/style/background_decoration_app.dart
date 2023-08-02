import 'package:flutter/material.dart';

class MainBackgroundDecoration {
  static BoxDecoration backgroundDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.purpleAccent,
        Colors.white10,
      ],
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
    ),
  );
}