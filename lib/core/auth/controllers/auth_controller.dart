import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../../helpers/user_pref.dart';

/// Controls selecting user profile picture and display name.
class AuthController with ChangeNotifier {
  File? _pickedImageFile;
  String? _pickedImageFilePath;
  bool _hasPickedImageSuccessfully = false;

  /// get username
  String username = '';

  /// get picked file
  File? get pickedImageFile => _pickedImageFile;

  /// get picked file image path
  String? get pickedImageFilePath => _pickedImageFilePath;

  /// get check for successful image picking
  bool get hasPickedImageSuccessfully => _hasPickedImageSuccessfully;


  /// used to pick image from device gallery app
  void pickedImage() async {
    final picker = ImagePicker();
    final pickedImage = await (picker.pickImage(source: ImageSource.gallery));
    final pickedImageFile = File(pickedImage!.path);
    _pickedImageFilePath = pickedImage.path;
    _pickedImageFile = pickedImageFile;
    _hasPickedImageSuccessfully = true;
    notifyListeners();
  }

  ///tries to submit data entered
  void trySubmit(BuildContext context) {
    final _isValid = username.length > 2;
    FocusScope.of(context).unfocus(); //close keyboard

    //if no image is chosen, inform user and return
    if (_pickedImageFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an avatar boss 🧙‍♂️'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }

    if (!_isValid) {
      var options = {
        '1': 'Just add one more letter to have a valid name 🥺',
        '2': 'Please add two more letters to have a valid name 😜',
        '3': 'You can\'t have an empty name boss 👀',
      };
      var option = options[(3 - username.length).toString()];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(option!),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    //is valid, save data using shared pref
    context.read<UserPref>().save(username, _pickedImageFilePath).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Superhero $username 🔥🔥 \nYour data is in safe hands 😇.',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).primaryColor,
              action: SnackBarAction(
                label: 'OKAY',
                textColor: kWhite,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );

    notifyListeners();
  }
}
