import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:daily/providers/index.dart';
import 'package:daily/pages/index.page.dart' as page_index;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:daily/model/user/user.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserAdapter());

  MainProvider mainProvider = MainProvider();

  var box = await Hive.openBox('testBox');

  // var usr = User(uuid: await generateUuid(box), name: "ainal", age: 22);
  // await box.put(usr.uuid, usr);
  // print(box.get(usr.uuid));
  // print(usr.uuid);

  print(box.toMap());

  runApp(
    MultiProvider(
      providers: mainProvider.providers,
      child: page_index.getPage(
        pageName: page_index.mainPage,
      ),
    ),
  );
}

Future<String> generateUuid(box) async {
  var uuid = const Uuid().v1();

  if (!await checkUuidDuplicate(uuid, box)) {
    uuid = await generateUuid(box);
  }

  return uuid;
}

Future<bool> checkUuidDuplicate(uuid, box) async {
  return box.get(uuid) == null;
}
