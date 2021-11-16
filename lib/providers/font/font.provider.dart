import 'package:flutter/material.dart';

class FontProvider extends ChangeNotifier {
  // colors
  Color _dropDownInputColor = const Color.fromRGBO(0, 0, 0, 1);
  Color _textFieldInputColor = const Color.fromRGBO(0, 0, 0, 1);
  Color _textFieldHintColor = const Color.fromRGBO(150, 142, 141, 1);

  Color get dropDownInputColor => _dropDownInputColor;
  Color get textFieldInputColor => _textFieldInputColor;
  Color get textFieldHintColor => _textFieldHintColor;

  set dropDownInputColor(color) => _dropDownInputColor = color;
  set textFieldInputColor(color) => _textFieldInputColor = color;
  set textFieldHintColor(color) => _textFieldHintColor = color;
}
