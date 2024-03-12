import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart' show mediumFontWeight;
import '../../../../utils/helper_functions.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            height: size.width * 0.3,
            imageUrl: widget.product.images.first,
            imageBuilder: (context, imageProvider) {
              return SizedBox(
                width: size.width * 0.33,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              );
            },
          ),
          Text(
            widget.product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            HelperFunctions.formatToCurrency(widget.product.price),
            style: const TextStyle(fontWeight: mediumFontWeight),
          ),
        ],
      ),
    );
  }
}
