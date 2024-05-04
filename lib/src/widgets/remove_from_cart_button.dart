import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/cart/presentation/bloc/cart/cart_bloc.dart';

class RemoveFromCartButton extends StatelessWidget {
  const RemoveFromCartButton({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        //TODO change to  dynamic id
        context.read<CartBloc>().removeProductFromCart(
              productId: productId,
              userId: 3,
            );
      },
      child: Text(
        "Remove",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
