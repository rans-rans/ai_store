import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

import '../../../../constants/strings.dart';
import '../../../auth/domain/entities/auth_user.dart';
import '../../../auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../categories/presentation/blocs/brand/brand_bloc.dart';
import '../../../categories/presentation/blocs/category/category_bloc.dart';
import '../../../products/presentation/blocs/products/products_bloc.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../categories/presentation/screens/all_categories_screen.dart';
import '../../../products/presentation/screens/general_products_screen.dart';

class HomeControllerScreen extends StatefulWidget {
  final AuthUser user;
  const HomeControllerScreen(this.user, {super.key});

  @override
  State<HomeControllerScreen> createState() => _HomeControllerScreenState();
}

class _HomeControllerScreenState extends State<HomeControllerScreen> {
  int currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    final user = widget.user;
    context.read<AuthBloc>().add(FetchUser(user));
    context.read<ProductsBloc>().add(FetchProducts(token: user.authToken));
    context.read<CategoryBloc>().add(FetchAllCategories(user.authToken));
    context.read<BrandBloc>().add(FetchAllBrandsEvent(user.authToken));
    context
        .read<CartBloc>()
        .add(GetUserCart(userId: user.userId, token: user.authToken));
  }

  @override
  Widget build(BuildContext context) {
    const screens = [
      GeneralProductsScreen(),
      AllCategoriesScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: currentTabIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).primaryColor,
        selectedIndex: currentTabIndex,
        onDestinationSelected: (index) {
          if (currentTabIndex == index) return;
          setState(() {
            currentTabIndex = index;
          });
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
  }
}
