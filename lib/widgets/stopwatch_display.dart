import 'package:flutter/material.dart';
import 'package:stepwatch_practice/helpers/format_number.dart';

class StopwatchDisplay extends StatelessWidget {
  const StopwatchDisplay({super.key, required this.duration});
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(formatNumber(duration.inMinutes)),
        Text(':'),
        Text(formatNumber(duration.inSeconds - duration.inMinutes * 60)),
      ],
    );
  }
}
