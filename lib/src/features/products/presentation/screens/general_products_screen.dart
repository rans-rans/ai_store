import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/presentation/blocs/category/category_bloc.dart';
import '../../../home/presentation/widgets/product_card_widget.dart';
import '../../../search/presentation/screens/open_camera_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../blocs/products/products_bloc.dart';
import '../../../../constants/numbers.dart'
    show
        cardBorderRadius,
        defaultPadding,
        mediumFontSize,
        mediumFontWeight,
        mediumSpacing,
        smallSpacing;
import '../../../home/presentation/widgets/popular_card_widget.dart';

class GeneralProductsScreen extends StatelessWidget {
  const GeneralProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<ProductsBloc>().add(FetchProducts());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 40,
          title: const Text("AI STORE"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SearchScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(cardBorderRadius),
                  ),
                  child: Row(
                    children: [
                      const Text("Search"),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.camera_enhance_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const OpenCameraScreen();
                              },
                            ),
                          );
                        },
                        iconSize: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Popular Categories",
                  style: TextStyle(
                    fontWeight: mediumFontWeight,
                    fontSize: mediumFontSize,
                  ),
                ),
                const SizedBox(height: smallSpacing),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    return switch (state) {
                      CategoriesInitial() => const Text("Categories unavailable"),
                      CategoriesFetchLoading() => const Text("Categories loading"),
                      CategoriesFetchFailed() => const Text("Check your connection"),
                      CategoriesFetchSuccess() => SizedBox(
                          height: size.height * 0.25,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PopularCardWidget(
                                  category: state.categories[index],
                                ),
                              );
                            },
                          ),
                        )
                    };
                  },
                ),
                const SizedBox(height: mediumSpacing),
                //TODO  place recently view products here
                const SizedBox(height: mediumSpacing),
                const Text(
                  "Explore",
                  style: TextStyle(
                    fontWeight: mediumFontWeight,
                  ),
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    return switch (state) {
                      ProductsInitial() =>
                        const Center(child: Text("Products Unavailable")),
                      ProductsError() =>
                        const Center(child: Text("Network unavailable")),
                      ProductsLoading() => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ProductsSuccess() => GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: state.products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: size.width * 0.05,
                            mainAxisExtent: size.height * 0.25,
                            mainAxisSpacing: size.height * 0.05,
                          ),
                          itemBuilder: (context, index) {
                            return ProductCardWidget(product: state.products[index]);
                          },
                        )
                    };
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
