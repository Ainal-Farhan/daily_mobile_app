import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  // colors
  Color _green = const Color(0xff42aa45);
  Color _darkgreen = const Color(0xff368738);
  Color _lightgreen = const Color(0xff58cc5b);
  Color _verylightgreen = const Color(0xff7dfa80);
  Color _bgGreen = const Color(0xffdaffdb);
  MaterialColor _primarySwatch = Colors.green;

  Color get green => _green;
  Color get darkgreen => _darkgreen;
  Color get lightgreen => _lightgreen;
  Color get verylightgreen => _verylightgreen;
  Color get bgGreen => _bgGreen;
  MaterialColor get primarySwatch => _primarySwatch;

  set green(color) => _green = color;
  set darkgreen(color) => _darkgreen = color;
  set lightgreen(color) => _lightgreen = color;
  set verylightgreen(color) => _verylightgreen = color;
  set bgGreen(color) => _bgGreen = color;
  set primarySwatch(color) => _primarySwatch = color;
}
