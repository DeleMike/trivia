import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';
import '../../../configs/constants.dart';

///[UserImagePicker] - gets user image on the device gallery.
class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  
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
            visible: !context.watch<AuthController>().hasPickedImageSuccessfully,
            child: TextButton.icon(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              icon: const Icon(Icons.image),
              label: const Text('Add image'),
              onPressed: () => context.read<AuthController>().pickedImage(),
            ),
          ),
          backgroundImage: context.watch<AuthController>().pickedImageFile != null
              ? FileImage(context.watch<AuthController>().pickedImageFile!)
              : null),
    );
  }
}
