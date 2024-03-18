import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/api_constants.dart';
import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../domain/entities/cart.dart';
import '../bloc/cart/cart_bloc.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double getTotalAmount(List<CartItem> products) {
      double total = 0.0;
      for (var item in products) {
        total += (item.price * item.quantity);
      }
      return total;
    }

    return StreamBuilder(
        stream: context.read<CartBloc>().listenToCart(userId: dummyUserId),
        builder: (context, snapshot) {
          Cart? cart;
          cart = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              //TODO number of items should be here
              title: Text(
                switch (cart == null) {
                  true => "Empty",
                  false => "My Cart(${cart!.products.length})"
                },
              ),
              actions: [
                //TODO the selected drop location is selected here
                InkWell(
                  onTap: () {
                    //TODO show a list of drop locations in a dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Column(),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2)),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Row(
                          children: [
                            Text("To"),
                            SizedBox(width: smallSpacing),
                            Text(
                              "Bomso",
                              style: TextStyle(
                                fontWeight: mediumFontWeight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              primary: true,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is! CartFetchSuccess) {
                      return const Text("Check connectivity");
                    }

                    final items = state.cart.products;
                    return Column(
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
                        //TODO list of cart-items come here
                        Flexible(
                          child: ListView.builder(
                            itemCount: items.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CartItemWidget(
                                cartItem: items[index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: mediumSpacing),
                        const Text(
                          "Order Summary",
                          style: TextStyle(
                            fontWeight: mediumFontWeight,
                          ),
                        ),
                        const SizedBox(height: smallSpacing),
                        //TODO put cart summary here
                        Table(
                          children: [
                            TableRow(
                              children: [
                                const Text("Items"),
                                Text(items.length.toString()),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text("Total cost"),
                                Text(
                                  HelperFunctions.formatToCurrency(
                                      getTotalAmount(items)),
                                  style: const TextStyle(
                                    fontWeight: mediumFontWeight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: mediumSpacing * 2.5,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(buttonBorderRadius)),
                            ),
                            onPressed: () {
                              //TODO continue function for checkout
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Checkout for ",
                                  ),
                                  TextSpan(
                                    text: HelperFunctions.formatToCurrency(
                                        getTotalAmount(items)),
                                    style: const TextStyle(
                                      fontWeight: boldestFontWeight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
