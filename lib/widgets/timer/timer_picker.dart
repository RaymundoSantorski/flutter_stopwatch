import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerPicker extends StatelessWidget {
  const TimerPicker({
    super.key,
    required this.duration,
    required this.setDuration,
    required this.startTimer,
  });
  final Duration duration;
  final void Function(Duration) setDuration;
  final VoidCallback startTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoTimerPicker(
          onTimerDurationChanged: setDuration,
          mode: CupertinoTimerPickerMode.ms,
        ),
        SizedBox(height: 100),
        CupertinoButton(
          onPressed: duration.inSeconds > 0 ? startTimer : null,
          color: Colors.blue,
          child: Text(
            'Iniciar',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
    ;
  }
}
