import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';
import '../../domain/entities/category.dart';

class CategoryProductsScreen extends StatelessWidget {
  final Category category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().state as AuthAvailable;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: FutureBuilder(
          future: context.read<ProductsBloc>().fetchProductsByCategory(
              category.id, user.authUser.userId, user.authUser.authToken),
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
                return ListTile(
                  onTap: () {
                    HelperFunctions.gotoPage(
                      context: context,
                      page: ProductDetailScreen(product: product),
                    );
                  },
                  leading: OnlineImage(image: product.images.first),
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
                            decoration: product.discount > 0
                                ? TextDecoration.lineThrough
                                : null,
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
                  subtitle: Text(
                    product.description,
                    maxLines: 3,
                  ),
                  isThreeLine: true,
                );
              },
            );
          }),
    );
  }
}
