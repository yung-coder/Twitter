import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imagesFiles = await picker.pickMultiImage();
  if (imagesFiles.isNotEmpty) {
    for (final image in imagesFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

Future<File?> pickImage() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imagesFile = await picker.pickImage(source: ImageSource.gallery);
  if (imagesFile != null) {
    return File(imagesFile.path);
  }
  return null;
}
