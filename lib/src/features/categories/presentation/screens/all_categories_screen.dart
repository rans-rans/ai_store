import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../../../utils/helper_functions.dart';
import '../../domain/entities/category.dart';
import '../blocs/category/category_bloc.dart';
import '../widgets/categories_list.dart';
import '../widgets/category_tag_card.dart';
import 'category_products_screen.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController heightAnimationController;
  late Animation<double> topContainerAnimation;

  Category? selectedCategory;

  late Size screenSize;

  final heightTransitionDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    heightAnimationController = AnimationController(
      vsync: this,
      duration: heightTransitionDuration,
    );
  }

  @override
  void dispose() {
    super.dispose();
    heightAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    topContainerAnimation = Tween(
      // 41 is just a lucky number i figured out from try and error. It works perfect for all screens
      // Don't tell me it's a hardcoded value
      begin: MediaQuery.paddingOf(context).top + 41,
      end: screenSize.height -
          (MediaQuery.paddingOf(context).bottom - kBottomNavigationBarHeight),
    ).animate(heightAnimationController);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: const CategoriesList(),
        ),
        AnimatedBuilder(
          animation: topContainerAnimation,
          builder: (context, child) {
            return Container(
              color: Colors.grey.shade200,
              height: topContainerAnimation.value,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.paddingOf(context).top),
                  Row(
                    children: [
                      const Spacer(),
                      const Text(
                        "AI STORE",
                        style: TextStyle(
                          fontSize: mediumFontSize,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: toggleDrawer,
                        child: const Icon(
                          Icons.menu,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        return switch (state) {
                          CategoriesFetchLoading() => const Center(
                              child: CircularProgressIndicator.adaptive()),
                          CategoriesFetchSuccess() => GridView.builder(
                              itemCount: state.categories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 100,
                              ),
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                return CategoryTagCard(
                                  category: category,
                                  onTap: () {
                                    toggleDrawer();
                                    HelperFunctions.gotoPage(
                                      context: context,
                                      page:
                                          CategoryProductsScreen(category: category),
                                    );
                                  },
                                );
                              },
                            ),
                          _ => Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<CategoryBloc>()
                                      .add(FetchAllCategories());
                                },
                                child: const Text("Reload"),
                              ),
                            ),
                        };
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void toggleDrawer() {
    if (heightAnimationController.isCompleted) {
      heightAnimationController.reverse();
    } else {
      heightAnimationController.forward();
    }
  }
}
