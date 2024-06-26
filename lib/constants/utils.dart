import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    FilePickerResult? files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (files != null && files.files.isNotEmpty) {
      images = files.paths.map((path) => File(path!)).toList();
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
