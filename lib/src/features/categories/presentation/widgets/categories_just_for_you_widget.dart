import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';

class CategoriesJustForYouWidget extends StatelessWidget {
  final Product product;
  const CategoriesJustForYouWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        HelperFunctions.gotoPage(
          context: context,
          page: ProductDetailScreen(product: product),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(cardBorderRadius),
            child: OnlineImage(
              image: product.images.first,
              height: screenSize.height * 0.2,
            ),
          ),
          Text(
            product.name,
            maxLines: 1,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
          Text(
            HelperFunctions.getDiscountAmount(product.price, product.discount),
            style: const TextStyle(fontWeight: mediumFontWeight),
          ),
        ],
      ),
    );
  }
}
