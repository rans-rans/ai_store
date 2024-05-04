import 'package:flutter/material.dart';
import 'injector.dart';
import 'src/constants/colors.dart' show darkTheme, lightTheme;
import 'src/features/home/presentation/screens/home_controller_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Injector(
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
