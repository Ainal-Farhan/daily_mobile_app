import 'package:uuid/uuid.dart';

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
