import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/dark_theme_provider.dart';
import '../widgets/user_image_picker.dart';
import '../helpers/user_pref.dart';

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
      Scaffold.of(context).showSnackBar(
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
      Provider.of<UserPref>(context, listen: false)
          .save(_name, _pickedImageFilePath);
      Scaffold.of(context).showSnackBar(
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
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.85,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 16.0),
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
                child: UserImagePicker(_pickFile),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Consumer<DarkThemeProvider>(
                    builder: (_, theme, __) => TextFormField(
                      keyboardType: TextInputType.name,
                      autocorrect: true,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: theme.darkTheme
                              ? Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .surface
                              : null,
                        ),
                        labelText: 'Enter username',
                        border: UnderlineInputBorder(),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'username should be at least 3 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: _trySubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
