import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
     return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.indigo[400],
        ),
        FlatButton.icon(
          icon: Icon(Icons.image),
          label: Text('Add image'),
          textColor: Theme.of(context).primaryColor,
          onPressed: () {},
        ),
      ],
    );
  }
}