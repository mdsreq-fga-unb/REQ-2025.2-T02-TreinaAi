import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart';

Future<void> saveAndOpenFile(List<int> bytes, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$fileName';

  final file = File(path);
  await file.writeAsBytes(bytes, flush: true);

  await OpenFile.open(path);
}