import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO cart-item image comes here
          Image.asset(
            fridgeImage,
            width: MediaQuery.sizeOf(context).width * 0.4,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: smallFontSize),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Double door fridge with android display, very efficient",
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: mediumFontWeight,
                  ),
                ),
                //TODO cart-item variant comes here
                const Text(
                  "Size: Regular,color: grey",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove),
                    ),
                    //TODO cart-item quantity here
                    const Text("1"),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                //TODO cart-item price over here
                const Text(
                  "GH₵ 5060.00",
                  style: TextStyle(
                    fontSize: mediumFontSize,
                    fontWeight: boldestFontWeight,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
