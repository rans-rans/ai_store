import 'package:flutter/material.dart';

import '../../../../constants/strings.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          ps5PadImage,
          height: screenSize.height * 0.45,
          width: double.infinity,
        ),
        //TODO carousel dots come here
      ],
    );
  }
}
