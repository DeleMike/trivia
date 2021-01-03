import 'package:flutter/material.dart';

///[TextBanner] - used a banner for auth screen.
class TextBanner extends StatelessWidget {
  const TextBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        'Trivia!',
        style: TextStyle(
          fontSize: 40,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.2
            ..color = Colors.white,
        ),
      ),
    );
  }
}
