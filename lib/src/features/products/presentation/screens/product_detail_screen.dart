import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/remove_from_cart_button.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../cart/domain/entities/express_cart.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../domain/entities/product.dart';
import '../blocs/product/product_bloc.dart';
import '../widgets/image_carousel.dart';
import '../widgets/increment_decrement_item_widget.dart';
import '../widgets/item_description_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? itemVariation;

  late bool isFavorite;

  bool favoriteLoading = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product.favorite;
  }

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
        ],
      ),
      bottomSheet: Container(
        height: 85,
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartFetchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final itemExists = state is CartFetchSuccess &&
                state.cart.products
                    .any((product) => product.productId == widget.product.id);

            if (itemExists) {
              final cartProduct = state.cart.products
                  .firstWhere((item) => item.productId == widget.product.id);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RemoveFromCartButton(productId: widget.product.id),
                  IncrementDecrementItemWidget(
                    cartProduct: cartProduct,
                    product: widget.product,
                  )
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.product.discount > 0)
                      Row(
                        children: [
                          //original price comes here
                          Text(
                            HelperFunctions.formatToCurrency(widget.product.price),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              // color: Colors.grey,
                              fontWeight: mediumFontWeight,
                            ),
                          ),
                          //discount percent shows here
                          DecoratedBox(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 5,
                              ),
                              child: Text("${widget.product.discount}%"),
                            ),
                          ),
                        ],
                      ),
                    //discount price comes here
                    Text(
                      switch (widget.product.discount > 0) {
                        true => HelperFunctions.getDiscountAmount(
                            widget.product.price, widget.product.discount),
                        false =>
                          HelperFunctions.formatToCurrency(widget.product.price),
                      },
                      style: const TextStyle(
                        fontWeight: mediumFontWeight,
                        fontSize: largeFontSize,
                      ),
                    ),
                  ],
                ),

                //ADD TO CART button
                ElevatedButton(
                  onPressed: () async {
                    if (itemVariation == null) {
                      HelperFunctions.snackShow(
                          context, "Please select item-variant");
                      return;
                    }
                    final user = context.read<AuthBloc>().user;

                    context.read<CartBloc>().add(AddProductToCartEvent(
                          cartItem: ExpressCartItem(
                              quantity: 1,
                              productId: widget.product.id,
                              itemVariation: itemVariation!,
                              userId: user!.userId,
                              discount: widget.product.discount,
                              productName: widget.product.name,
                              productPrice: widget.product.price,
                              imageUrl: widget.product.images.first),
                          token: user.authToken,
                        ));
                  },
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
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ImageCarousel(imagePaths: widget.product.images),
                Positioned(
                  right: screenSize.width * 0.05,
                  child: StatefulBuilder(
                    builder: (context, snap) {
                      return CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white30,
                          child: switch (favoriteLoading) {
                            true => const CircularProgressIndicator(),
                            false => IconButton(
                                onPressed: () async {
                                  snap(() => favoriteLoading = true);
                                  try {
                                    final user = context.read<AuthBloc>().user;
                                    final fav = await context
                                        .read<ProductBloc>()
                                        .toggleFavorite(
                                          userId: user!.userId,
                                          productId: widget.product.id,
                                          token: user.authToken,
                                        );
                                    isFavorite = fav;
                                  } finally {
                                    snap(() => favoriteLoading = false);
                                  }
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
                                  },
                                ),
                              ),
                          });
                    },
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
                        itemVariation = value;
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
