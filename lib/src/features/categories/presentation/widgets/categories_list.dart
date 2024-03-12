import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../blocs/brand/brand_bloc.dart';
import 'brand_chip.dart';
import 'categories_just_for_you_widget.dart';
import '../../../home/presentation/widgets/product_card_widget.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 41),
          // TODO  category name comes here
          const Text(
            "Brands",
            style: TextStyle(fontSize: mediumFontSize),
          ),

          const SizedBox(height: mediumSpacing * 2),
          //TODO  sub-categories comes here
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
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is! ProductsSuccess) return const SizedBox.shrink();
              final promotionalProducts =
                  state.products.where((product) => product.discount > 0).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      itemCount: promotionalProducts.length < 50
                          ? promotionalProducts.length
                          : 50,
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
              );
            },
          ),
          const SizedBox(height: mediumSpacing),
          const Text(
            "Under ₵50",
            style: TextStyle(
              fontWeight: mediumFontWeight,
              fontSize: mediumFontSize,
            ),
          ),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is! ProductsSuccess) {
                return const SizedBox.shrink();
              }
              final items =
                  state.products.where((item) => item.price <= 50).toList();
              return GridView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: items.length < 25 ? items.length : 25,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                  crossAxisSpacing: screenSize.width * 0.05,
                ),
                itemBuilder: (context, index) {
                  return CategoriesJustForYouWidget(
                    product: items[index],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
