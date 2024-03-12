import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../domain/entities/product.dart';
import '../blocs/product/product_bloc.dart';
import '../widgets/image_carousel.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //TODO add sharing logic here
            },
            icon: const Icon(Icons.share),
          ),
          PopupMenuButton(
            tooltip: "more",
            offset: const Offset(0, 45),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cardBorderRadius)),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add wishlist logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.star),
                      Text("My Favorites"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add wishlist logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.download),
                      Text("Save to wishlist"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add watch logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.visibility),
                      Text("Watch this item"),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                child: InkWell(
                  onTap: () {
                    //TODO add report logic
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.report),
                      Text("Report"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomSheet: Container(
        height: 85,
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.discount > 0)
                  Row(
                    children: [
                      Text(
                        HelperFunctions.formatToCurrency(product.price),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 5,
                          ),
                          child: Text("${product.discount}%"),
                        ),
                      ),
                    ],
                  ),
                Text(
                  switch (product.discount > 0) {
                    true => HelperFunctions.getDiscountAmount(
                        product.price, product.discount),
                    false => HelperFunctions.formatToCurrency(product.price),
                  },
                  style: const TextStyle(
                    fontWeight: mediumFontWeight,
                    fontSize: largeFontSize,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(screenSize.width * 0.4, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonBorderRadius),
                ),
              ),
              child: const Text("ADD TO CART"),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ImageCarousel(imagePaths: product.images),
                Positioned(
                  right: screenSize.width * 0.05,
                  child: StreamBuilder(
                      stream: context.read<ProductBloc>().listenToFavoriteStatus(
                            //TODO user-id comes here
                            userId: 'uuwf0DwxHi6cwG3vPZkJ',
                            productId: product.id,
                          ),
                      builder: (context, snapshot) {
                        final isFavorite = snapshot.data ?? false;

                        return CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white30,
                          child: IconButton(
                            onPressed: () {
                              context.read<ProductBloc>().add(
                                    ToggleProductFavorite(
                                      productId: product.id,
                                      //TODO user-id comes here
                                      userId: 'uuwf0DwxHi6cwG3vPZkJ',
                                      value: !isFavorite,
                                    ),
                                  );
                            },
                            icon: Icon(
                                switch (isFavorite) {
                                  true => Icons.favorite,
                                  false => Icons.favorite_border,
                                },
                                size: 40,
                                color: switch (isFavorite) {
                                  true => Theme.of(context).primaryColor,
                                  false => Theme.of(context).colorScheme.secondary,
                                }),
                          ),
                        );
                      }),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReadMoreText(
                      product.description,
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' ...Show less',
                      lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                      moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
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
                        //TODO selected variant logic
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
                      const TableRow(
                        children: [
                          Text("Quanntity status"),
                          Text("Plenty"),
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
      ),
    );
  }
}
