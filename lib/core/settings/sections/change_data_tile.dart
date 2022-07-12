import 'package:flutter/material.dart';

import '../../../configs/constants.dart';

class ChangeDataTile extends StatelessWidget {
  const ChangeDataTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kPaddingM + 2, bottom: kPaddingS),
      child: InkWell(
        onTap: () {
          debugPrint('Open \'change bio\' page');
        },
        child: ListTile(
          title: Text('Biodata', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 16)),
          subtitle: const Text('change your name or profile picture'),
        ),
      ),
    );
  }
}
