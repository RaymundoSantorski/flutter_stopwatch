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
  bool unmounted = false;
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
      if (!unmounted) await notify();
      exitTimer();
    }
  }

  Future<void> notify() async {
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

  void startTimer() {
    if (duration.inSeconds == 0) return;
    if (mounted) {
      setState(() {
        unmounted = false;
        initialDuration = duration;
        running = true;
      });
    }
    timerFunction();
  }

  void exitTimer() {
    if (mounted) {
      setState(() {
        unmounted = true;
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
