import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/numbers.dart';
import '../../domain/entities/category.dart';
import '../blocs/category/category_bloc.dart';
import '../widgets/categories_list.dart';
import '../widgets/category_tag_card.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController heightAnimationController;
  late Animation<double> topContainerAnimation;

  final selectedCategory = ValueNotifier<Category?>(null);

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

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        switch (state) {
          case CategoriesFetchLoading():
            return const Center(child: CircularProgressIndicator.adaptive());
          case CategoriesInitial() || CategoriesFetchFailed():
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<CategoryBloc>().add(FetchAllCategories());
                },
                child: const Text("Reload"),
              ),
            );
          case CategoriesFetchSuccess():
            final categories = state.categories;
            selectedCategory.value = categories.first;
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: ValueListenableBuilder(
                      valueListenable: selectedCategory,
                      builder: (context, selected, child) {
                        return CategoriesList(
                          categoryId: selected!.id,
                        );
                      }),
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
                              Text(
                                selectedCategory.value?.name ?? "",
                                style: const TextStyle(
                                  fontSize: mediumFontSize,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => toggleDrawer(null),
                                child: const Icon(
                                  Icons.menu,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemCount: categories.length,
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
                                    toggleDrawer(category);
                                    // HelperFunctions.gotoPage(
                                    //   context: context,
                                    //   page:
                                    //       CategoryProductsScreen(category: category),
                                    // );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
        }
      },
    );
  }

  void toggleDrawer(Category? category) {
    if (heightAnimationController.isCompleted) {
      heightAnimationController.reverse();
    } else {
      heightAnimationController.forward();
    }
    if (category != null) {
      selectedCategory.value = category;
    }
  }
}
