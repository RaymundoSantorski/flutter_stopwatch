import 'package:flutter/material.dart';

class StopwatchService extends StatefulWidget {
  const StopwatchService({super.key});

  @override
  State<StopwatchService> createState() => StopwatchServiceState();
}

class StopwatchServiceState<T extends StopwatchService> extends State<T> {
  Duration duration = Duration();
  bool running = false;

  Future<void> stopwatchFunction() async {
    if (running == false) return;
    await Future.delayed(Duration(seconds: 1));
    if (mounted) {
      setState(() {
        duration = Duration(seconds: duration.inSeconds + 1);
      });
    }
    stopwatchFunction();
  }

  Future<void> pauseStopwatch() async {
    if (mounted) {
      setState(() {
        running = false;
      });
    }
  }

  Future<void> stopStopwatch() async {
    running = false;
    await Future.delayed(Duration(seconds: 1));
    duration = Duration();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> restartStopWatch() async {
    await pauseStopwatch();
    await stopStopwatch();
    startStopwatch();
  }

  Future<void> startStopwatch() async {
    if (mounted) {
      setState(() {
        running = true;
      });
    }
    stopwatchFunction();
  }

  ColorScheme buttonStyle = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.blue,
    error: Colors.redAccent,
    onError: Colors.black,
    surface: Colors.grey,
    onSurface: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
