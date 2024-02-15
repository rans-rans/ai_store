import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO number of items should be here
        title: const Text(
          "My cart(3)",
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
          child: Column(
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
                  itemCount: 3,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const CartItemWidget();
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
                children: const [
                  TableRow(
                    children: [
                      Text("Items"),
                      Text("3"),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text("Total cost"),
                      Text(
                        "₵ 6,750.00",
                        style: TextStyle(
                          fontWeight: mediumFontWeight,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text("Delivery fee"),
                      Text("₵ 10.00"),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text("Discount"),
                      Text("₵ 101.00"),
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
                        borderRadius: BorderRadius.circular(buttonBorderRadius)),
                  ),
                  onPressed: () {
                    //TODO continue function for checkout
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Checkout for ",
                        ),
                        TextSpan(
                          text: "GH₵ 6,750.00",
                          style: TextStyle(
                            fontWeight: boldestFontWeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
