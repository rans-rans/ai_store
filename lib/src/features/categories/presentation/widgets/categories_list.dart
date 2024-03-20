import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../blocs/brand/brand_bloc.dart';
import 'brand_chip.dart';
import 'categories_just_for_you_widget.dart';
import '../../../home/presentation/widgets/product_card_widget.dart';

class CategoriesList extends StatelessWidget {
  final String categoryId;
  const CategoriesList({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      primary: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 41),
          const Text(
            "Brands",
            style: TextStyle(fontSize: mediumFontSize),
          ),
          const SizedBox(height: mediumSpacing * 2),
          SizedBox(
            height: screenSize.height * 0.2,
            child: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                if (state is! BrandsFetchSuccess) {
                  return const SizedBox.shrink();
                }
                return GridView.builder(
                  itemCount: state.brands.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    mainAxisExtent: screenSize.width * 0.15,
                    crossAxisSpacing: screenSize.height * 0.01,
                  ),
                  itemBuilder: (context, index) {
                    final brand = state.brands[index];
                    return BrandChip(brand: brand);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: mediumSpacing * 3),
          FutureBuilder(
            future: context.read<ProductsBloc>().fetchProductsByCategory(categoryId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Loading'));
              }
              if (snapshot.data == null) {
                return const Center(child: Text('Error occurred'));
              }
              final products = snapshot.data!;

              if (products.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              }

              final promotionalProducts =
                  products.where((product) => product.discount > 0).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (promotionalProducts.isNotEmpty)
                    Column(
                      children: [
                        const Text(
                          "Limited time deals",
                          style: TextStyle(
                            fontSize: mediumFontSize,
                            fontWeight: mediumFontWeight,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.27,
                          child: ListView.builder(
                            itemCount: promotionalProducts.length,
                            itemExtent: screenSize.width * 0.42,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ProductCardWidget(
                                product: promotionalProducts[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  GridView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                      crossAxisSpacing: screenSize.width * 0.05,
                    ),
                    itemBuilder: (context, index) {
                      return CategoriesJustForYouWidget(
                        product: products[index],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
