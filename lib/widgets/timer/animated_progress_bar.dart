import 'package:flutter/material.dart';

class MyAnimatedProgressBar extends StatefulWidget {
  const MyAnimatedProgressBar({super.key, required this.initialDuration});
  final int initialDuration;

  @override
  State<MyAnimatedProgressBar> createState() => _MyAnimatedProgressBarState();
}

class _MyAnimatedProgressBarState extends State<MyAnimatedProgressBar>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(
          /// [AnimationController]s can be created with `vsync: this` because of
          /// [TickerProviderStateMixin].
          vsync: this,
          duration: Duration(seconds: widget.initialDuration + 1),
        )..addListener(() {
          setState(() {});
        });
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
