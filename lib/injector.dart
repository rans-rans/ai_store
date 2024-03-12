import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/categories/data/datasource/firebase_category_datasource.dart';
import 'src/features/categories/data/repositories/firebase_category_repository.dart';
import 'src/features/categories/presentation/blocs/brand/brand_bloc.dart';
import 'src/features/categories/presentation/blocs/category/category_bloc.dart';
import 'src/features/home/presentation/blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import 'src/features/products/data/data_source/firebase_datasource.dart';
import 'src/features/products/data/repository/firebase_product_repository.dart';
import 'src/features/products/presentation/blocs/product/product_bloc.dart';
import 'src/features/products/presentation/blocs/products/products_bloc.dart';
import 'src/features/profile/presentation/blocs/segment_control/segment_control_cubit.dart';

class Injector extends StatelessWidget {
  final Widget child;
  const Injector({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseDataSource = FirebaseDataSource();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationCubit(),
        ),
        BlocProvider(
          create: (context) => CollectionsSegmentControl(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(
            FirebaseProductRepository(productsDataSource: firebaseDataSource),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            FirebaseProductRepository(productsDataSource: firebaseDataSource),
          ),
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
      ],
      child: child,
    );
  }
}
