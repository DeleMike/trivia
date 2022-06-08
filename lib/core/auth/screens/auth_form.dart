import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trivia/configs/constants.dart';
import 'package:trivia/core/auth/controllers/auth_controller.dart';

import '../../../helpers/dark_theme_provider.dart';
import '../../../helpers/user_pref.dart';

import 'user_image_picker.dart';

///[AuthForm] collects all desired data to save in app.
class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late String? _name = '';
  late String? _pickedImageFilePath;
  final _formKey = GlobalKey<FormState>();

  ///tries to submit data entered
  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //close keyboard

    //if no image is chosen, inform user and return
    if (_pickedImageFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    //is valid, save data using shared pref
    if (isValid) {
      _formKey.currentState!.save();
      print('name = $_name, filePath = $_pickedImageFilePath');
      //save to shared pref
      Provider.of<UserPref>(context, listen: false).save(_name, _pickedImageFilePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved.', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo[900],
          action: SnackBarAction(
              label: 'OKAY',
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
      );
    }
  }

  ///save picked file
  void _pickFile(String? filePath) {
    _pickedImageFilePath = filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kScreenWidth(context),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(kPaddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserImagePicker(_pickFile),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  context.read<AuthController>().username = value;
                },
                keyboardType: TextInputType.name,
                autocorrect: true,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: kBlack,
                    fontFamily: GoogleFonts.caveatBrush().fontFamily,
                  ),
                  labelText: 'Enter your geek name',
                  border: UnderlineInputBorder(),
                  fillColor: kCanvasColor,
                  filled: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
