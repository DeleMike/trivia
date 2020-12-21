import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  final double endTime;
  Timer(this.endTime);
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _valueTween;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10));
    _controller.forward();
    _valueTween = Tween<double>(begin: 0, end: widget.endTime);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant Timer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.endTime != oldWidget.endTime) {
      //try to start with the previous tween's end value. This ensures that we have smooth transition
      //from where the prvious animation reached

      double beginVal =
          _valueTween?.evaluate(_controller) ?? oldWidget?.endTime ?? 0;

      //update the value tween
      _valueTween = Tween<double>(begin: beginVal, end: widget.endTime ?? 1);

      _controller
        ..value
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
        child: Text('Time: ${widget.endTime.toInt()}', style: TextStyle(color: Colors.white,),),
      );
  }
}
