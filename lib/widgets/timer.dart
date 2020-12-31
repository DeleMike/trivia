import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia/helpers/dark_theme_provider.dart';

class Timer extends StatefulWidget {
  final int endTime;
  Timer(this.endTime);
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
          builder: (_, theme, __) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.darkTheme ? Colors.black : Colors.indigo[200],
              spreadRadius: 3,
              blurRadius: 8,
              offset: Offset(-2, 3),
            ),
          ],
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
          //borderRadius: BorderRadius.circular(12),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '${widget.endTime}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
