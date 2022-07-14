import 'package:flutter/material.dart';

import '../configs/constants.dart';

/// Default look for most elevated buttons
class DialogButton extends StatelessWidget {
  const DialogButton({Key? key, required this.text, required this.onPressEvent}) : super(key: key);

  final String text;
  final Function()? onPressEvent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).brightness == Brightness.dark ? kBlack : kPrimaryColor,
        minimumSize: Size(kScreenWidth(context) * 0.8, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kButtonRadius),
        ),
      ),
      onPressed: onPressEvent,
      child:Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style:Theme.of(context).textTheme.bodyText2!.copyWith(color: kWhite)
        ),
      ),
    );
  }
}