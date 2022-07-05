import 'package:flutter/material.dart';

import '../widgets/dialog_button.dart';
import '../configs/constants.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({Key? key, required this.text}) : super(key: key);

  final String text;

  contentBox(BuildContext context) {
    return SizedBox(
      height: kScreenHeight(context) * 0.4,
      child: Stack(
        children: <Widget>[
          Container(
            height: kScreenHeight(context) * 0.4,
            decoration: BoxDecoration(
              color: kLightPrimaryColor,
              borderRadius: BorderRadius.circular(kDialogRadius),
            ),
          ), // bottom part
          Positioned(
            child: Container(
              height: kScreenHeight(context) * 0.385,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(kDialogRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 80,
                      child: CircleAvatar(
                        minRadius: 20,
                        child: Image.asset(
                          AssetsImages.appIcon,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(kPaddingS),
                    child: DialogButton(
                      text: 'Try again',
                      onPressEvent: () => Navigator.of(context).pop(),
                    ),
                  )
                ],
              ),
            ),
          ), // top part
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDialogRadius),
      ),
      elevation: 0,
      backgroundColor: kTransparent,
      child: contentBox(context),
    );
  }
}