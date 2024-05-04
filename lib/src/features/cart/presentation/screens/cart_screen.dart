import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../checkout/presentation/screens/checkout_screen.dart';

import '../bloc/cart/cart_bloc.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(switch (state) {
                CartFetchSuccess() => "My Cart(${state.cart.products.length})",
                _ => 'Cart Unavailable',
              }),
            ),
            body: switch (state) {
              CartFetchFailed() || CartInitial() => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Cart unavailable"),
                      ElevatedButton(
                        child: const Text('Retry'),
                        onPressed: () {
                          //TODO  use dynamic id
                          context.read<CartBloc>().add(
                                GetUserCart(userId: 3),
                              );
                        },
                      )
                    ],
                  ),
                ),
              CartFetchLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              CartFetchSuccess() => SingleChildScrollView(
                  primary: true,
                  child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: switch (state.cart.products.isEmpty) {
                        true => const Center(
                            child: Text("Empty Cart"),
                          ),
                        false => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Items",
                                style: TextStyle(
                                  fontSize: mediumFontSize,
                                  fontWeight: mediumFontWeight,
                                ),
                              ),
                              const SizedBox(
                                height: smallSpacing,
                              ),
                              Flexible(
                                child: ListView.builder(
                                  itemCount: state.cart.products.length,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return CartItemWidget(
                                      cartItem: state.cart.products[index],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: mediumSpacing),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(double.infinity, 55),
                                    backgroundColor: Theme.of(context).primaryColor),
                                onPressed: () {
                                  HelperFunctions.gotoPage(
                                    context: context,
                                    page: CheckoutScreen(cart: state.cart),
                                  );
                                },
                                child: const Text(
                                  'Procced',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                      }),
                )
            });
      },
    );
  }
}
