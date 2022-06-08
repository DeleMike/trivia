import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../controllers/auth_controller.dart';

import 'user_image_picker.dart';

///[AuthForm] collects all desired data to save in app.
class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kScreenWidth(context),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(kPaddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserImagePicker(),
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
