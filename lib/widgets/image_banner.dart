import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      width: 100,
      decoration: BoxDecoration(
      ),
      child: Image.asset('assets/images/logo.png', fit: BoxFit.fill,),
    );
  }
}
