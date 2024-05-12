import 'package:flutter/material.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../domain/entities/order.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ID:${order.orderId.toString().padRight(8, '0')}",
        ),
      ),
      body: ListView.builder(
        itemCount: order.cart.products.length,
        itemBuilder: (context, index) {
          final item = order.cart.products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnlineImage(
                  image: item.imageUrl,
                  width: screenSize.width * 0.4,
                ),
                const SizedBox(width: smallSpacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //cart item name over here
                    SizedBox(
                      width: screenSize.width * 0.5,
                      child: Text(
                        item.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: mediumFontWeight,
                        ),
                      ),
                    ),
                    Text(
                      item.itemVariation,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    //item price over here
                    Text(
                      HelperFunctions.formatToCurrency(
                          item.productPrice * item.quantity),
                      style: const TextStyle(
                        fontSize: mediumFontSize,
                        fontWeight: boldestFontWeight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
