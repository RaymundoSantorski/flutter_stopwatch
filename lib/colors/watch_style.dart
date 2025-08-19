import 'package:flutter/material.dart';

final ColorScheme durationStyle = const ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.white,
  onPrimary: Colors.black,
  secondary: Colors.white,
  onSecondary: Colors.black,
  error: Colors.red,
  onError: Colors.black,
  surface: Colors.blue,
  onSurface: Colors.black,
);

final TextStyle textStyle = TextStyle(
  color: durationStyle.onPrimary,
  fontWeight: FontWeight.bold,
  fontSize: 30,
  fontStyle: FontStyle.italic,
);
