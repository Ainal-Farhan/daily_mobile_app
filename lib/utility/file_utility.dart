import 'package:path_provider/path_provider.dart';

const String _publicFileDirectoryDownload = "/storage/emulated/0/Download/";

Future<String> getDirectory({required bool isPublic}) async {
  if (isPublic) {
    return _publicFileDirectoryDownload;
  }

  final directory = await getExternalStorageDirectory();

  return directory?.path ?? "";
}

String cleanFileName({required String fileName, required String fileExt}) {
  return fileName
          .replaceAll(RegExp(' +'), ' ')
          .replaceAll(RegExp(' +'), '-')
          .replaceAll(RegExp('[^A-Za-z0-9\\/]'), '-') +
      ".$fileExt";
}
