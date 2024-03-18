import 'package:ai_store/src/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/cart/presentation/bloc/cart/cart_bloc.dart';

class RemoveFromCartButton extends StatelessWidget {
  const RemoveFromCartButton({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<CartBloc>().add(
              RemoveProductFromCartEvent(
                userId: dummyUserId,
                productId: id,
              ),
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
