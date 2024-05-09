import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../constants/numbers.dart';
import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../data/data_source/products_datasource.dart';
import '../blocs/product/product_bloc.dart';

class RatingSheet extends StatefulWidget {
  final int productId;
  const RatingSheet({
    required this.productId,
    super.key,
  });

  @override
  State<RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<RatingSheet> {
  final ratingValue = ValueNotifier(0.0);
  final commentCtrl = TextEditingController();
  Rating? rating;
  late AuthUser user;
  final canSheetPop = ValueNotifier(true);

  void showRatingFeedback(bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "Rating successful" : 'Try again. Action failed',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: success
            ? const Color.fromARGB(255, 24, 67, 25)
            : const Color.fromARGB(255, 114, 32, 26),
      ),
    );
  }

  void completeRating() async {
    FocusScope.of(context).unfocus();
    rating = Rating(
      productId: widget.productId,
      userId: user.userId,
      comment: commentCtrl.text,
      score: ratingValue.value.toInt(),
      dateCreated: DateTime.now().toIso8601String(),
    );
    canSheetPop.value = false;
    final success = await context.read<ProductBloc>().rateProduct(
          rating: rating!,
          token: user.authToken,
        );

    showRatingFeedback(success);
    if (success) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, rating);
    }
  }

  @override
  void initState() {
    super.initState();
    user = context.read<AuthBloc>().user!;
  }

  @override
  void dispose() {
    super.dispose();
    commentCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canSheetPop.value,
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: canSheetPop,
            builder: (context, canPop, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  switch (canPop) {
                    false => const SizedBox.shrink(),
                    true => IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => Navigator.pop(context),
                      ),
                  },
                  switch (canPop) {
                    false => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    true => ValueListenableBuilder(
                        valueListenable: ratingValue,
                        builder: (context, value, child) {
                          return TextButton(
                            onPressed: switch (value == 0.0) {
                              true => null,
                              false => completeRating,
                            },
                            child: Text(
                              'Rate',
                              style: TextStyle(
                                color: switch (value == 0.0) {
                                  true => null,
                                  false => Theme.of(context).primaryColor,
                                },
                              ),
                            ),
                          );
                        }),
                  },
                ],
              );
            },
          ),
          RatingBar.builder(
            minRating: 1,
            itemCount: 5,
            initialRating: ratingValue.value,
            itemBuilder: (context, _) {
              return Icon(
                Icons.star,
                color: Theme.of(context).primaryColor,
              );
            },
            onRatingUpdate: (value) {
              ratingValue.value = value;
            },
          ),
          const SizedBox(
            height: mediumSpacing,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: TextField(
                controller: commentCtrl,
                textInputAction: TextInputAction.done,
                expands: true,
                maxLines: null,
                maxLength: 100,
                minLines: null,
                decoration: const InputDecoration(
                  hintText: 'Describe your experience(optional)',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
