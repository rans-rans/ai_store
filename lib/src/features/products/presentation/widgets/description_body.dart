import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../constants/numbers.dart';
import '../../../../widgets/favorite_button.dart';
import '../../data/data_source/products_datasource.dart';
import '../../domain/entities/product_details.dart';
import 'image_carousel.dart';
import 'item_description_widget.dart';
import 'rating_sheet.dart';
import 'ratings_list.dart';

class DescriptionBody extends StatefulWidget {
  final ProductDetails product;
  final ValueNotifier selectedVariation;
  const DescriptionBody({
    super.key,
    required this.product,
    required this.selectedVariation,
  });

  @override
  State<DescriptionBody> createState() => _DescriptionBodyState();
}

class _DescriptionBodyState extends State<DescriptionBody> {
  final ratings = ValueNotifier<List<Rating>>([]);
  late ValueNotifier<double> averageRating;

  @override
  void initState() {
    super.initState();
    averageRating = ValueNotifier(widget.product.averageRating);
  }

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
              ImageCarousel(imagePaths: widget.product.images),
              Positioned(
                right: screenSize.width * 0.05,
                child: FavoriteButton(
                  productId: widget.product.productId,
                  isFavorite: widget.product.isFavorite,
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
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 4,
                  style: const TextStyle(
                    fontWeight: mediumFontWeight,
                  ),
                ),
                const SizedBox(height: smallSpacing),
                ItemDescriptionWidget(description: widget.product.description),
                const SizedBox(height: smallSpacing),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final rating = await showModalBottomSheet(
                          context: context,
                          isDismissible: false,
                          builder: (_) {
                            return RatingSheet(productId: widget.product.productId);
                          },
                          constraints:
                              BoxConstraints(maxHeight: screenSize.height * 0.7),
                        ) as Rating?;
                        if (rating != null) {
                          ratings.value = [rating, ...ratings.value];
                          final prodRatings = ratings.value.map((e) => e.score);
                          averageRating.value = prodRatings
                              .reduce((value, element) => value + element)
                              .toDouble();
                        }
                      },
                      child: ValueListenableBuilder(
                          valueListenable: averageRating,
                          builder: (context, rating, child) {
                            return RatingBarIndicator(
                              itemCount: 5,
                              rating: rating,
                              itemSize: 18,
                              itemBuilder: (context, _) {
                                return Icon(
                                  Icons.star,
                                  color: Theme.of(context).primaryColor,
                                );
                              },
                            );
                          }),
                    ),
                    const SizedBox(width: smallSpacing),
                    ValueListenableBuilder(
                      valueListenable: averageRating,
                      builder: (context, rating, child) {
                        return Text(
                          rating.toStringAsFixed(1),
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        );
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text('See all'),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return RatingsList(
                              ratings: ratings,
                              productId: widget.product.productId,
                            );
                          },
                        );
                      },
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
                      widget.selectedVariation.value = value;
                    },
                    dropdownMenuEntries: [
                      ...widget.product.variants.map(
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
                        Text("${widget.product.quantity}"),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text("Brand"),
                        Text(
                          widget.product.brand,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          )
        ],
      ),
    );
  }
}
