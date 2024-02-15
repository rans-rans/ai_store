import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

import '../../../cart/presentation/screens/cart_screen.dart';
import '../blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import 'categories_screen.dart';
import 'home_screen.dart';

class HomeControllerScreen extends StatelessWidget {
  const HomeControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const screens = [
      HomeScreen(),
      CategoriesScreen(),
      CartScreen(),
      Text("Profile"),
    ];
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: BlocBuilder<BottomNavigationCubit, int>(
            builder: (context, state) {
              return screens[state];
            },
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
