import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  final int endTime;
  Timer(this.endTime);
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.indigo[200],
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
    );
  }
}
