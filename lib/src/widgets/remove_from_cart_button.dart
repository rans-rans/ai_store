import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../features/cart/presentation/bloc/cart/cart_bloc.dart';

class RemoveFromCartButton extends StatelessWidget {
  const RemoveFromCartButton({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().user;
    return TextButton(
      onPressed: () {
        context.read<CartBloc>().removeProductFromCart(
            productId: productId, userId: user!.userId, token: user.authToken);
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
