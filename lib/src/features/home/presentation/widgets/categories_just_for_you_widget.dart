import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';

class CategoriesJustForYouWidget extends StatelessWidget {
  const CategoriesJustForYouWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TODO  just for you image comes here
        ClipRRect(
          borderRadius: BorderRadius.circular(cardBorderRadius),
          child: Image.asset(
            redDressImage,
            // height: screenSize.height * 0.15,
            fit: BoxFit.cover,
          ),
        ),
        const Text(
          "Latest round neck short running from top to bottom",
          maxLines: 1,
          style: TextStyle(overflow: TextOverflow.ellipsis),
        ),
        const Text(
          "GH₵ 500.99",
          style: TextStyle(fontWeight: mediumFontWeight),
        ),
        const Text(
          "Free delivery•from Ghana",
          style: TextStyle(fontSize: smallFontSize, color: Colors.grey),
        )
      ],
    );
  }
}
