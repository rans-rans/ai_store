import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart' show cardBorderRadius;

class PopularCardWidget extends StatelessWidget {
  const PopularCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.43,
      height: size.height * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: const Placeholder(),
    );
  }
}
