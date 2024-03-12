import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';

class BrandProductsScreen extends StatelessWidget {
  final String brandName;

  const BrandProductsScreen({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brandName),
      ),
      body: FutureBuilder(
          future: context.read<ProductsBloc>().fetchProductsByBrand(brandName),
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
