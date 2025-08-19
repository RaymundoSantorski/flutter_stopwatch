import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepwatch_practice/helpers/format_number.dart';
import 'package:stepwatch_practice/widgets/watch_display.dart';

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

  void _setDuration(Duration value) {
    setState(() {
      duration = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return running
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WatchDisplay(duration: duration),
              SizedBox(height: 100),
              CupertinoButton(
                onPressed: exitTimer,
                color: Colors.blue,
                child: Text(
                  'Detener',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTimerPicker(
                onTimerDurationChanged: _setDuration,
                mode: CupertinoTimerPickerMode.ms,
              ),
              SizedBox(height: 100),
              CupertinoButton(
                onPressed: duration.inSeconds > 0 ? startTimer : null,
                color: Colors.blue,
                child: Text(
                  'Iniciar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
  }
}
