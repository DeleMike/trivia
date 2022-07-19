import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../../helpers/dark_theme_provider.dart';

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
        title: Text('App Theme', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16)),
        subtitle: Text('change the app\'s current theme to ' '${switchIsOn ? 'light' : 'dark'}'),
        value: context.watch<DarkThemeProvider>().isDarkMode,
        inactiveThumbColor: kLightPrimaryColor,
        onChanged: (bool newSwitchState) {
          setState(() {
            switchIsOn = newSwitchState;
            context.read<DarkThemeProvider>().darkTheme = newSwitchState;
          });
        },
      ),
    );
  }
}
