import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../../helpers/user_pref.dart';

/// Controls selecting user profile picture and display name.
class AuthController with ChangeNotifier {
  /// Controls selecting user profile picture and display name.
  AuthController();

  File? _pickedImageFile;
  String? _pickedImageFilePath;
  bool _hasPickedImageSuccessfully = false;
  File? _updateProfilePickedImgFile;
  String? _updateProfilePickedImgFilePath;

  /// update display name
  String? updateProfileUsername;

  /// username
  String username = '';

  /// String pickedImageFilePath
  String pickedImageFilePath = '';

  /// get picked file
  File? get pickedImageFile => _pickedImageFile;

  /// get profile update picked file image path
  File? get updateProfilePickedImgFile => _updateProfilePickedImgFile;

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

  void pickProfileUpdateImage() async {
    final picker = ImagePicker();
    final pickedImage = await (picker.pickImage(source: ImageSource.gallery));
    final pickedImageFile = File(pickedImage!.path);
    _updateProfilePickedImgFile = pickedImageFile;
    _updateProfilePickedImgFilePath = pickedImageFile.path;
    _hasPickedImageSuccessfully = true;
    notifyListeners();
  }

  /// try to update user profile
  Future<void> updateUserProfile(BuildContext context) async {
    FocusScope.of(context).unfocus();
    //check if they are empty
    if (updateProfileUsername == null && _updateProfilePickedImgFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'Okay',
              textColor: kWhite,
              onPressed: () {},
            ),
            content: Padding(
              padding: const EdgeInsets.all(kPaddingS + 2),
              child: Text(
                'No data updated',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kWhite),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
      );
      return;
    }

    // only updated where user has provided information.
    // firstly, we get previous data because we don't want
    // to touch the data the user doesn't want to update.

    // fetch data
    final userData = await context.read<UserPref>().fetchData();
    String? name = userData['username'];
    String? profileImgFilePath = userData['imagepath'];

    if (updateProfileUsername == null) {
      // update only picture
      profileImgFilePath = _updateProfilePickedImgFilePath;
    } else if (_updateProfilePickedImgFile == null) {
      // update only name
      name = updateProfileUsername;
      final _isValid = name!.length > 2;
      if (!_isValid) {
        var options = {
          '1': 'Just add one more letter to have a valid name 🥺',
          '2': 'Please add two more letters to have a valid name 😜',
          '3': 'You can\'t have an empty name boss 👀',
        };
        var option = options[(3 - name.length).toString()];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            action: SnackBarAction(
              label: 'Okay',
              textColor: kWhite,
              onPressed: () {},
            ),
            behavior: SnackBarBehavior.floating,
            content: Padding(
              padding: const EdgeInsets.all(kPaddingS + 2),
              child: Text(option!),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
        return;
      }
    } else {
      // user gave both information, update all
      name = updateProfileUsername;
      profileImgFilePath = _updateProfilePickedImgFilePath;
    }

    // then save the data
    await context.read<UserPref>().save(name, profileImgFilePath);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
              label: 'Okay',
              textColor: kWhite,
              onPressed: () {},
            ),
        behavior: SnackBarBehavior.floating,
        content: Padding(
          padding: const EdgeInsets.all(kPaddingS + 2),
          child: (updateProfileUsername == null
              ? const Text('Your profile image has been updated')
              : _updateProfilePickedImgFile == null
                  ? const Text('Your profile name has been updated')
                  : const Text('Your profile information has been updated')),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  ///tries to submit data entered
  Future<void> trySubmit(BuildContext context) async {
    final _isValid = username.length > 2;
    FocusScope.of(context).unfocus(); //close keyboard

    //if no image is chosen, inform user and return
    if (_pickedImageFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
              label: 'Okay',
              textColor: kWhite,
              onPressed: () {},
            ),
          behavior: SnackBarBehavior.floating,
          content: const Padding(
            padding: EdgeInsets.all(kPaddingS + 2),
            child: Text('Please pick an avatar boss 🧙‍♂️'),
          ),
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
          action: SnackBarAction(
              label: 'Okay',
              textColor: kWhite,
              onPressed: () {},
            ),
          behavior: SnackBarBehavior.floating,
          content: Padding(
            padding: const EdgeInsets.all(kPaddingS + 2),
            child: Text(option!),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    //is valid, save data using shared pref
    await context.read<UserPref>().save(username, _pickedImageFilePath);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        behavior: SnackBarBehavior.floating,
        content: Padding(
          padding: const EdgeInsets.all(kPaddingS + 2),
          child: Text('Superhero $username 🔥🔥 \nYour data is in safe hands 😇.',
              style: const TextStyle(color: Colors.white)),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        action: SnackBarAction(
          label: 'OKAY',
          textColor: kWhite,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );

    notifyListeners();
  }

  Future<void> saveUpdate() async {
    await Future.delayed(const Duration(milliseconds: 400));
    debugPrint('Saved and updated successfully');
    notifyListeners();
  }

  void clearStates() {
    _pickedImageFile = null;
    _pickedImageFilePath = null;
    _hasPickedImageSuccessfully = false;
    _updateProfilePickedImgFile = null;
    _updateProfilePickedImgFilePath = null;
    updateProfileUsername = null;
    username = '';
    pickedImageFilePath = '';
  }
}
