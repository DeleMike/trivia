import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spinkit;

///[SplashScreen] - as a waiting screen.
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: spinkit.SpinKitWanderingCubes(color: Theme.of(context).primaryColor,)
        ),
      ),
    );
  }
}
