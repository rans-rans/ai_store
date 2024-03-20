import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../domain/entities/brand.dart';
import '../screens/brand_products_screen.dart';

class BrandChip extends StatelessWidget {
  const BrandChip({
    super.key,
    required this.brand,
  });

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HelperFunctions.gotoPage(
          context: context,
          page: BrandProductsScreen(brand: brand),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: OnlineImage(
              image: brand.image,
            ),
          ),
          Text(
            brand.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: mediumFontWeight),
          )
        ],
      ),
    );
  }
}
