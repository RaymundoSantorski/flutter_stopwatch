import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stepwatch_practice/main.dart';

class TimerService extends StatefulWidget {
  const TimerService({super.key});

  @override
  State<TimerService> createState() => TimerServiceState();
}

class TimerServiceState<T extends TimerService> extends State<T> {
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

  void notify() {
    FlutterRingtonePlayer().playAlarm();
    showNotification();
  }

  Future<void> showNotification() async {
    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID único de la notificación
      'Temporizador',
      '¡Tu temporizador terminó!',
      platformChannelSpecifics,
      payload: 'Datos personalizados',
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
