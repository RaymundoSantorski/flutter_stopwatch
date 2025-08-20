import 'package:flutter/material.dart';
import 'package:stepwatch_practice/services/timer_service.dart';
import 'package:stepwatch_practice/widgets/timer/animated_progress_bar.dart';
import 'package:stepwatch_practice/widgets/timer/timer_display.dart';
import 'package:stepwatch_practice/widgets/timer/timer_picker.dart';

class MyTimer extends TimerService {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends TimerServiceState<MyTimer> {
  @override
  Widget build(BuildContext context) {
    return running
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              MyAnimatedProgressBar(initialDuration: initialDuration.inSeconds),
              TimerDisplay(duration: duration, exitTimer: exitTimer),
            ],
          )
        : TimerPicker(
            duration: duration,
            setDuration: setDuration,
            startTimer: startTimer,
          );
  }
}
