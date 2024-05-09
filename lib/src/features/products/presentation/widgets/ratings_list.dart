import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../data/data_source/products_datasource.dart';
import '../blocs/product/product_bloc.dart';
import 'rating_tile.dart';

class RatingsList extends StatefulWidget {
  const RatingsList({
    super.key,
    required this.ratings,
    required this.productId,
  });

  final ValueNotifier<List<Rating>> ratings;
  final int productId;

  @override
  State<RatingsList> createState() => _RatingsListState();
}

class _RatingsListState extends State<RatingsList> {
  late AuthUser user;

  Future<List<Rating>> fetchRatigs() async {
    return await context.read<ProductBloc>().fetchProductRatings(
          token: user.authToken,
          productId: widget.productId,
        );
  }

  @override
  void initState() {
    super.initState();
    user = context.read<AuthBloc>().user!;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      height: screenSize.height * 0.75,
      child: switch (widget.ratings.value.any((e) => e.userId == user.userId)) {
        true => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingTile(
                  rating: widget.ratings.value.firstWhere(
                    (e) => e.productId == widget.productId,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<ProductBloc>()
                        .removeProductRating(
                          productId: widget.productId,
                          userId: user.userId,
                          token: user.authToken,
                        )
                        .then((removed) {
                      if (removed) {
                        widget.ratings.value
                            .removeWhere((e) => e.productId == widget.productId);
                      }
                      if (mounted) {
                        setState(() {});
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        false => FutureBuilder(
            initialData: widget.ratings.value,
            future: fetchRatigs(),
            builder: (context, snapshot) {
              widget.ratings.value = snapshot.data ?? [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ValueListenableBuilder(
                valueListenable: widget.ratings,
                builder: (context, ratings, child) {
                  return ListView.builder(
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      return RatingTile(rating: ratings[index]);
                    },
                  );
                },
              );
            },
          ),
      },
    );
  }
}
