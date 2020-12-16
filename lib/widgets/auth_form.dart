import 'package:flutter/material.dart';

import '../widgets/user_image_picker.dart';
class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.85,
      padding: EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: UserImagePicker(),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter username',
                    border: UnderlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
