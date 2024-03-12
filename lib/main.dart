import 'package:ai_store/src/features/products/presentation/blocs/products/products_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show MultiBlocProvider, BlocProvider;

import 'firebase_options.dart';
import 'src/constants/colors.dart' show darkTheme, lightTheme;
import 'src/features/home/presentation/blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import 'src/features/home/presentation/screens/home_controller_screen.dart';
import 'src/features/products/data/data_source/firebase_datasource.dart';
import 'src/features/products/data/repository/firebase_product_repository.dart';
import 'src/features/products/presentation/blocs/product/product_bloc.dart';
import 'src/features/profile/presentation/blocs/segment_control/segment_control_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
            FirebaseProductRepository(productsDataSource: FirebaseDataSource()),
          ),
        ),
        BlocProvider(
          create: (context) => ProductBloc(
            FirebaseProductRepository(productsDataSource: FirebaseDataSource()),
          ),
        ),
      ],
      child: MaterialApp(
        home: const HomeControllerScreen(),
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        // themeMode: ThemeMode.dark,
      ),
    );
  }
}
