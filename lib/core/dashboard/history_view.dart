import 'package:flutter/material.dart';

import '../../configs/constants.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kBlack),
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kCanvasColor,
      ),
      body: const Center(child: Text('Coming soon...'),),
    );
  }
}
