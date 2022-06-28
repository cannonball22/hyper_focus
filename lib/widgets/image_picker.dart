import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerGlobal {
  File? _image;
  final picker = ImagePicker();

  Future<File?> getImageFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return (_image);
    } else {
      print('No image selected.');
    }
    return _image;
  }

  Future<File?> getImageFromGallery() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      print('Got picked');
      return (_image);
    } else {
      print('No image selected.');
    }
    return _image;
  }
}
