import 'package:daily/providers/general/general.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily/routers/index.router.dart' as router;

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GeneralProvider generalProvider = Provider.of<GeneralProvider>(
      context,
      listen: false,
    );

    return MaterialApp(
      title: 'Daily Report',
      theme: ThemeData(
        primarySwatch: generalProvider.primarySwatch,
      ),
      initialRoute: router.homePageRoute,
      onGenerateRoute: router.createRoute,
    );
  }
}
