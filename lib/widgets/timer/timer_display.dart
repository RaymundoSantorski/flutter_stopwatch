import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepwatch_practice/widgets/watch_display.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({
    super.key,
    required this.duration,
    required this.exitTimer,
  });
  final Duration duration;
  final VoidCallback exitTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WatchDisplay(duration: duration),
        SizedBox(height: 100),
        CupertinoButton(
          onPressed: exitTimer,
          color: Colors.blue,
          child: Text(
            'Detener',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
