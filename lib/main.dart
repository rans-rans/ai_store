import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show MultiBlocProvider, BlocProvider;

import 'src/constants/colors.dart' show darkTheme, lightTheme;
import 'src/features/home/presentation/blocs/bottom_nav_cubit/bottom_navigation_cubit.dart';
import 'src/features/home/presentation/screens/home_controller_screen.dart';

void main() {
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
      ],
      child: MaterialApp(
        home: const HomeControllerScreen(),
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
