import 'dart:async';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

class TimerService extends StatefulWidget {
  const TimerService({super.key});

  @override
  State<TimerService> createState() => TimerServiceState();
}

class TimerServiceState<T extends TimerService> extends State<T> {
  static bool workmanagerInitialized = false;
  Duration duration = Duration(minutes: 0, seconds: 0);
  late Duration initialDuration;
  bool running = false;
  Timer? _timer;

  void startTimer() {
    if (running) return;
    setRunning(true);
    setInitialDuration();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (duration.inSeconds <= 0) {
        notify();
        exitTimer();
      }
      setState(() {
        duration = Duration(seconds: duration.inSeconds - 1);
      });
    });
  }

  void setRunning(bool value) {
    setState(() {
      running = value;
    });
  }

  void setInitialDuration() {
    setState(() {
      initialDuration = duration;
    });
  }

  void notify() async {
    Workmanager().registerOneOffTask(
      'showNotification',
      'showNotification',
      initialDelay: Duration(seconds: duration.inSeconds),
    );
  }

  void exitTimer() {
    _timer?.cancel();
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
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
