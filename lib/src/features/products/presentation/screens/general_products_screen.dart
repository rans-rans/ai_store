import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../search/presentation/screens/open_camera_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../blocs/products/products_bloc.dart';
import '/src/features/home/presentation/widgets/spaced_row_widget.dart';
import '../../../../constants/numbers.dart'
    show
        cardBorderRadius,
        defaultPadding,
        mediumFontSize,
        mediumFontWeight,
        mediumSpacing,
        smallSpacing;
import '../../../home/presentation/widgets/popular_card_widget.dart';
import '../../../home/presentation/widgets/product_card.dart';

class GeneralProductsScreen extends StatelessWidget {
  const GeneralProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
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
                  builder: (_) {
                    return const SearchScreen();
                  },
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
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<ProductsBloc>().add(GetProducts());
        },
        child: Padding(
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //TODO top four popular categories come here
                    children: [
                      PopularCardWidget(),
                      PopularCardWidget(),
                      PopularCardWidget(),
                      PopularCardWidget(),
                    ],
                  ).withSpacing(axis: Axis.horizontal),
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
                          itemCount: state.products.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: size.width * 0.05,
                            mainAxisSpacing: size.height * 0.05,
                          ),
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: state.products[index],
                            );
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
