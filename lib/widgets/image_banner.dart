import 'package:flutter/material.dart';

///[ImageBanner] - displays app logo
class ImageBanner extends StatelessWidget {
  const ImageBanner();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      width: 150,
      decoration: BoxDecoration(
      ),
      child: Image.asset('assets/images/logo.png', fit: BoxFit.fill,),
    );
  }
}
