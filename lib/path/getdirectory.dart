import 'dart:io';

import 'package:path_provider/path_provider.dart';

class GetDirectory {
  Directory path2;
  getDirectory() async {
    path2 = await getApplicationDocumentsDirectory();

    return path2.path;
  }

  Future<String> createFolder() async {
    final folderName = "images";
    final path = Directory("${await createDirecory()}/$folderName/");

    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();

      return path.path;
    }
  }

  Future<String> createDirecory() async {
    final folderName = "paras";
    final path = Directory("${await getDirectory()}/$folderName");

    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }
}