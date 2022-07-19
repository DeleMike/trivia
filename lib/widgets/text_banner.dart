import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/constants.dart';

///[TextBanner] - used a banner for auth screen.
class TextBanner extends StatelessWidget {
  const TextBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: 'Hey there!\n',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 60,
                fontFamily: GoogleFonts.caveatBrush().fontFamily,
                wordSpacing: 2.0,
              ),
          children: [
            const TextSpan(
              text: 'Nice to meet you.\n',
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 25,
                wordSpacing: 2.0,
              ),
            ),
            TextSpan(
              text: 'Please give us some little info about you',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontFamily: GoogleFonts.ubuntu().fontFamily,
                height: 1.8,
                fontSize: 12,
                color: Theme.of(context).brightness == Brightness.dark ? kWhite : kBlack,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
