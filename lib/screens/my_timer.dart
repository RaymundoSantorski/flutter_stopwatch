import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepwatch_practice/services/timer_service.dart';
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
              MyAnimatedProgressBar(
                duration: duration.inSeconds,
                initialDuration: initialDuration.inSeconds,
              ),
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

class MyAnimatedProgressBar extends StatefulWidget {
  const MyAnimatedProgressBar({
    super.key,
    required this.duration,
    required this.initialDuration,
  });
  final int duration;
  final int initialDuration;

  @override
  State<MyAnimatedProgressBar> createState() => _MyAnimatedProgressBarState();
}

class _MyAnimatedProgressBarState extends State<MyAnimatedProgressBar>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller =
        AnimationController(
          /// [AnimationController]s can be created with `vsync: this` because of
          /// [TickerProviderStateMixin].
          vsync: this,
          reverseDuration: Duration(),
          duration: Duration(seconds: widget.initialDuration + 1),
        )..addListener(() {
          setState(() {});
        });
    if (controller.isCompleted) return;
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: CircularProgressIndicator(
          constraints: BoxConstraints(minWidth: 400, minHeight: 400),
          strokeWidth: 10,
          color: Colors.blue,
          value: controller.value,
        ),
      ),
    );
  }
}
