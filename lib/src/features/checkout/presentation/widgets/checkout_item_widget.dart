import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../../cart/domain/entities/cart.dart';

class CheckoutItemWidget extends StatelessWidget {
  const CheckoutItemWidget({
    super.key,
    required this.cartItem,
    required this.screenSize,
  });

  final CartItem cartItem;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnlineImage(
          image: cartItem.imageUrl,
          width: screenSize.width * 0.4,
        ),
        const SizedBox(width: smallSpacing),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width * 0.5,
              child: Text(
                cartItem.productName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: mediumFontWeight,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  const TextSpan(text: 'Qty:'),
                  TextSpan(text: cartItem.quantity.toString()),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  HelperFunctions.getDiscountAmount(
                      cartItem.productPrice * cartItem.quantity, cartItem.discount),
                  style: const TextStyle(
                    fontSize: mediumFontSize,
                    fontWeight: boldestFontWeight,
                  ),
                ),
                if (cartItem.discount > 0)
                  Text(
                    HelperFunctions.formatToCurrency(
                        cartItem.productPrice * cartItem.quantity),
                    style: TextStyle(
                      fontSize: smallFontSize,
                      fontWeight: boldestFontWeight,
                      decoration: TextDecoration.lineThrough,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
