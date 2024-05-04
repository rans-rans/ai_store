import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/cart/data/data_source/express_cart_datasource.dart';
import 'src/features/cart/data/repository/express_cart_repo.dart';
import 'src/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'src/features/categories/data/datasource/express_category_datasource.dart';
import 'src/features/categories/data/repositories/express_category_repo.dart';
import 'src/features/categories/presentation/blocs/brand/brand_bloc.dart';
import 'src/features/categories/presentation/blocs/category/category_bloc.dart';
import 'src/features/checkout/data/datasource/paystack_datasource.dart';
import 'src/features/checkout/data/repository/express_checkout_repo.dart';
import 'src/features/checkout/presentation/blocs/cubit/checkout_cubit.dart';
import 'src/features/products/data/data_source/express_products_datasource.dart';
import 'src/features/products/data/repository/express_products_repository.dart';
import 'src/features/products/presentation/blocs/product/product_bloc.dart';
import 'src/features/products/presentation/blocs/products/products_bloc.dart';
import 'src/features/profile/presentation/blocs/segment_control/segment_control_cubit.dart';

class Injector extends StatelessWidget {
  final Widget child;
  const Injector({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    //data sources
    final categoryDatasource = ExpressCategoryDatasource();
    final productsDatasource = ExpressProductsDatasource();
    final cartDatasource = ExpressCartDatasource();
    //repostitories
    final expressProductsRepository =
        ExpressProductsRepository(datasource: productsDatasource);
    final expressCategoryRepo = ExpressCategoryRepo(datasource: categoryDatasource);
    final expressCartRepo = ExpressCartRepo(datasource: cartDatasource);
    final checkoutRepository = ExpressCheckoutRepo(
      paymentDatasource: PaystackDatasource(),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckoutCubit(checkoutRepository: checkoutRepository),
        ),
        BlocProvider(
          create: (context) => CollectionsSegmentControl(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(expressProductsRepository),
        ),
        BlocProvider(
          create: (context) => ProductBloc(expressProductsRepository),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            expressCategoryRepo,
          ),
        ),
        BlocProvider(
          create: (context) => BrandBloc(categoryRepository: expressCategoryRepo),
        ),
        BlocProvider(
          create: (context) => CartBloc(expressCartRepo),
        ),
      ],
      child: child,
    );
  }
}
