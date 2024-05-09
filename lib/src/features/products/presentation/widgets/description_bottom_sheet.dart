import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/remove_from_cart_button.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../cart/domain/entities/express_cart.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../domain/entities/product_details.dart';
import 'increment_decrement_item_widget.dart';

class DescriptionBottomSheet extends StatelessWidget {
  final AsyncSnapshot<ProductDetails> snapshot;
  final ValueNotifier<String?> selectedVariation;
  const DescriptionBottomSheet({
    super.key,
    required this.snapshot,
    required this.selectedVariation,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final authUser = context.read<AuthBloc>().user!;
    return Container(
      height: 85,
      alignment: Alignment.center,
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          //checking for product loading
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const SizedBox.shrink();
          }
          //at the point, we check again if the product is in the cart
          if (state is CartFetchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartFetchFailed || state is CartInitial) {
            return ElevatedButton(
              child: const Text('Fetch Cart'),
              onPressed: () {
                context.read<CartBloc>().add(
                      GetUserCart(
                        userId: authUser.userId,
                        token: authUser.authToken,
                      ),
                    );
              },
            );
          }
          //at this poit, we can safely say, we have a product
          final product = snapshot.data!;
          final itemExists = state is CartFetchSuccess &&
              state.cart.products.any((item) => item.productId == product.productId);
          if (itemExists) {
            final cartProduct = state.cart.products
                .firstWhere((item) => item.productId == product.productId);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RemoveFromCartButton(productId: product.productId),
                IncrementDecrementItemWidget(
                  cartProduct: cartProduct,
                  productId: product.productId,
                  productQuantity: product.quantity,
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
                  if (product.discount > 0)
                    Row(
                      children: [
                        //original price comes here
                        Text(
                          HelperFunctions.formatToCurrency(product.price),
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
                            child: Text("${product.discount}%"),
                          ),
                        ),
                      ],
                    ),
                  //discount price comes here
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

              //ADD TO CART button
              ElevatedButton(
                onPressed: () async {
                  if (selectedVariation.value == null) {
                    HelperFunctions.snackShow(context, "Please select item-variant");
                    return;
                  }

                  context.read<CartBloc>().add(
                        AddProductToCartEvent(
                          cartItem: ExpressCartItem(
                              quantity: 1,
                              productId: product.productId,
                              itemVariation: selectedVariation.value!,
                              userId: authUser.userId,
                              discount: product.discount,
                              productName: product.name,
                              productPrice: product.price,
                              imageUrl: product.images.first),
                          token: authUser.authToken,
                        ),
                      );
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
    );
  }
}
