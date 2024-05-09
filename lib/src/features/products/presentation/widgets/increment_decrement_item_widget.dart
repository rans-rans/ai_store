import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../cart/domain/entities/cart.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';

class IncrementDecrementItemWidget extends StatelessWidget {
  const IncrementDecrementItemWidget({
    super.key,
    required this.cartProduct,
    required this.productId,
    required this.productQuantity,
  });

  final CartItem cartProduct;
  final int productId;
  final int productQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //the decrement button
        IconButton(
          onPressed: switch (cartProduct.quantity > 1) {
            false => null,
            true => () async {
                if (cartProduct.quantity <= 1) return;
                final user = context.read<AuthBloc>().user;
                context.read<CartBloc>().add(
                      ChangeItemQuantityEvent(
                        userId: user!.userId,
                        quantity: cartProduct.quantity - 1,
                        productId: productId,
                        token: user.authToken,
                      ),
                    );
              }
          },
          icon: const Icon(Icons.remove),
        ),
        //the item quantity
        Text(cartProduct.quantity.toString()),

        //the increment button
        IconButton(
          onPressed: () async {
            final user = context.read<AuthBloc>().user;
            if (cartProduct.quantity >= productQuantity) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Not enough in stock for you"),
                ),
              );
            }
            context.read<CartBloc>().add(
                  ChangeItemQuantityEvent(
                    userId: user!.userId,
                    token: user.authToken,
                    quantity: cartProduct.quantity + 1,
                    productId: productId,
                  ),
                );
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
