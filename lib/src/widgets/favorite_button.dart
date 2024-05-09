import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/domain/entities/auth_user.dart';
import '../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../features/products/presentation/blocs/product/product_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final int productId;
  final bool isFavorite;
  const FavoriteButton({
    super.key,
    required this.productId,
    required this.isFavorite,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late AuthUser authUser;

  bool favoriteLoading = false;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    authUser = context.read<AuthBloc>().user!;
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, snap) {
        return CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white30,
          child: switch (favoriteLoading) {
            true => const CircularProgressIndicator(),
            false => IconButton(
                onPressed: () async {
                  snap(() => favoriteLoading = true);
                  try {
                    final fav = await context.read<ProductBloc>().toggleFavorite(
                          userId: authUser.userId,
                          productId: widget.productId,
                          token: authUser.authToken,
                        );
                    isFavorite = fav;
                  } finally {
                    snap(() => favoriteLoading = false);
                  }
                },
                icon: Icon(
                  switch (isFavorite) {
                    true => Icons.favorite,
                    false => Icons.favorite_border,
                  },
                  size: 40,
                  color: switch (isFavorite) {
                    true => Theme.of(context).primaryColor,
                    false => Theme.of(context).colorScheme.secondary,
                  },
                ),
              ),
          },
        );
      },
    );
  }
}
