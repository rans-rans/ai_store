import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart' show cardBorderRadius, mediumFontWeight;
import '../../../../utils/helper_functions.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/screens/category_products_screen.dart';

class PopularCardWidget extends StatelessWidget {
  final Category category;
  const PopularCardWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        HelperFunctions.gotoPage(
          context: context,
          page: CategoryProductsScreen(category: category),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.43,
            height: size.height * 0.19,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardBorderRadius),
              image: DecorationImage(
                image: CachedNetworkImageProvider(category.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            category.name,
            style: const TextStyle(fontWeight: mediumFontWeight),
          )
        ],
      ),
    );
  }
}
