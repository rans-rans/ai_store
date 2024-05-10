import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';
import '../../../../utils/helper_functions.dart';
import '../../../products/domain/entities/product_details.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';

class SearchResultTile extends StatelessWidget {
  final ProductDetails product;
  const SearchResultTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        HelperFunctions.gotoPage(
          context: context,
          page: ProductDetailScreen(
            productId: product.hashCode,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(cardBorderRadius),
                  child: Image.asset(
                    fridgeImage,
                    width: screenSize.width * 0.5,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //TODO toggle is favorite here
                  },
                  child: const Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white12,
                      child: Icon(
                        Icons.favorite_border,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: smallSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: smallSpacing),
                  Text(
                    product.name,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      fontWeight: mediumFontWeight,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: smallFontSize,
                    ),
                  ),
                  const SizedBox(height: smallSpacing),
                  Text(
                    HelperFunctions.formatToCurrency(product.price),
                    style: const TextStyle(fontWeight: mediumFontWeight),
                  ),
                  if (product.discount > 0)
                    Text(
                      """${HelperFunctions.getDiscountAmount(product.price, product.discount)}"""
                      """• ${product.discount}% off""",
                      style: const TextStyle(
                        fontSize: smallFontSize,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
