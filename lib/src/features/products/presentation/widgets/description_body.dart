import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../widgets/favorite_button.dart';
import '../../domain/entities/product_details.dart';
import 'image_carousel.dart';
import 'item_description_widget.dart';

class DescriptionBody extends StatelessWidget {
  final ProductDetails product;
  final ValueNotifier selectedVariation;
  const DescriptionBody({
    super.key,
    required this.product,
    required this.selectedVariation,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ImageCarousel(imagePaths: product.images),
              Positioned(
                right: screenSize.width * 0.05,
                child: FavoriteButton(
                  productId: product.productId,
                  isFavorite: product.isFavorite,
                ),
              )
            ],
          ),
          const SizedBox(height: smallSpacing),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 4,
                  style: const TextStyle(
                    fontWeight: mediumFontWeight,
                  ),
                ),
                const SizedBox(height: smallSpacing),
                ItemDescriptionWidget(description: product.description),
                const SizedBox(height: smallSpacing),
                //TODO add functionality to rating stars
                Row(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                        Icon(Icons.star_border),
                      ],
                    ),
                    Text(
                      //TODO add number of ratings here
                      "531 ratings",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: mediumSpacing),
                Align(
                  alignment: Alignment.center,
                  child: DropdownMenu(
                    label: const Text("Select variant"),
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    onSelected: (value) {
                      selectedVariation.value = value;
                    },
                    dropdownMenuEntries: [
                      ...product.variants.map(
                        (variant) => DropdownMenuEntry(
                          value: variant,
                          label: variant,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: mediumSpacing * 2.5),
                const Text(
                  "About this item",
                  style: TextStyle(
                    fontWeight: mediumFontWeight,
                    fontSize: mediumFontSize,
                  ),
                ),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.4),
                    1: FlexColumnWidth(0.6),
                  },
                  children: [
                    const TableRow(
                      children: [
                        Text("Condition"),
                        Text("New"),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text("Quanntity status"),
                        Text("${product.quantity}"),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text("Brand"),
                        Text(
                          product.brand,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                //TODO add reviews and similar products below
              ],
            ),
          )
        ],
      ),
    );
  }
}
