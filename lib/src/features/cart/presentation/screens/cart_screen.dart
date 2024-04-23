import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/api_constants.dart';
import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../checkout/presentation/screens/checkout_screen.dart';
import '../../domain/entities/cart.dart';
import '../bloc/cart/cart_bloc.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Cart? cart;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<CartBloc>().listenToCart(userId: dummyUserId),
      builder: (context, snapshot) {
        cart = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text("My Cart(${cart?.products.length ?? 0})"),
          ),
          body: SingleChildScrollView(
            primary: true,
            child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: switch (cart == null || cart!.products.isEmpty) {
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
                            itemCount: cart!.products.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CartItemWidget(
                                cartItem: cart!.products[index],
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
                              page: CheckoutScreen(cart: cart!),
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
          ),
        );
      },
    );
  }
}
