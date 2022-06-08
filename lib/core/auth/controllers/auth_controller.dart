import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Controls selecting user profile picture and display name.
class AuthController with ChangeNotifier {
  File? _pickedImageFile;
  String? _pickedImageFilePath;
  bool _hasPickedImageSuccessfully = false;

  /// Picked file
  File? get pickedImageFile => _pickedImageFile;

  /// Picked file image path
  String? get pickedImageFilePath => _pickedImageFilePath;

  ///check for successful image picking
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
}
