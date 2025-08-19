import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepwatch_practice/widgets/timer/timer_display.dart';
import 'package:stepwatch_practice/widgets/timer/timer_picker.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  Duration duration = Duration(minutes: 0, seconds: 0);
  bool running = false;

  Future<void> timerFunction() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      duration = Duration(seconds: duration.inSeconds - 1);
    });
    if (duration.inSeconds >= 0) {
      timerFunction();
    } else {
      exitTimer();
    }
  }

  void startTimer() {
    if (duration.inSeconds == 0) return;
    setState(() {
      running = true;
    });
    timerFunction();
  }

  void exitTimer() {
    setState(() {
      duration = Duration();
      running = false;
    });
  }

  void setDuration(Duration value) {
    setState(() {
      duration = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return running
        ? TimerDisplay(duration: duration, exitTimer: exitTimer)
        : TimerPicker(
            duration: duration,
            setDuration: setDuration,
            startTimer: startTimer,
          );
  }
}
