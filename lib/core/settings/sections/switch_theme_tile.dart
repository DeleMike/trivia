import 'package:flutter/material.dart';

import '../../../configs/constants.dart';

class SwitchThemeTile extends StatefulWidget {
  const SwitchThemeTile({Key? key}) : super(key: key);

  @override
  State<SwitchThemeTile> createState() => _SwitchThemeTileState();
}

class _SwitchThemeTileState extends State<SwitchThemeTile> {
  bool switchIsOn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kPaddingM + 2, bottom: kPaddingS),
      child: SwitchListTile(
        title: const Text('App Theme'),
        subtitle: Text('change the app\'s current theme to ' '${switchIsOn ? 'light' : 'dark'}'),
        value: switchIsOn,
        inactiveThumbColor: kLightPrimaryColor,
        onChanged: (bool newSwitchState) {
          setState(() {
            switchIsOn = newSwitchState;
          });
        },
      ),
    );
  }
}
