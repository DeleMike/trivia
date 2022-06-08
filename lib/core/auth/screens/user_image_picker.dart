import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trivia/configs/constants.dart';

import '../../../helpers/dark_theme_provider.dart';

///[UserImagePicker] - gets user image on the device gallery.
class UserImagePicker extends StatefulWidget {
  final void Function(String? filePath) onPickFile;

  UserImagePicker(this.onPickFile);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  String? _pickedImageFilePath;
  bool _hasPickedImageSuccessfully = false;

  //used to pick image from device gallery app
  void _pickedImage() async {
    final picker = ImagePicker();
    final pickedImage = await (picker.pickImage(source: ImageSource.gallery));
    final pickedImageFile = File(pickedImage!.path);
    _pickedImageFilePath = pickedImage.path;
    setState(() {
      _pickedImageFile = pickedImageFile;
      _hasPickedImageSuccessfully = true;
    });
    widget.onPickFile(_pickedImageFilePath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(45),
      ),
      child: CircleAvatar(
          radius: 45,
          backgroundColor: kTransparent,
          child: Visibility(
            visible: !_hasPickedImageSuccessfully,
            child: TextButton.icon(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              icon: Icon(Icons.image),
              label: Text('Add image'),
              onPressed: _pickedImage,
            ),
          ),
          backgroundImage: _pickedImageFile != null ? FileImage(_pickedImageFile!) : null),
    );
  }
}
