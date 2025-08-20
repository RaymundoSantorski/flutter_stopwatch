import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class TimerService extends StatefulWidget {
  const TimerService({super.key});

  @override
  State<TimerService> createState() => TimerServiceState();
}

class TimerServiceState<T extends TimerService> extends State<T> {
  Duration duration = Duration(minutes: 0, seconds: 0);
  bool running = false;

  Future<void> timerFunction() async {
    await Future.delayed(Duration(seconds: 1));
    if (mounted) {
      setState(() {
        duration = Duration(seconds: duration.inSeconds - 1);
      });
    }
    if (duration.inSeconds >= 0) {
      timerFunction();
    } else {
      await notify();
      exitTimer();
    }
  }

  Future<void> notify() async {
    FlutterRingtonePlayer().playAlarm();
  }

  void startTimer() {
    if (duration.inSeconds == 0) return;
    if (mounted) {
      setState(() {
        running = true;
      });
    }
    timerFunction();
  }

  void exitTimer() {
    if (mounted) {
      setState(() {
        duration = Duration();
        running = false;
      });
    }
  }

  void setDuration(Duration value) {
    if (mounted) {
      setState(() {
        duration = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
