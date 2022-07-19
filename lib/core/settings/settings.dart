import 'package:flutter/material.dart';

import 'sections/switch_theme_tile.dart';
import 'sections/change_data_tile.dart';

const settingsList = [SwitchThemeTile(), ChangeDataTile()];

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline5,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ListBody(children: settingsList),
      ),
    );
  }
}
