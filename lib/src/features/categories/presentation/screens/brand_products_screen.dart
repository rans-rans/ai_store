import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../../../widgets/online_image.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../../../products/presentation/screens/product_detail_screen.dart';
import '../../domain/entities/brand.dart';

class BrandProductsScreen extends StatelessWidget {
  final Brand brand;

  const BrandProductsScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final user = context.read<AuthBloc>().user!;
    return Scaffold(
      appBar: AppBar(
        title: Text(brand.name),
      ),
      body: FutureBuilder(
          future: context
              .read<ProductsBloc>()
              .fetchProductsByBrand(brand.id, user.userId, user.authToken),
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
                        page: ProductDetailScreen(
                          productId: product.productId,
                        ));
                  },
                  leading: OnlineImage(
                    image: product.image,
                    width: screenSize.width * 0.25,
                  ),
                  title: Text(
                    product.name,
                    maxLines: 2,
                  ),
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
                  // subtitle: Text(
                  //   product.description,
                  //   maxLines: 1,
                  //   style: const TextStyle(color: Colors.grey),
                  // ),
                );
              },
            );
          }),
    );
  }
}
