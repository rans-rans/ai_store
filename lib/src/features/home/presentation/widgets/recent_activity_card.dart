import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart' show mediumFontWeight;
import '../../../../constants/strings.dart' show iphone15Image;

class RecentActivityCard extends StatelessWidget {
  // final String imageUrl;
  // final String itemName;
  // final double itemPrice;
  const RecentActivityCard({
    super.key,
    // required this.imageUrl,
    // required this.itemName,
    // required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        //TODO use network-image later
        Image.asset(
          iphone15Image,
          fit: BoxFit.cover,
          height: size.width * 0.33,
        ),
        //TODO item name comes here
        const Text("IPhone 15 pro"),
        //TODO item price comes here
        const Text(
          "GH₵ 2300.00",
          style: TextStyle(fontWeight: mediumFontWeight),
        ),
      ],
    );
  }
}
