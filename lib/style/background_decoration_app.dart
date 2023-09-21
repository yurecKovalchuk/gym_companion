import 'package:flutter/material.dart';

class MainBackgroundDecoration {
  static BoxDecoration backgroundDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 88, 110, 69),
        Colors.white10,
      ],
      begin: Alignment.topLeft,
      end: Alignment.center,
    ),
  );
}
