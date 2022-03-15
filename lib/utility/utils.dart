import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImages(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  XFile? imagepicked = await _picker.pickImage(source: ImageSource.gallery);
  if (imagepicked == null) {
    print('Please select your photo.');
  }

  return await imagepicked!.readAsBytes();
}

showSnackbar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
