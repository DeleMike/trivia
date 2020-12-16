import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(String filePath) onPickFile;

  UserImagePicker(this.onPickFile);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;
  String _pickedImageFilePath;

  void _pickedImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 60,
      imageQuality: 60,
    );
    final pickedImageFile = File(pickedImage.path);
    _pickedImageFilePath = pickedImage.path;
    setState(() {
      _pickedImageFile = pickedImageFile;
    });
    widget.onPickFile(_pickedImageFilePath);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.indigo[400],
          backgroundImage: _pickedImageFile != null ? FileImage(_pickedImageFile) : null 
        ),
        FlatButton.icon(
          icon: Icon(Icons.image),
          label: Text('Add image'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickedImage,
        ),
      ],
    );
  }
}
