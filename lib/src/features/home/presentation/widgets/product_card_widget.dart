import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  const ProductCardWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnlineImage(
              image: product.images.first,
              height: screenSize.height * 0.17,
            ),
            //product name comes here
            Text(
              product.name,
              style: const TextStyle(fontSize: smallFontSize),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                //discount price comes here
                Text(
                  HelperFunctions.getDiscountAmount(
                    product.price,
                    product.discount,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: mediumFontWeight,
                  ),
                ),
                //original price comes here
                if (product.discount > 0)
                  Text(
                    HelperFunctions.formatToCurrency(product.price),
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Theme.of(context).primaryColor,
                      fontSize: smallFontSize,
                      fontWeight: mediumFontWeight,
                    ),
                  ),
              ],
            ),
            //discount comes here
            if (product.discount > 0)
              Text(
                "${product.discount}% OFF",
                style: TextStyle(
                  fontSize: smallFontSize,
                  color: Theme.of(context).primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
