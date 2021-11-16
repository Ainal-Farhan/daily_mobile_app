import 'package:daily/providers/font/font.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// List of all providers
import 'package:daily/providers/general/general.provider.dart';

class MainProvider {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (BuildContext context) => GeneralProvider(),
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) => FontProvider(),
    ),
  ];
}
