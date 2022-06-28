import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickedFn);
  final void Function(File pickedImage) imagePickedFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    widget.imagePickedFn(_image!);
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    widget.imagePickedFn(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.camera_alt),
              label: const Text('capture Image'),
              onPressed: getImageFromCamera,
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.image),
              label: Text('Add Image'),
              onPressed: getImageFromGallery,
            ),
          ],
        ),
      ],
    );
  }
}
