import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

import '../../../../constants/strings.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../categories/presentation/blocs/brand/brand_bloc.dart';
import '../../../categories/presentation/blocs/category/category_bloc.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import '../../../categories/presentation/screens/all_categories_screen.dart';
import '../../../products/presentation/screens/general_products_screen.dart';

class HomeControllerScreen extends StatefulWidget {
  const HomeControllerScreen({super.key});

  @override
  State<HomeControllerScreen> createState() => _HomeControllerScreenState();
}

class _HomeControllerScreenState extends State<HomeControllerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(FetchProducts());
    context.read<CategoryBloc>().add(FetchAllCategories());
    context.read<BrandBloc>().add(FetchAllBrandsEvent());
  }

  @override
  Widget build(BuildContext context) {
    const screens = [
      GeneralProductsScreen(),
      AllCategoriesScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state,
            children: screens,
          ),
          bottomNavigationBar: NavigationBar(
            indicatorColor: Theme.of(context).primaryColor,
            selectedIndex: state,
            onDestinationSelected: (index) {
              if (state == index) return;
              context.read<BottomNavigationCubit>().changeTab(index);
            },
            destinations: const [
              NavigationDestination(
                icon: ImageIcon(AssetImage(homeIcon)),
                label: "Home",
              ),
              NavigationDestination(
                icon: ImageIcon(AssetImage(categoriesIcon)),
                label: "Categories",
              ),
              NavigationDestination(
                icon: ImageIcon(AssetImage(cartIcon)),
                label: "Cart",
              ),
              NavigationDestination(
                icon: ImageIcon(AssetImage(profileIcon)),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
