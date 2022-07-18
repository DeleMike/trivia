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
        border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? kWhite : kPrimaryColor),
        borderRadius: BorderRadius.circular(45),
      ),
      child: CircleAvatar(
          radius: 45,
          backgroundColor: kTransparent,
          child: Visibility(
            visible: !context.watch<AuthController>().hasPickedImageSuccessfully,
            child: TextButton.icon(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).brightness == Brightness.dark ? kWhite : kPrimaryColor,
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              icon: const Icon(Icons.image),
              label: Text(
                'Add image',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark ? kWhite : kPrimaryColor),
              ),
              onPressed: () => context.read<AuthController>().pickedImage(),
            ),
          ),
          backgroundImage: context.watch<AuthController>().pickedImageFile != null
              ? FileImage(context.watch<AuthController>().pickedImageFile!)
              : null),
    );
  }
}
