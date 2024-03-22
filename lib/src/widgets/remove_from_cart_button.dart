import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/api_constants.dart';
import '../features/cart/presentation/bloc/cart/cart_bloc.dart';

class RemoveFromCartButton extends StatelessWidget {
  const RemoveFromCartButton({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<CartBloc>().removeProductFromCart(
              productId: productId,
              userId: dummyUserId,
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
