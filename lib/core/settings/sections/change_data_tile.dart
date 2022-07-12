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
        child: const ListTile(
          title: Text('Biodata'),
          subtitle: Text('change your name or user picture'),
        ),
      ),
    );
  }
}
