import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:daily/providers/index.dart';
import 'package:daily/pages/index.page.dart' as page_index;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:daily/model/expense/expense.dart' as expense;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(expense.ExpenseAdapter());

  MainProvider mainProvider = MainProvider();

  runApp(
    MultiProvider(
      providers: mainProvider.providers,
      child: page_index.getPage(
        pageName: page_index.mainPage,
      ),
    ),
  );
}
