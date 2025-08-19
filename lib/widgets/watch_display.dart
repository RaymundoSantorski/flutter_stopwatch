import 'package:flutter/material.dart';
import 'package:stepwatch_practice/colors/watch_style.dart';
import 'package:stepwatch_practice/helpers/format_number.dart';

class WatchDisplay extends StatelessWidget {
  const WatchDisplay({super.key, required this.duration});
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(formatNumber(duration.inMinutes), style: textStyle),
        Text(':', style: textStyle),
        Text(
          formatNumber(duration.inSeconds - duration.inMinutes * 60),
          style: textStyle,
        ),
      ],
    );
  }
}
