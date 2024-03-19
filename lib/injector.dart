import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/cart/data/data_source/firebase_cart_datasource.dart';
import 'src/features/cart/data/repository/firebase_cart_repository.dart';
import 'src/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'src/features/categories/data/datasource/firebase_category_datasource.dart';
import 'src/features/categories/data/repositories/firebase_category_repository.dart';
import 'src/features/categories/presentation/blocs/brand/brand_bloc.dart';
import 'src/features/categories/presentation/blocs/category/category_bloc.dart';
import 'src/features/home/presentation/blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import 'src/features/products/data/data_source/supabase_datasource.dart';
import 'src/features/products/data/repository/supabase_product_repository.dart';
import 'src/features/products/presentation/blocs/product/product_bloc.dart';
import 'src/features/products/presentation/blocs/products/products_bloc.dart';
import 'src/features/profile/presentation/blocs/segment_control/segment_control_cubit.dart';

class Injector extends StatelessWidget {
  final Widget child;
  const Injector({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final supabaseProductsRepository =
        SupabaseProductRepository(productsDataSource: SupabaseDatasource());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationCubit(),
        ),
        BlocProvider(
          create: (context) => CollectionsSegmentControl(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(supabaseProductsRepository),
        ),
        BlocProvider(
          create: (context) => ProductBloc(supabaseProductsRepository),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            FirebaseCategoryRepository(
                categoryDatasource: FirebaseCategoryDatasource()),
          ),
        ),
        BlocProvider(
          create: (context) => BrandBloc(
            categoryRepository: FirebaseCategoryRepository(
                categoryDatasource: FirebaseCategoryDatasource()),
          ),
        ),
        BlocProvider(
            create: (context) => CartBloc(
                  FirebaseCartRepository(
                    cartDatasource: FirebaseCartDatasource(),
                  ),
                )),
      ],
      child: child,
    );
  }
}
