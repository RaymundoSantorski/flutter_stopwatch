import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StopwatchService extends StatefulWidget {
  const StopwatchService({super.key});

  @override
  State<StopwatchService> createState() => StopwatchServiceState();
}

class StopwatchServiceState<T extends StopwatchService> extends State<T> {
  Duration duration = Duration();
  bool running = false;
  bool showControls = false;
  Timer? _timer;

  Future<void> start() async {
    if (running) return;
    running = true;
    setControls(true);
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    prefs.setInt('initDate', DateTime.now().millisecondsSinceEpoch);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      int initDate = await prefs.getInt('initDate') ?? 0;
      setState(() {
        int miliseconds = (DateTime.now().millisecondsSinceEpoch - initDate);
        duration = Duration(milliseconds: miliseconds);
      });
    });
  }

  void stopStopwatch() async {
    resetStopwatch();
    setControls(false);
    setRunning(false);
    _timer?.cancel();
  }

  void pauseStopwatch() {
    setRunning(false);
    _timer?.cancel();
  }

  void restartStopWatch() {
    _timer?.cancel();
    resetStopwatch();
    start();
  }

  void resetStopwatch() {
    setState(() {
      setRunning(false);
      duration = Duration();
    });
  }

  void setRunning(bool value) {
    setState(() {
      running = value;
    });
  }

  void setControls(bool value) {
    setState(() {
      showControls = value;
    });
  }

  ColorScheme buttonStyle = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.pinkAccent,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.pinkAccent,
    error: Colors.redAccent,
    onError: Colors.black,
    surface: Colors.grey,
    onSurface: Colors.white,
  );

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
