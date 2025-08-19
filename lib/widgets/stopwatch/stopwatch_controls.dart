import 'package:flutter/material.dart';
import 'package:stepwatch_practice/widgets/stopwatch/stopwatch_button.dart';

class StopwatchControls extends StatelessWidget {
  const StopwatchControls({
    super.key,
    required this.style,
    required this.isRunning,
    required this.pauseStopwatch,
    required this.startStopwatch,
    required this.restartStopWatch,
    required this.stopStopwatch,
  });
  final ColorScheme style;
  final bool isRunning;
  final VoidCallback pauseStopwatch;
  final VoidCallback startStopwatch;
  final VoidCallback restartStopWatch;
  final VoidCallback stopStopwatch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isRunning
            ? StopwatchButton(
                borderColor: style.primary,
                color: style.primary,
                onPressed: pauseStopwatch,
                textColor: style.onPrimary,
                label: '   Pausar  ',
              )
            : StopwatchButton(
                borderColor: style.primary,
                color: style.primary,
                onPressed: startStopwatch,
                textColor: style.onPrimary,
                label: 'Continuar',
              ),
        StopwatchButton(
          borderColor: style.onSecondary,
          color: style.secondary,
          onPressed: restartStopWatch,
          textColor: style.onSecondary,
          label: 'Reiniciar',
        ),
        StopwatchButton(
          borderColor: style.error,
          color: style.onPrimary,
          onPressed: stopStopwatch,
          textColor: style.error,
          label: 'Detener',
        ),
      ],
    );
  }
}
