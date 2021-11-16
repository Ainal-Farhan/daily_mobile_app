import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  // colors
  Color _main = const Color.fromRGBO(0, 255, 205, 1);
  Color _mainDark1 = const Color.fromRGBO(0, 128, 102, 0.5);
  Color _mainLight1 = const Color.fromRGBO(77, 255, 219, 1);
  Color _mainDark2 = const Color.fromRGBO(38, 128, 110, 0.5);
  Color _mainLight2 = const Color.fromRGBO(0, 204, 163, 0.8);
  MaterialColor _primarySwatch = Colors.green;

  Color get main => _main;
  Color get mainDark1 => _mainDark1;
  Color get mainLight1 => _mainLight1;
  Color get mainDark2 => _mainDark2;
  Color get mainLight2 => _mainLight2;
  MaterialColor get primarySwatch => _primarySwatch;

  set main(color) => _main = color;
  set mainDark1(color) => _mainDark1 = color;
  set mainLight1(color) => _mainLight1 = color;
  set mainDark2(color) => _mainDark2 = color;
  set mainLight2(color) => _mainLight2 = color;
  set primarySwatch(color) => _primarySwatch = color;
}
