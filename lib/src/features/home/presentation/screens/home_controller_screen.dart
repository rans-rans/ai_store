import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import 'categories_screen.dart';
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
    context.read<ProductsBloc>().add(GetProducts());
  }

  @override
  Widget build(BuildContext context) {
    const screens = [
      GeneralProductsScreen(),
      CategoriesScreen(),
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
                icon: Icon(Icons.home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.category_outlined),
                label: "Categories",
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
