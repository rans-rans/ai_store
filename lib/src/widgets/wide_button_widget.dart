import 'package:flutter/material.dart';

import '../constants/numbers.dart' show buttonBorderRadius, mediumFontSize;

class WideButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  const WideButtonWidget({
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: mediumFontSize,
          color: color,
        ),
      ),
    );
  }
}
