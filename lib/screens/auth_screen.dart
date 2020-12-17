import 'package:flutter/material.dart';

import '../widgets/image_banner.dart';
import '../widgets/auth_form.dart';
import '../widgets/text_banner.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
          children: [
            Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo[300], Colors.indigo[900]],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.7],
        ),
      ),
            ),
            SingleChildScrollView(
      child: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: deviceSize.height * 0.07),
            Flexible(child: const ImageBanner()),
            Flexible(child: const TextBanner()),
            Flexible(
              flex: deviceSize.width > 600 ? 3 : 2,
              child: AuthForm(),
            ),
          ],
        ),
      ),
            ),
          ],
        ),
    );
  }
}
