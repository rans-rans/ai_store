import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../../../widgets/remove_from_cart_button.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/entities/cart.dart';
import '../bloc/cart/cart_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnlineImage(
            image: cartItem.imageUrl,
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
                  cartItem.productName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: mediumFontWeight,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: switch (cartItem.quantity <= 1) {
                      true => null,
                      false => () {
                          final user = context.read<AuthBloc>().user;
                          context.read<CartBloc>().add(
                                ChangeItemQuantityEvent(
                                  token: user!.authToken,
                                  userId: user.userId,
                                  quantity: cartItem.quantity - 1,
                                  productId: cartItem.productId,
                                ),
                              );
                        },
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  //item quantity over here
                  Text(cartItem.quantity.toString()),
                  IconButton(
                    onPressed: () {
                      final user = context.read<AuthBloc>().user;
                      context.read<CartBloc>().add(
                            ChangeItemQuantityEvent(
                              userId: user!.userId,
                              token: user.authToken,
                              quantity: cartItem.quantity + 1,
                              productId: cartItem.productId,
                            ),
                          );
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              //item price over here
              Text(
                HelperFunctions.formatToCurrency(cartItem.productPrice * cartItem.quantity),
                style: const TextStyle(
                  fontSize: mediumFontSize,
                  fontWeight: boldestFontWeight,
                ),
              ),
              // const Spacer(),
              RemoveFromCartButton(
                productId: cartItem.productId,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
