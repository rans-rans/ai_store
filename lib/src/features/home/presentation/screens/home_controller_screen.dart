import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

import '../blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import 'home_screen.dart';

class HomeControllerScreen extends StatelessWidget {
  const HomeControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndexNotifier = ValueNotifier(0);
    const screens = [
      HomeScreen(),
      Text("Categories"),
      Text("Orders"),
      Text("Profile"),
    ];
    return Scaffold(
      body: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return screens[state];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (context, selectedIndex, child) {
            return NavigationBar(
              indicatorColor: Theme.of(context).primaryColor,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                context.read<BottomNavigationCubit>().changeTab(index);
                selectedIndexNotifier.value = index;
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
            );
          }),
    );
  }
}
