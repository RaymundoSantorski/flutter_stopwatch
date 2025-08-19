import 'package:flutter/cupertino.dart';
import 'package:stepwatch_practice/services/stopwatch_service.dart';
import 'package:stepwatch_practice/widgets/stopwatch_button.dart';
import 'package:stepwatch_practice/widgets/stopwatch_controls.dart';
import 'package:stepwatch_practice/widgets/watch_display.dart';

class MyStopWatch extends StopwatchService {
  const MyStopWatch({super.key});

  @override
  State<MyStopWatch> createState() => _MyStopWatchState();
}

class _MyStopWatchState extends StopwatchServiceState<MyStopWatch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          WatchDisplay(duration: duration),
          duration.inSeconds == 0
              ? StopwatchButton(
                  borderColor: buttonStyle.primary,
                  color: buttonStyle.primary,
                  onPressed: startStopwatch,
                  textColor: buttonStyle.onPrimary,
                  label: 'Iniciar',
                )
              : StopwatchControls(
                  style: buttonStyle,
                  isRunning: running,
                  pauseStopwatch: pauseStopwatch,
                  startStopwatch: startStopwatch,
                  restartStopWatch: restartStopWatch,
                  stopStopwatch: stopStopwatch,
                ),
        ],
      ),
    );
  }
}
