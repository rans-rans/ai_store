import 'package:ai_store/src/constants/numbers.dart';
import 'package:ai_store/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:ai_store/src/features/products/presentation/blocs/products/products_bloc.dart';
import 'package:ai_store/src/features/products/presentation/screens/product_detail_screen.dart';
import 'package:ai_store/src/utils/helper_functions.dart';
import 'package:ai_store/src/widgets/online_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageSearchResultScreen extends StatefulWidget {
  final int categoryId;
  const ImageSearchResultScreen({required this.categoryId, super.key});

  @override
  State<ImageSearchResultScreen> createState() => _ImageSearchResultScreenState();
}

class _ImageSearchResultScreenState extends State<ImageSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Search result"),
      ),
      body: FutureBuilder(
          future: context
              .read<ProductsBloc>()
              .fetchProductsByCategory(widget.categoryId, user.authToken),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final products = snapshot.data ?? [];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      HelperFunctions.gotoPage(
                        context: context,
                        page: ProductDetailScreen(productId: product.productId),
                      );
                    },
                    leading: OnlineImage(
                      image: product.image,
                      width: 150,
                      height: 250,
                    ),
                    title: Text(product.name),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            HelperFunctions.formatToCurrency(
                              product.price,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration:
                                  product.discount > 0 ? TextDecoration.lineThrough : null,
                            )),
                        if (product.discount > 0)
                          Text(
                            HelperFunctions.getDiscountAmount(
                              product.price,
                              product.discount,
                            ),
                            style: const TextStyle(
                              fontWeight: mediumFontWeight,
                            ),
                          ),
                      ],
                    ),
                    // subtitle: Text(
                    //   product.description,
                    //   maxLines: 3,
                    // ),
                    // isThreeLine: true,
                  ),
                );
              },
            );
          }),
    );
  }
}
