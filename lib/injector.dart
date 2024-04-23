import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/cart/data/data_source/supabase_cart_datasource.dart';
import 'src/features/cart/data/repository/supabase_cart_repository.dart';
import 'src/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'src/features/categories/data/datasource/supabase_category_datasource.dart';
import 'src/features/categories/data/repositories/supabase_category_repository.dart';
import 'src/features/categories/presentation/blocs/brand/brand_bloc.dart';
import 'src/features/categories/presentation/blocs/category/category_bloc.dart';
import 'src/features/checkout/data/datasource/paystack_datasource.dart';
import 'src/features/checkout/data/repository/supabase_checkout_repository.dart';
import 'src/features/checkout/presentation/blocs/cubit/checkout_cubit.dart';
import 'src/features/products/data/data_source/supabase_products_datasource.dart';
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
        SupabaseProductRepository(productsDataSource: SupabaseProductsDatasource());
    final supabaseCategoryRepository =
        SupabaseCategoryRepository(categoryDatasource: SupabaseCategoryDatasource());
    final supabaseCartRepository =
        SupabaseCartRepository(cartDatasource: SupabaseCartDatasource());
    final checkoutRepository = SupabaseCheckoutRepository(
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
          create: (context) => ProductsBloc(supabaseProductsRepository),
        ),
        BlocProvider(
          create: (context) => ProductBloc(supabaseProductsRepository),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            SupabaseCategoryRepository(
                categoryDatasource: SupabaseCategoryDatasource()),
          ),
        ),
        BlocProvider(
          create: (context) =>
              BrandBloc(categoryRepository: supabaseCategoryRepository),
        ),
        BlocProvider(
          create: (context) => CartBloc(supabaseCartRepository),
        ),
      ],
      child: child,
    );
  }
}
