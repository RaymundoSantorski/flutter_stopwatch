import 'package:flutter/cupertino.dart';

class StopwatchButton extends StatelessWidget {
  const StopwatchButton({
    super.key,
    required this.borderColor,
    required this.color,
    required this.onPressed,
    required this.textColor,
    required this.label,
  });
  final Color borderColor;
  final Color color;
  final VoidCallback onPressed;
  final Color textColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: color,
      ),
      child: CupertinoButton(
        color: color,
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
