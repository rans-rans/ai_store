import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';

class LimitedTimeDealsWidget extends StatelessWidget {
  const LimitedTimeDealsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(iphone15Image),
          //TODO  item name comes here
          const Text(
            "2 Piece - Short Sleeve Polo Shirt - Blue/Black",
            style: TextStyle(fontSize: smallFontSize),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              //TODO  price comes here
              const Text(
                "GH₵ 45.92",
                style: TextStyle(
                  fontWeight: mediumFontWeight,
                ),
              ),
              //TODO discount comes here
              Text(
                "GH₵ 123.00",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Theme.of(context).primaryColor,
                  fontSize: smallFontSize,
                  decorationColor: Theme.of(context).primaryColor,
                  fontWeight: mediumFontWeight,
                ),
              ),
            ],
          ),
          Text(
            "62.8% OFF",
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
